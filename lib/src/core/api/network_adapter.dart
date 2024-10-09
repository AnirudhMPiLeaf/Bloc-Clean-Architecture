// ignore_for_file: unnecessary_import, avoid_dynamic_calls, no_default_cases
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:teach_savvy/src/core/api/endpoints.dart';
import 'package:teach_savvy/src/core/api/exceptions.dart';
import 'package:teach_savvy/src/core/api/multipart_file_model.dart';
import 'package:teach_savvy/src/core/config/config.dart';
import 'package:teach_savvy/src/core/constants/api.dart';
import 'package:teach_savvy/src/core/data/secure_storage_helper.dart';

enum RequestType { get, post, patch, delete, put }

enum FormRequestType { raw, formData, multipartFormData }

extension RequestTypeName on RequestType {
  String get name {
    switch (this) {
      case RequestType.delete:
        return 'DELETE';
      case RequestType.get:
        return 'GET';
      case RequestType.patch:
        return 'PATCH';
      case RequestType.post:
        return 'POST';
      case RequestType.put:
        return 'PUT';
    }
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  ExpiredTokenRetryPolicy(this.baseUrl, this.resetUser);
  final String baseUrl;
  final VoidCallback resetUser;

  @override
  Future<bool> shouldAttemptRetryOnResponse(http.BaseResponse response) async {
    final secureStorage = getIt<SecureStorageHelper>();

    if (response.statusCode == 407) {
      final refreshToken = await secureStorage.getRefreshToken();
      final userId = await secureStorage.getUserId();
      final uri = Uri.https(baseUrl, '/api/user/refresh-token');

      final client = http.Client();
      final newResponse = await client.post(
        uri,
        body: {
          'refreshToken': refreshToken,
          'userId': userId,
        },
      );

      if (newResponse.statusCode == 200) {
        final jsonObject = jsonDecode(newResponse.body);
        final newRefreshToken = jsonObject['refreshToken'];
        final newToken = jsonObject['accessToken'];

        await secureStorage.setRefreshToken(newRefreshToken.toString());
        await secureStorage.setToken(newToken.toString());
      } else {
        resetUser();
      }

      return true;
    }
    return false;
  }
}

class HttpAdapter {
  HttpAdapter({this.baseUrl});

  final String? baseUrl;

  Future<dynamic> send({
    required EndPoint endPoint,
    Map<String, dynamic>? params,
    String? id,
    void Function(double)? onProgress,
    List<MultipartFileModel>? files,
  }) async {
    final secureStorage = getIt<SecureStorageHelper>();
    final client = InterceptedClient.build(
      interceptors: [],
      retryPolicy: ExpiredTokenRetryPolicy(
        baseUrl ?? ApiConstants.baseURL,
        () {
          log('Reset User Error Case');
          throw ResetUserException();
        },
      ),
    );

    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (endPoint.shouldAddToken) {
      final token = await secureStorage.getToken();
      if (token?.isNotEmpty ?? false) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    final url = id != null ? endPoint.cleanUrlWith(id) : endPoint.url;

    try {
      http.Response response;
      final uri = Uri.https(
        baseUrl ?? ApiConstants.baseURL,
        url,
        params?.map((key, value) => MapEntry(key, value.toString())),
      );
      switch (endPoint.requestType) {
        case RequestType.get:
          response = await client.get(uri, headers: headers);

        case RequestType.post:
          if (files != null) {
            response = await _handleMultipartRequest(
              client,
              endPoint,
              params,
              url,
              onProgress,
              files,
            );
          } else {
            response = await client.post(
              uri,
              headers: headers,
              body: json.encode(params),
            );
          }

        case RequestType.put:
          response = await client.put(
            uri,
            headers: headers,
            body: json.encode(params),
          );

        case RequestType.patch:
          response = await client.patch(
            uri,
            headers: headers,
            body: json.encode(params),
          );

        case RequestType.delete:
          response = await client.delete(
            uri,
            headers: headers,
            body: params != null ? json.encode(params) : null,
          );

        default:
          throw UnimplementedError(
            'Request type not implemented: ${endPoint.requestType}',
          );
      }

      return _checkAndReturnResponse(response);
    } on SocketException catch (e) {
      throw FetchDataException('Network error: ${e.message}');
    }
  }

  Future<http.Response> _handleMultipartRequest(
    InterceptedClient client,
    EndPoint endPoint,
    Map<String, dynamic>? params,
    String uri,
    void Function(double)? onProgress,
    List<MultipartFileModel>? files,
  ) async {
    final request = http.MultipartRequest('POST', Uri.parse(uri));
    final secureStorage = getIt<SecureStorageHelper>();
    if (files != null) {
      for (final file in files) {
        request.files.add(
          await http.MultipartFile.fromPath(
            file.field ?? '',
            file.path ?? '',
          ),
        );
      }
    }

    if (params != null) {
      request.fields
          .addAll(params.map((key, value) => MapEntry(key, value.toString())));
    }

    request.headers.addAll({
      'Authorization': 'Bearer ${await secureStorage.getToken()}',
    });

    final streamedResponse = await request.send();

    if (onProgress != null) {
      streamedResponse.stream.listen(
        (bytes) {
          onProgress(
            bytes.length.toDouble() /
                streamedResponse.contentLength!.toDouble(),
          );
        },
      );
    }

    return http.Response.fromStream(streamedResponse);
  }

  dynamic _checkAndReturnResponse(http.Response response) {
    String? description;
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    description = jsonResponse.containsKey('message')
        ? jsonResponse['message'].toString()
        : null;

    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonResponse;
      case 400:
        throw Exception(description ?? 'Bad Request');
      case 401:
        throw Exception(description ?? 'Unauthorized');
      case 403:
        throw Exception(description ?? 'Forbidden');
      case 404:
        throw Exception(description ?? 'Not Found');
      case 500:
        throw Exception(description ?? 'Internal Server Error');
      default:
        throw Exception('Unknown error: ${response.statusCode}');
    }
  }
}

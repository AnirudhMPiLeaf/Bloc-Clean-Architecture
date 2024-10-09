import 'package:flutter/foundation.dart';
import 'package:teach_savvy/src/core/api/endpoints.dart';
import 'package:teach_savvy/src/core/api/network_adapter.dart';

// ignore: one_member_abstracts
abstract class ILoginRemoteDataSource {
  Future<bool> loginUser();
}

class LoginRemoteDataSource implements ILoginRemoteDataSource {
  LoginRemoteDataSource({required this.httpAdapter});

  final HttpAdapter httpAdapter;
  @override
  Future<bool> loginUser() async {
    final result = await httpAdapter.send(endPoint: EndPoint.auth);
    debugPrint(result.toString());

    /// result should be parsed with compute
    return true;
  }
}

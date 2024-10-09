// Enum for API endpoints
// ignore_for_file: no_default_cases
import 'package:teach_savvy/src/core/api/network_adapter.dart';
import 'package:teach_savvy/src/core/constants/constants.dart';

enum EndPoint {
  auth,
  userProfile,
  logout,
}

// Extension to map enum to URLs
extension URLExtension on EndPoint {
  static const String _baseUrl = ApiConstants.baseURL;

  String get url {
    switch (this) {
      case EndPoint.auth:
        return '$_baseUrl${ApiConstants.api}${ApiConstants.auth}';
      case EndPoint.userProfile:
        return '$_baseUrl${ApiConstants.api}${ApiConstants.user}';
      case EndPoint.logout:
        return '$_baseUrl${ApiConstants.api}${ApiConstants.user}';
      default:
        throw UnimplementedError('Endpoint not implemented: $this');
    }
  }

  String cleanUrlWith(String id) {
    // Example of replacing placeholders
    return url.replaceAll('|', id);
  }
}

// Extension to define request modes
extension RequestMode on EndPoint {
  RequestType get requestType {
    switch (this) {
      case EndPoint.auth:
      case EndPoint.userProfile:
      case EndPoint.logout:
        return RequestType.post;
      default:
        throw UnimplementedError(
          'Request type not implemented for endpoint: $this',
        );
    }
  }
}

// Extension for token handling
extension Token on EndPoint {
  bool get shouldAddToken {
    switch (this) {
      case EndPoint.userProfile:
      case EndPoint.logout:
        return true; // Token needed for these endpoints
      default:
        return false;
    }
  }
}

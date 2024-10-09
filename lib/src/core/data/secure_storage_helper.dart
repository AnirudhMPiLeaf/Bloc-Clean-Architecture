import 'package:teach_savvy/src/core/constants/constants.dart';
import 'package:teach_savvy/src/core/data/storage_abstracts.dart';

class SecureStorageHelper {
  SecureStorageHelper({required this.keyValueSecureDataSource});

  final IKeyValueSecureDataSource keyValueSecureDataSource;

  Future<void> setToken(String token) {
    return keyValueSecureDataSource.setValue(StorageKeys.token, token);
  }

  Future<void> setRefreshToken(String refreshToken) {
    return keyValueSecureDataSource.setValue(
      StorageKeys.refreshToken,
      refreshToken,
    );
  }

  Future<void> setUserId(String userId) {
    return keyValueSecureDataSource.setValue(StorageKeys.userId, userId);
  }

  Future<String?> getToken() {
    return keyValueSecureDataSource.getValueAsync(StorageKeys.token);
  }

  Future<String?> getRefreshToken() {
    return keyValueSecureDataSource.getValueAsync(StorageKeys.refreshToken);
  }

  Future<String?> getUserId() {
    return keyValueSecureDataSource.getValueAsync(StorageKeys.userId);
  }

  Future<void> removeToken() {
    return keyValueSecureDataSource.removeValue(StorageKeys.token);
  }

  Future<void> removeRefreshToken() {
    return keyValueSecureDataSource.removeValue(StorageKeys.refreshToken);
  }

  Future<void> removeUserId() {
    return keyValueSecureDataSource.removeValue(StorageKeys.userId);
  }
}

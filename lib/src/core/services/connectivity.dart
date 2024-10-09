import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  ConnectivityService() {
    _init();
  }
  final InternetConnection _checker = InternetConnection();
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>();

  Future<void> _init() async {
    _checker.onStatusChange.listen((status) {
      final isConnected = (status == InternetStatus.connected);
      _connectionStatusController.add(isConnected);
    });
  }

  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  void dispose() {
    _connectionStatusController.close();
  }
}

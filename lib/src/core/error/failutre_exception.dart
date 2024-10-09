import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.code});
  final String message;
  final int code;

  @override
  List<Object?> get props => [code, message];

  @override
  String toString() {
    return 'Error $code: $message';
  }
}

class ApiFailiure extends Failure {
  const ApiFailiure({required super.message, required super.code});
}

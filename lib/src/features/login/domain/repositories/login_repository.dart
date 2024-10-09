import 'package:dartz/dartz.dart';
import 'package:teach_savvy/src/core/error/failutre_exception.dart';

// ignore: one_member_abstracts
abstract class ILoginRepository {
  Future<Either<ApiFailiure, bool>> loginUser();
}

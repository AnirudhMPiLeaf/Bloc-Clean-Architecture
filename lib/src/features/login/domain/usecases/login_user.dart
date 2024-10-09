import 'package:dartz/dartz.dart';
import 'package:teach_savvy/src/core/error/failutre_exception.dart';
import 'package:teach_savvy/src/core/usecases/usecase_template.dart';
import 'package:teach_savvy/src/features/login/domain/repositories/login_repository.dart';

class ULoginUser extends UseCase<void, bool> {
  ULoginUser({required this.loginRepository});

  final ILoginRepository loginRepository;
  @override
  Future<Either<Failure, bool>> call(void params) {
    return loginRepository.loginUser();
  }
}

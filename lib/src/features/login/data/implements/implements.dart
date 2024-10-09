import 'package:dartz/dartz.dart';
import 'package:teach_savvy/src/core/config/injection.dart';
import 'package:teach_savvy/src/core/constants/constants.dart';
import 'package:teach_savvy/src/core/data/storage_abstracts.dart';
import 'package:teach_savvy/src/core/error/failutre_exception.dart';
import 'package:teach_savvy/src/features/login/data/sources/sources.dart';
import 'package:teach_savvy/src/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImp implements ILoginRepository {
  LoginRepositoryImp({required this.remoteDataSource});
  final ILoginRemoteDataSource remoteDataSource;

  @override
  Future<Either<ApiFailiure, bool>> loginUser() async {
    try {
      // await remoteDataSource.loginUser();
      await getIt<IKeyValueSecureDataSource>()
          .setValue(StorageKeys.token, 'RandomToken');
      return right(true);
    } on Exception catch (e) {
      return left(ApiFailiure(message: e.toString(), code: 0));
    }
  }
}

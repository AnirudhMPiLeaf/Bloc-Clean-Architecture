import 'package:teach_savvy/src/features/results/data/sources/sources.dart';
import 'package:teach_savvy/src/features/results/domain/repositories/repositories.dart';

class ResultsRepositoryImp implements ResultsRepository {
  ResultsRepositoryImp({required this.remoteDataSource});
  final ResultsRemoteDataSource remoteDataSource;

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}

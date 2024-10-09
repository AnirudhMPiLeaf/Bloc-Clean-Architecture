import 'package:teach_savvy/src/features/counter/data/sources/sources.dart';
import 'package:teach_savvy/src/features/counter/domain/repositories/repositories.dart';

class CounterRepositoryImp implements CounterRepository {
  CounterRepositoryImp({required this.remoteDataSource});
  final CounterRemoteDataSource remoteDataSource;

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}

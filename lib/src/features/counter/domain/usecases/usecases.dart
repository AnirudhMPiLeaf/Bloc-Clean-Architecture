import 'package:teach_savvy/src/features/counter/domain/repositories/repositories.dart';

class GetCounterUseCase {
  GetCounterUseCase({required this.repository});
  final CounterRepository repository;

  // Future<User> execute(String userId) async {
  //   return userRepository.getUser(userId);
  // }
}

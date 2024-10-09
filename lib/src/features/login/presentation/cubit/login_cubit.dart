// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teach_savvy/src/core/utils/snackbar.dart';

import 'package:teach_savvy/src/features/login/domain/usecases/login_user.dart';

part 'login_state.dart';

// ignore: one_member_abstracts
abstract class LoginCubit {
  Future<void> loginUser();
}

class LoginCubitImpl extends Cubit<LoginState> implements LoginCubit {
  LoginCubitImpl(
    this.uLoginUser,
  ) : super(LoginInitial());
  final ULoginUser uLoginUser;
  @override
  Future<void> loginUser() async {
    try {
      emit(LoginLoading());
      final result = await uLoginUser(0);
      await Future<void>.delayed(const Duration(seconds: 3));
      result.fold(
        (l) {
          SnackBarHelper.showSnackbar(content: Text(l.message));
          emit(LoginFailed());
        },
        (r) {
          debugPrint(r.toString());
          emit(LoginSuccess());
        },
      );
    } catch (e) {
      debugPrint('Handle error case');
      emit(LoginFailed());
    }
  }
}

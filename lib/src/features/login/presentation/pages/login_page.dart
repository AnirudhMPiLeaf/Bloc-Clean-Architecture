import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teach_savvy/src/core/routes/pages.gr.dart';
import 'package:teach_savvy/src/features/login/presentation/cubit/login_cubit.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({required this.onResult, super.key});

  final void Function({bool success}) onResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: BlocListener<LoginCubitImpl, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            onResult(success: true);
          }
        },
        child: BlocBuilder<LoginCubitImpl, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubitImpl>().loginUser();
                        // onResult(success: true);
                        // context.navigateTo(const CounterPage());
                      },
                      child: const Text('Login and redirect'),
                    ),
                    ElevatedButton(
                      onPressed: () => context.navigateTo(const CounterPage()),
                      child: const Text('Counter'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

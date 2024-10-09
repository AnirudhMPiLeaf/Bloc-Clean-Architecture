// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:teach_savvy/src/core/error/connectivity.dart' as _i1;
import 'package:teach_savvy/src/features/counter/presentation/pages/counter_page.dart'
    as _i2;
import 'package:teach_savvy/src/features/login/presentation/pages/login_page.dart'
    as _i3;
import 'package:teach_savvy/src/features/results/presentation/pages/results_page.dart'
    as _i4;

/// generated route for
/// [_i1.ConnectivityErrorPage]
class ConnectivityErrorPage extends _i5.PageRouteInfo<void> {
  const ConnectivityErrorPage({List<_i5.PageRouteInfo>? children})
      : super(
          ConnectivityErrorPage.name,
          initialChildren: children,
        );

  static const String name = 'ConnectivityErrorPage';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.ConnectivityErrorPage();
    },
  );
}

/// generated route for
/// [_i2.CounterPage]
class CounterPage extends _i5.PageRouteInfo<void> {
  const CounterPage({List<_i5.PageRouteInfo>? children})
      : super(
          CounterPage.name,
          initialChildren: children,
        );

  static const String name = 'CounterPage';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.CounterPage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginPage extends _i5.PageRouteInfo<LoginPageArgs> {
  LoginPage({
    required void Function({bool success}) onResult,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          LoginPage.name,
          args: LoginPageArgs(
            onResult: onResult,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginPageArgs>();
      return _i3.LoginPage(
        onResult: args.onResult,
        key: args.key,
      );
    },
  );
}

class LoginPageArgs {
  const LoginPageArgs({
    required this.onResult,
    this.key,
  });

  final void Function({bool success}) onResult;

  final _i6.Key? key;

  @override
  String toString() {
    return 'LoginPageArgs{onResult: $onResult, key: $key}';
  }
}

/// generated route for
/// [_i4.ResultsPage]
class ResultsPage extends _i5.PageRouteInfo<void> {
  const ResultsPage({List<_i5.PageRouteInfo>? children})
      : super(
          ResultsPage.name,
          initialChildren: children,
        );

  static const String name = 'ResultsPage';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.ResultsPage();
    },
  );
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:teach_savvy/src/core/config/config.dart';
import 'package:teach_savvy/src/core/global/global.dart';
import 'package:teach_savvy/src/core/localization/l10n.dart';
import 'package:teach_savvy/src/core/routes/observers.dart';
import 'package:teach_savvy/src/core/routes/pages.gr.dart';
import 'package:teach_savvy/src/core/routes/routes.dart';
import 'package:teach_savvy/src/core/services/connectivity.dart';
import 'package:teach_savvy/src/features/login/presentation/cubit/login_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<LoginCubitImpl>(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final ConnectivityService _connectivityService;
  late final AppRouter _appRouter;
  late StreamSubscription<bool> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivityService = getIt<ConnectivityService>();
    _appRouter = getIt<AppRouter>();

    _connectivitySubscription =
        _connectivityService.connectionStatus.listen(_handleConnectivityChange);
  }

  void _handleConnectivityChange(bool isConnected) {
    if (!isConnected) {
      // If disconnected, navigate to the error page
      if (!_appRouter.isRouteActive(ConnectivityErrorPage.name)) {
        _appRouter.push(const ConnectivityErrorPage());
      }
    } else {
      // Navigate back from the error page if the connection is restored
      if (_appRouter.isRouteActive(ConnectivityErrorPage.name)) {
        _appRouter.removeLast(); // Navigate back
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription
        .cancel(); // Cancel the subscription to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _appRouter.config(
        navigatorObservers: () =>
            [AppRouteObserver()], // Use your custom observer
      ),
      scaffoldMessengerKey: snackbarKey,
      builder: EasyLoading.init(),
    );
  }
}

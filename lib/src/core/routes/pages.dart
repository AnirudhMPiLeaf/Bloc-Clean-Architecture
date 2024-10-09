/// This file manages the routing for the application.
library route_pages;

import 'package:auto_route/auto_route.dart';
import 'package:teach_savvy/src/core/middleware/middleware.dart';
import 'package:teach_savvy/src/core/routes/pages.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ConnectivityErrorPage.page),
        AutoRoute(page: LoginPage.page),
        AutoRoute(page: CounterPage.page, initial: true, guards: [AuthGuard()]),
        AutoRoute(page: ResultsPage.page, guards: [AuthGuard()]),
      ];
}

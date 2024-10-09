import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppRouteObserver extends AutoRouterObserver {
  final List<String> _navigationHistory = [];
  bool debugMode = false; // Toggle for print statements

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _navigationHistory.add(route.settings.name ?? 'Unknown Route');
    if (debugMode) {
      debugPrint('New route pushed: ${route.settings.name}');
      debugPrint('Current navigation history: $_navigationHistory');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (_navigationHistory.isNotEmpty) {
      _navigationHistory.removeLast(); // Remove the last route
    }
    if (debugMode) {
      debugPrint('Route popped: ${route.settings.name}');
      debugPrint('Current navigation history: $_navigationHistory');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (debugMode) {
      debugPrint('Route removed: ${route.settings.name}');
    }

    // Check if the removed route is in the navigation history
    if (route.settings.name != null) {
      _navigationHistory.removeWhere((name) => name == route.settings.name);
      if (debugMode) {
        debugPrint(
          'Updated navigation history after removal: $_navigationHistory',
        );
      }
    }
  }

  // Only override to observe tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    if (debugMode) {
      debugPrint('Tab route visited: ${route.name}');
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    if (debugMode) {
      debugPrint('Tab route re-visited: ${route.name}');
    }
  }

  // Method to get navigation history
  List<String> get navigationHistory => List.unmodifiable(_navigationHistory);
}

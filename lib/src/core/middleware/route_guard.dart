import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:teach_savvy/src/core/config/injection.dart';
import 'package:teach_savvy/src/core/constants/constants.dart';
import 'package:teach_savvy/src/core/data/storage_abstracts.dart';
import 'package:teach_savvy/src/core/routes/pages.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // Check if the user is authenticated
    final isAuthenticated =
        await _checkAuthentication(); // Replace with your logic

    if (!isAuthenticated) {
      // Navigate to login if not authenticated
      unawaited(
        resolver.redirect(
          LoginPage(
            onResult: ({success = false}) {
              // if success == true the navigation will be resumed
              // else it will be aborted
              // Check if the route stack is not empty
              if (router.canPop()) {
                // If there are pages in the stack, resume to the last page
                resolver.next();
              } else {
                // If the stack is empty, navigate to the CounterPage
                unawaited(
                  resolver.redirect(
                    const CounterPage(),
                    replace: true,
                  ),
                );
              }
            },
          ),
          onFailure: (failure) {
            // Handle failure if redirection fails (optional)
            debugPrint('Redirect failed: $failure');
          },
          replace: true,
        ),
      );
    } else {
      resolver.next(); // Allow navigation
    }
  }

  // Method to check authentication status
  Future<bool> _checkAuthentication() async {
    final token = await getIt<IKeyValueSecureDataSource>()
        .getValueAsync(StorageKeys.token);
    return !(token == null ||
        token.trim().isEmpty); // For demo, always return false
  }
}

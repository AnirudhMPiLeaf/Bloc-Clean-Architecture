import 'package:flutter/material.dart';
import 'package:teach_savvy/src/core/global/global.dart';

class SnackBarHelper {
  SnackBarHelper._();

  static void showSnackbar({
    required Widget content,
    Duration? duration,
    Color? backgroundColor,
    Alignment? alignment,
  }) {
    // Default values
    final snackbarDuration = duration ?? const Duration(seconds: 2);
    final snackbarAlignment = alignment ?? Alignment.center;
    final snackbarBackgroundColor =
        backgroundColor ?? Colors.black.withOpacity(0.8);

    // Show snackbar
    snackbarKey.currentState
        ?.hideCurrentSnackBar(); // Hide current snackbar if any
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        elevation: 1000,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.fixed,
        duration: snackbarDuration,
        content: Container(
          alignment: snackbarAlignment,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: snackbarBackgroundColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: content,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context, String msg) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final snackBar = SnackBar(
      content: Text(msg,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.orange,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  });
}

void showErrorSnackBar(BuildContext context, String msg) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final snackBar = SnackBar(
      content: Text(msg,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  });
}
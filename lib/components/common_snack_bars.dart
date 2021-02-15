import 'package:flutter/material.dart';

SnackBar successSnackBar({final String message}) => SnackBar(
  content: Text(
    message != null ? message : "Success!!",
    textAlign: TextAlign.center,
  ),
  duration: Duration(seconds: 1),
  backgroundColor: Colors.green[200],
);

SnackBar failureSnackBar({final String message}) => SnackBar(
  content: Text(
    message != null ? message : "Failure...",
    textAlign: TextAlign.center,
  ),
  duration: Duration(seconds: 1),
  backgroundColor: Colors.red[200],
);

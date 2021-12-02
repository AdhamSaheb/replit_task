import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:replit/Constants/colors.dart';

void showFeatureNotAvailableToast() {
  Fluttertoast.showToast(
    msg: 'Feature Not Avialable in this Demo',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: lightGreen,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}

void showValidationToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red[300],
    textColor: Colors.white,
    fontSize: 14.0,
  );
}

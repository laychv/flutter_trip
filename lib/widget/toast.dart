import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommToast {
  static show({
    @required BuildContext context,
    @required String msg,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 14,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}

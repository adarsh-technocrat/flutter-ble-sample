import 'package:flutter/material.dart';

class CommonWidgets {
  void snackBar(BuildContext context, String mesg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mesg)));
  }
}

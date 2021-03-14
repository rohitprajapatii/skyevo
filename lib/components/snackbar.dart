import 'package:flutter/material.dart';

showInSnackBar(context, String value) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      "$value",
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.black87,
  ));
}

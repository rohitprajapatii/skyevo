import 'package:flutter/material.dart';

Center buildCenterTitle() {
  return Center(
    child: Container(
      height: 100.0,
      child: Text(
        '<skyevo/>',
        style: TextStyle(
            color: Colors.black, fontSize: 40, fontWeight: FontWeight.w900),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

class Texts {
  static textBottomNavigation(text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        // color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static textButtonDialog(text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

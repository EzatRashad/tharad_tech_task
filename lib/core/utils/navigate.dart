import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void nextScreen(
    Widget screen, {
    bool replacment = false,
    bool remove = false,
  }) {
    if (remove) {
      Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => screen),
        (route) => false,
      );
    } else if (replacment) {
      Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
    }
  }
}

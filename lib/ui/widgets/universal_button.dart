// ignore: must_be_immutable

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UniversalButton extends StatelessWidget {
  UniversalButton({
    Key key,
    this.height,
    this.width,
    this.borderRadius = 10.0,
    this.color,
    this.onPressed,
    this.child,
  }) : super(key: key);

  var height;
  var width;
  var borderRadius;
  var color;
  var child;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Container(
            height: height,
            width: width,
            child: child,
          ),
        ),
      ),
    );
  }
}

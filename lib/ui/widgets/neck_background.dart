import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NeckBackground extends StatelessWidget {
  NeckBackground({
    Key key,
    @required this.size,
    @required this.captureArea,
  }) : super(key: key);

  final size;
  double captureArea;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * captureArea,
      width: size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
    );
  }
}

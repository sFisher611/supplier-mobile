import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonMaterialContainer extends StatelessWidget {
  ButtonMaterialContainer({
    Key key,
    @required this.size,
    @required this.width,
    this.onPressed,
    this.title,
  }) : super(key: key);

  final Size size;
  final width;
  final title;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff4796ff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

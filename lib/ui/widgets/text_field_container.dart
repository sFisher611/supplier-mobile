// ignore: must_be_immutable
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  TextFieldContainer({
    Key key,
    @required this.size,
    this.isPassword = false,
    this.iconTitle,
    this.hintText,
    this.controller,
    this.onPressSuffix,
    this.iconSuffix,
  }) : super(key: key);

  final Size size;
  final isPassword;
  final iconTitle;
  final iconSuffix;
  final hintText;
  final controller;
  Function onPressSuffix;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: iconSuffix == null
              ? null
              : IconButton(
                  icon: iconSuffix,
                  onPressed: onPressSuffix,
                ),
          prefixIcon: Icon(
            iconTitle,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }
}

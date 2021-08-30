import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldInBorderRadius extends StatelessWidget {
  TextFieldInBorderRadius({
    Key key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.onChange,
    this.onTap,
    this.onEditingComplete,
    this.keyboardType,
    this.inputFormatters,
    this.prefixText,
  }) : super(key: key);
  var hintText;
  var prefixText;
  var controller;
  var prefixIcon;
  var onEditingComplete;
  var keyboardType;
  var inputFormatters;
  Function onTap;
  Function onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(5)),
        child: TextField(
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          controller: controller,
          onChanged: onChange,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 18.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 10,
                borderRadius: BorderRadius.circular(10),
              ),
              prefixText: prefixText,
              prefixStyle: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}

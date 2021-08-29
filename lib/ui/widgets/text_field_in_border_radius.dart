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
      // margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          controller: controller,
          onChanged: onChange,
          keyboardType: keyboardType,
          style: TextStyle(
            // color: Colors.black,
            // fontFamily: Fonts.fRegular,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
              hintText: hintText,
              // labelText: 'FIO',
              // labelStyle: TextStyle(
              //   color: ThemeOther.textFieldLable(),
              //   fontFamily: Fonts.fRegular,
              //   fontSize: 18.0,
              //   fontWeight: FontWeight.bold,
              // ),
              hintStyle: TextStyle(
                // color: Colors.black,
                // fontFamily: Fonts.fRegular,
                fontSize: 18.0,
                // fontWeight: FontWeight.w600,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 10,
                borderRadius: BorderRadius.circular(10),
              ),
              // suffixIcon: Icon(Icons.account_circle),
              // icon: Icon(Icons.account_circle),
              prefixIcon: Icon(
                prefixIcon,
                // color: ThemeOther.textFieldPrefixColor(),
              ),
              prefixText: prefixText,
              prefixStyle: TextStyle(
                color: Colors.black,
                // fontFamily: Fonts.fRegular,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}

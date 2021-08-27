import 'package:flutter/material.dart';
import 'package:supplier_project/ui/widgets/texts.dart';

// ignore: must_be_immutable
class BottomNavigationButton extends StatelessWidget {
  BottomNavigationButton({
    Key key,
    @required this.size,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);
  var text;
  Function onPressed;
  final size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),

          onTap: onPressed,
          child: Container(
            height: size.height * 0.08,
            width: size.width,
            alignment: Alignment.center,
            child: Texts.textBottomNavigation(text),
          ),
        ),
      ),
    );
  }
}

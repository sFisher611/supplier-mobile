
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownBeBorder extends StatelessWidget {
  DropDownBeBorder(
      {Key key,
      @required this.size,
      @required this.list,
      @required this.onChanged,
      @required this.selectedIndex,
      this.icon = Icons.location_on_outlined,
      }
      )
      : super(key: key);
  var size;
  var icon;
  var selectedIndex;
  List<String> list;
  Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(1)),
      child: ListTile(
        trailing: Icon(Icons.keyboard_arrow_down),
        leading: Icon(icon),
        title: DropdownButton(
          isExpanded: true,
          value: selectedIndex,
          style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          iconSize: 0,
          underline: Container(color: Colors.transparent),
          onTap: () {},
          onChanged: onChanged,
          items: list.map((category) {
            return DropdownMenuItem(
              child: Container(
                width: size.width * 0.45,
                child: Text(
                  category,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              value: category,
            );
          }).toList(),
        ),
      ),
    );
  }
}

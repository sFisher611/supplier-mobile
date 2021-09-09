import 'package:flutter/material.dart';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  static const menuItems = <String>[
    'One',
    'Two',
    'Three',
    'Four',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'One';
  String _btn2SelectedVal;
  String _btn3SelectedVal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('DropDownButton with default:'),
          trailing: DropdownButton<String>(
            value: _btn1SelectedVal,
            onChanged: (String newValue) {
              setState(() {
                _btn1SelectedVal = newValue;
              });
            },
            items: this._dropDownMenuItems,
          ),
        ),
        ListTile(
          title: Text('DropDownButton with hint:'),
          trailing: DropdownButton(
            value: _btn2SelectedVal,
            hint: Text('Choose'),
            onChanged: ((String newValue) {
              setState(() {
                _btn2SelectedVal = newValue;
              });
            }),
            items: _dropDownMenuItems,
          ),
        ),
        ListTile(
          title: const Text('Popup menu button:'),
          trailing: new PopupMenuButton<String>(
            onSelected: (String newValue) {
              _btn3SelectedVal = newValue;
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('$_btn3SelectedVal'),
                ),
              );
            },
            itemBuilder: (BuildContext context) => _popUpMenuItems,
          ),
        ),
      ],
    );
  }
}
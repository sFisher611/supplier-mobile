

import 'package:shared_preferences/shared_preferences.dart';

class LocalMemory {
  static void dataSave(name, text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('$name', text);
  }

  static getData(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var text = prefs.getString(name);
    return text;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'basic_pages/pages/login_page.dart';

void main() {
  runApp(HomePage());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginPage() // BasicPage(),
        );
  }
}

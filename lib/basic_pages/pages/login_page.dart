import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:supplier_project/basic_pages/basic_page.dart';
import 'package:supplier_project/service/my_behavior.dart';
import 'dart:ui';

import 'package:supplier_project/ui/widgets/text_field_container.dart';
import 'package:supplier_project/widgets/button_material_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacity;
  Animation<double> _transform;
  bool showSingUp = false;
  bool visibilityPassword = true;
  var iconSuffixPassword = Icon(Icons.visibility_outlined);
  TextEditingController _login = new TextEditingController(text: '');
  TextEditingController _loginSingUp = new TextEditingController(text: '');
  TextEditingController _password = new TextEditingController(text: '');
  TextEditingController _passwordSingUp = new TextEditingController(text: '');
  TextEditingController _name = new TextEditingController(text: '');

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  void _showSingUp() {
    setState(() {
      showSingUp = !showSingUp;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _iconSuffixUpdate() {
    if (visibilityPassword) {
      iconSuffixPassword = Icon(Icons.visibility_off_outlined);
      visibilityPassword = false;
    } else {
      iconSuffixPassword = Icon(Icons.visibility_outlined);
      visibilityPassword = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blueGrey,
                    Colors.blue,
                  ],
                ),
              ),
              child: loginContainer(size),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginContainer(Size size) {
    return Opacity(
      opacity: _opacity.value,
      child: Transform.scale(
        scale: _transform.value,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 2000),
          curve: Curves.linear,
          width: size.width * .9,
          height: size.width * 1.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 90,
              ),
            ],
          ),
          child: showSingUp ? singUpContainer(size) : singInContainer(size),
        ),
      ),
    );
  }

  Widget singInContainer(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(),
        Text(
          'Дастурга кириш',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(.7),
          ),
        ),
        SizedBox(),
        TextFieldContainer(
          size: size,
          hintText: 'Логин',
          iconTitle: Icons.account_circle_outlined,
          controller: _login,
        ),
        TextFieldContainer(
          size: size,
          hintText: 'Парол',
          iconTitle: Icons.lock_outlined,
          isPassword: visibilityPassword,
          iconSuffix: iconSuffixPassword,
          onPressSuffix: _iconSuffixUpdate,
          controller: _password,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonMaterialContainer(
              size: size,
              title: "Кириш",
              width: 2.6,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => BasicPage()));
              },
            ),
            SizedBox(width: size.width / 25),
            InkWell(
              onTap: () {},
              child: Container(
                width: size.width / 2.6,
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: 'Янги қурилма!',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(),
        InkWell(
          onTap: _showSingUp,
          child: Container(
            width: size.width / 2.6,
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                text: 'Рўйхатдан ўтиш',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ),
        ),
        SizedBox(),
      ],
    );
  }

  Widget singUpContainer(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(),
        Text(
          'Рўйхатдан ўтиш',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(.7),
          ),
        ),
        SizedBox(),
        TextFieldContainer(
          size: size,
          hintText: 'ФИО',
          iconTitle: Icons.account_circle,
          controller: _name,
        ),
        TextFieldContainer(
          size: size,
          hintText: 'Логин',
          iconTitle: Icons.account_circle_outlined,
          controller: _loginSingUp,
        ),
        TextFieldContainer(
          size: size,
          hintText: 'Парол',
          iconTitle: Icons.lock_outlined,
          isPassword: visibilityPassword,
          iconSuffix: iconSuffixPassword,
          onPressSuffix: _iconSuffixUpdate,
          controller: _passwordSingUp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonMaterialContainer(
              size: size,
              title: "Рўйхатдан ўтиш",
              width: 2.4,
              onPressed: () {},
            ),
            SizedBox(width: size.width / 25),
            InkWell(
              onTap: _showSingUp,
              child: Container(
                width: size.width / 2.6,
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: 'Дастурга кириш',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(),
        SizedBox(),
      ],
    );
  }
}

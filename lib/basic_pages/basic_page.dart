import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supplier_project/basic_pages/pages/product_page.dart';
import 'package:supplier_project/basic_pages/pages/finish_product_page.dart';
import 'package:supplier_project/basic_pages/pages/personal_page.dart';
import 'package:supplier_project/basic_pages/pages/return_product_page.dart';

class BasicPage extends StatefulWidget {
  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  int currentPage = 0;
  DateTime currentBackPressTime;
  final _pageOptions = [
    ProductPage(),
    ReturnProductPage(),
    FinishProductPage(),
    PersonalPage()
  ];
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      EasyLoading.showToast('Чиқиш учун яна бир марта босинг!',
          toastPosition: EasyLoadingToastPosition.bottom);

      return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: _pageOptions[currentPage],
        bottomNavigationBar: FancyBottomNavigation(
          circleColor: Colors.blueAccent,
          inactiveIconColor: Colors.grey,
          tabs: [
            TabData(
              iconData: Icons.airport_shuttle,
              title: "Йетказмалар",
            ),
            TabData(
              iconData: Icons.settings,
              title: "Буюртма",
            ),
            TabData(
              iconData: Icons.check_circle_outline,
              title: "Тугатилган",
            ),
            TabData(
              iconData: Icons.account_circle,
              title: "Хисоблар",
            )
          ],
          onTabChangedListener: (int position) {
            setState(() {
              currentPage = position;
            });
          },
        ),
      ),
    );
  }
}

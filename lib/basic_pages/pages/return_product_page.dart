import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:supplier_project/const/const_text.dart';
import 'package:supplier_project/ui/widgets/container_card_return.dart';

class ReturnProductPage extends StatefulWidget {
  @override
  _ReturnProductPageState createState() => _ReturnProductPageState();
}

class _ReturnProductPageState extends State<ReturnProductPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TEXT_RETURN_TITLE,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: LiquidPullToRefresh(
//        key: _refreshIndicatorKey,	// key if you want to add
        onRefresh: () async {
          return await Future.delayed(Duration(seconds: 3));
        },
        springAnimationDurationInMilliseconds: 100,
        showChildOpacityTransition: true,
        child: Container(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext cxt, int index) {
                return ContainerCardReturn(
                  size: size,
                  product: null,
                  onPressedButton: (){},
                );
              }),
        ),
      ),
    );
  }
}

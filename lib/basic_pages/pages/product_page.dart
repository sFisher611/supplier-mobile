import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:supplier_project/const/const_status.dart';
import 'package:supplier_project/const/const_text.dart';
import 'package:supplier_project/http/http_const.dart';
import 'package:supplier_project/http/http_json.dart';
import 'package:supplier_project/model/product.dart';
import 'package:supplier_project/ui/widgets/container_card_accepted.dart';
import 'package:supplier_project/ui/widgets/container_card_loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'finished_page.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  //     GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(milliseconds: 0), (x) => refreshNum);
  var size;
  @override
  void initState() {
    super.initState();
    // _getProduct();
  }

  Future<List<Product>> _getProduct(status) async {
    var data = {'status': status};
    var res = await HttpJson.postJson(HttpConst.getProduct, data);
    List<Product> product = [];
    if (!res['error']) {
      for (var item in res['data']['data']) {
        product.add(Product.fromJson(item));
      }
      // if (product.length == 0) {
      // EasyLoading.showInfo(LOADER_EMPTY_LIST);
      // }
    } else {
      EasyLoading.showInfo(res['message']['messge']);
    }
    return product;
  }

  _jsonSetProduct(id, status) async {
    var data = {'id': id, 'status': status};
    var res = await HttpJson.postJson(HttpConst.productStatusUpdate, data);
    if (!res['error']) {
      EasyLoading.showSuccess(res['data']['message']);
      setState(() {});
    } else {
      EasyLoading.showInfo(res['message']['message']);
    }
  }

  _jsonSetProductStausNull(id) async {
    var data = {'id': id};
    var res = await HttpJson.postJson(HttpConst.productStatusUpdateNull, data);
    if (!res['error']) {
      EasyLoading.showSuccess(res['data']['message']);
      setState(() {});
    } else {
      EasyLoading.showInfo(res['message']['message']);
    }
  }
  _dataShowDialog()async{
    // return showDialog(context: context, builder: (BuildContext context) {  
    //   return  
    // } );
  }

  Future<void> _selectPhoneAndData(data) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text('Қўнғироқ қилиш'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text('Бошқа маълумотларни кўриш'),
                ),
              ),
            ],
          );
        })) {
      case 0:
        _makePhoneCall('tel:${data.phone}');
        break;
      case 1:
        // ...
        break;
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('xxxx');
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: LiquidPullToRefresh(
//        key: _refreshIndicatorKey,	// key if you want to add
        onRefresh: () async {
          setState(() {});
          // return await Future.delayed(Duration(seconds: 3));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              TEXT_PRODUCT_DELIVERED,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.white54,
              // labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    TEXT_PRODUCT_LOADING,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    TEXT_PRODUCT_ACCEPTED,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder(
                future: _getProduct(STATUS_ORDER),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.done:
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          // controller: _scrollController,
                          itemBuilder: (BuildContext cxt, int index) {
                            return ContainerCardLoading(
                              product: snapshot.data[index],
                              size: size,
                              onLongPress: () {
                                _selectPhoneAndData(snapshot.data[index]);
                              },
                              onPressedAccepted: () {
                                _jsonSetProduct(
                                    snapshot.data[index].id, STATUS_ACCEPTED);
                              },
                              onPressedCancel: () {
                                _jsonSetProductStausNull(
                                    snapshot.data[index].id);
                              },
                            );
                          });
                      break;
                    default:
                      print('55');
                      return Center(
                        child: Text('!!!'),
                      );
                  }
                  // if (snapshot.data == null) {

                  // }
                },
              ),
              FutureBuilder(
                future: _getProduct(STATUS_ACCEPTED),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.done:
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext cxt, int index) {
                            return ContainerCardAccepted(
                              product: snapshot.data[index],
                              size: size,
                              onPressedDelivered: () {
                                WidgetsBinding.instance.addPostFrameCallback(
                                  (_) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FinishedPage(
                                                  product: snapshot.data[index],
                                                ))).then((value) {
                                      if (value == '1') {
                                        setState(() {});
                                      }
                                    });
                                  },
                                );
                              },
                              onPressedCancel: () {
                                _jsonSetProduct(
                                    snapshot.data[index].id, STATUS_ORDER);
                              },
                            );
                          });
                      break;
                    default:
                      return Center(
                        child: Text('!!!!!!!!'),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

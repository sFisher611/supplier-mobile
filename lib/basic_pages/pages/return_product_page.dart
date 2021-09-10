import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:supplier_project/const/const_status.dart';
import 'package:supplier_project/const/const_text.dart';
import 'package:supplier_project/http/http_const.dart';
import 'package:supplier_project/http/http_json.dart';
import 'package:supplier_project/model/product.dart';
import 'package:supplier_project/ui/widgets/container_card_return.dart';

class ReturnProductPage extends StatefulWidget {
  @override
  _ReturnProductPageState createState() => _ReturnProductPageState();
}

class _ReturnProductPageState extends State<ReturnProductPage> {
  Future<void> _getProduct(status) async {
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

  _jsonSetProduct(id) async {
    var data = {'id': id};
    var res = await HttpJson.postJson(HttpConst.productStatusUpdateReturn, data);
    if (!res['error']) {
      EasyLoading.showSuccess(res['data']['message']);
      setState(() {});
    } else {
      EasyLoading.showInfo(res['message']['message']);
    }
  }

  showAlertDialog(BuildContext context, id) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Ха"),
      onPressed: () {
        _jsonSetProduct(id);
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Йўқ"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Тасдиқлаш"),
      // content: Text("This is my message."),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LiquidPullToRefresh(
//        key: _refreshIndicatorKey,	// key if you want to add
      onRefresh: () async {
        setState(() {});
        // return await Future.delayed(Duration(seconds: 3));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            TEXT_RETURN_TITLE,
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       Icons.refresh,
          //     ),
          //     onPressed: () {},
          //   )
          // ],
        ),
        body: FutureBuilder(
          future: _getProduct(STATUS_RETURN_ORDER),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext cxt, int index) {
                      return ContainerCardReturn(
                        size: size,
                        product: snapshot.data[index],
                        onPressedButton: () {
                          showAlertDialog(context, snapshot.data[index].id);
                        },
                        onLongPressed: () {},
                        onPressed: () {},
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
      ),
    );
  }
}

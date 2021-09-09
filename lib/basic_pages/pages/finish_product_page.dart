import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:supplier_project/const/const_status.dart';
import 'package:supplier_project/const/const_text.dart';
import 'package:supplier_project/http/http_const.dart';
import 'package:supplier_project/http/http_json.dart';
import 'package:supplier_project/model/product.dart';
import 'package:supplier_project/ui/widgets/container_card_finished.dart';

class FinishProductPage extends StatefulWidget {
  @override
  _FinishProductPageState createState() => _FinishProductPageState();
}

class _FinishProductPageState extends State<FinishProductPage> {
  var _date1;
  var _date2;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _date1 = DateTime(now.year, now.month - 1, now.day);
    _date2 = DateTime(now.year, now.month, now.day);
  }

  dateTimeRangePicker() async {
    DateTimeRange picked = await showDateRangePicker(
      saveText: 'Сақлаш',
      helpText: 'Вақт танлаш',
      context: context,
      //locale: const Locale('uzb', 'UZ'),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: DateTimeRange(
        end: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
        start: DateTime.now(),
      ),
    );
    if (picked != null) {
      _date1 = picked.start;
      _date2 = picked.end;
      setState(() {});
    }
  }

  Future<List<Product>> _getProduct(status) async {
    var data = {
      'status': status,
      'start': _date1.toString(),
      'finish': _date2.toString()
    };
    var res = await HttpJson.postJson(HttpConst.getFinishedProducts, data);
    List<Product> product = [];
    if (!res['error']) {
      for (var item in res['data']['data']) {
        product.add(Product.fromJson(item));
      }
      // if (product.length == 0) {
      // EasyLoading.showInfo(LOADER_EMPTY_LIST);
      // }
    } else {
      EasyLoading.showInfo(res['message']);
    }
    return product;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TEXT_FINISHED_TITLE,
              ),
              Text(
                _date1.toString().substring(0, 10) +
                    ' дан ' +
                    _date2.toString().substring(0, 10),
                    style: TextStyle(fontSize: 12,color: Colors.grey[400]),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.date_range_outlined,
              ),
              onPressed: () {
                dateTimeRangePicker();
              },
            )
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.white54,
            // labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  TEXT_FINISHED_TAB_CONDUCTED,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  TEXT_FINISHED_TAB_BROUGHT,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        body: LiquidPullToRefresh(
//        key: _refreshIndicatorKey,	// key if you want to add
          onRefresh: () async {
            return await Future.delayed(Duration(seconds: 3));
          },
          springAnimationDurationInMilliseconds: 100,
          showChildOpacityTransition: true,
          child: TabBarView(
            children: [
              FutureBuilder(
                future: _getProduct(STATUS_FINISHED),
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
                            return ContainerCardFinished(
                              size: size,
                              product: snapshot.data[index],
                            );
                          });
                      break;
                    case ConnectionState.none:
                      return Center(child: Text('!!!!!!!'));
                      break;
                    default:
                      print('55');
                      return Center(
                        child: Text('!!!!!'),
                      );
                  }
                  // if (snapshot.data == null) {

                  // }
                },
              ),
              FutureBuilder(
                future: _getProduct(STATUS_RETURN_FINISHED),
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
                            return ContainerCardFinished(
                              size: size,
                              product: snapshot.data[index],
                            );
                          });
                      break;
                    case ConnectionState.none:
                      return Center(child: Text('!!!!!!!'));
                      break;
                    default:
                      print('55');
                      return Center(
                        child: Text('!!!!!!'),
                      );
                  }
                  // if (snapshot.data == null) {

                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

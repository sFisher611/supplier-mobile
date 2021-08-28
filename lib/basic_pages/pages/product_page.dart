import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:supplier_project/const/const_text.dart';
import 'package:supplier_project/ui/widgets/container_card_accepted.dart';
import 'package:supplier_project/ui/widgets/container_card_loading.dart';

import 'finished_page.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  ScrollController _scrollController;
  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(milliseconds: 0), (x) => refreshNum);
  var size;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future.then<void>((_) {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            TEXT_PRODUCT_DELIVERED,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {},
            )
          ],
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
            Container(
              child: RefreshIndicator(
                onRefresh: () async {
                  return await Future.delayed(Duration(seconds: 3));
                },
                child: ListView.builder(
                    itemCount: 10,
                    controller: _scrollController,
                    itemBuilder: (BuildContext cxt, int index) {
                      return ContainerCardLoading(
                        size: size,
                        onPressedAccepted: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) => FinishPage()));
                        },
                      );
                    }),
              ),
            ),
            Container(
              child: RefreshIndicator(
                onRefresh: () async {
                  return await Future.delayed(Duration(seconds: 3));
                },
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext cxt, int index) {
                      return ContainerCardAccepted(
                          size: size,
                          onPressedDelivered: () {
                            //  Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (BuildContext context) => FinishPage()));
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            FinishedPage()));
                              },
                            );
                          });
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

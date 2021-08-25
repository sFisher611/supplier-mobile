import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:supplier_project/const/const_text.dart';
import 'package:supplier_project/ui/widgets/container_card_finished.dart';

class FinishProductPage extends StatefulWidget {
  @override
  _FinishProductPageState createState() => _FinishProductPageState();
}

class _FinishProductPageState extends State<FinishProductPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            TEXT_FINISHED_TITLE,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.date_range_outlined,
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
              ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext cxt, int index) {
                    return ContainerCardFinished(
                      size: size,
                      product: null,
                    );
                  }),
              ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext cxt, int index) {
                    return ContainerCardFinished(
                      size: size,
                      product: null,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

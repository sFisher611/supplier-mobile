import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';

// ignore: must_be_immutable
class UpdatePage extends StatefulWidget {
  UpdatePage({Key key, this.object}) : super(key: key);
  var object;

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  OtaEvent currentEvent;

  @override
  void initState() {
    super.initState();
  }
  

  Future<void> _tryOtaUpdate() async {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      OtaUpdate()
          .execute(
        widget.object['url'],
        destinationFilename: widget.object['version_name'],
        //FOR NOW ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
        sha256checksum:
            widget.object['sum'],
      )
          .listen(
        (OtaEvent event) {
          setState(() => currentEvent = event);
        },
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }

  var loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: currentEvent == null
              ? Text('Янгиланиш мавжуд')
              : Text('Дастур янгиланмоқда'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: currentEvent != null
              ? Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                        child: Text('Илтимос кутинг...',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${currentEvent.value}%',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: LinearProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                              value: currentEvent.value == ""
                                  ? 100
                                  : double.parse(currentEvent.value) / 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: <Widget>[
                    DraggableScrollableSheet(
                        initialChildSize: 0.78,
                        minChildSize: 0.78,
                        maxChildSize: 0.78,
                        builder: (context, scrolControoller) {
                          return SingleChildScrollView(
                            controller: scrolControoller,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Ўзгаришлар:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Text(
                                        '${widget.object['about']}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        }),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'Дастурнинг янги ${widget.object['version']} версияси мавжуд',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        bottomNavigationBar: loading
            ? null
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 0,
                  child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Container(
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Column(
                            children: <Widget>[
                              // ignore: deprecated_member_use
                              RaisedButton(
                                color: Colors.green,

                                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Text(
                                    "Дастурни янгилаш",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    loading = true;
                                  });
                                  _tryOtaUpdate();
                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              // ignore: deprecated_member_use
                              FlatButton(
                                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Text(
                                    "Бекор қилиш",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 25.0,
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () {
                                  exit(0);
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
      ),
    );
  }
}
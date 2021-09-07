import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supplier_project/http/http_const.dart';
import 'package:supplier_project/http/http_json.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  var _date1;
  var _date2;
  var resObj;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _date1 = DateTime(now.year, now.month - 1, now.day);
    _date2 = DateTime(now.year, now.month, now.day);
    _getPersonal();
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
      _getPersonal();
      setState(() {});
    }
  }

  _getPersonal() async {
    var data = {'start': _date1.toString(), 'finish': _date2.toString()};
    var res = await HttpJson.postJson(HttpConst.personal, data);
    var personal = [];
    if (!res['error']) {
      setState(() {
        resObj = res['data']['data'];
      });
    } else {
      EasyLoading.showInfo(res['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Шахсий профил',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.date_range,
            ),
            onPressed: () {
              dateTimeRangePicker();
            },
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Созламалар'),
                ),
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          buildHead(context),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.98,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: resObj == null
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                color: Colors.grey[400]),
                            child: Text(
                              '   Статистика',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          buildListAbut(
                              Icons.people_alt,
                              'Хизмат курсатилган мижозлар: ',
                              (resObj['delivered'] + resObj['brought'])
                                  .toString()),
                          buildListAbut(
                              Icons.people_alt,
                              'Етказилмаган товарлар сони: ',
                              resObj['accepted']
                                  .toString()),
                          buildListAbut(
                              Icons.check_circle,
                              'Етказилган товарлар сони: ',
                              resObj['delivered'].toString()),
                          buildListAbut(
                              Icons.keyboard_return,
                              'Қайтарилган товарлар сони: ',
                              resObj['brought'].toString()),
                          buildListAbut(
                              Icons.monetization_on,
                              'Хизматлар сони: ',
                              (resObj['delivered'] + resObj['brought'])
                                  .toString()),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildListAbut(icon, text, count) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Center buildHead(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.98,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '0 Сўм',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

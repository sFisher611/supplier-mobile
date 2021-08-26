import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
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
              Icons.access_time,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Созламалар'),
                ),
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
                child: Column(
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
                    buildListAbut(Icons.people_alt,
                        'Хизмат курсатилган мижозлар: ', '25'),
                    buildListAbut(
                        Icons.check_circle, 'Етказилган товарлар сони: ', '25'),
                    buildListAbut(Icons.keyboard_return,
                        'Қайтарилган товарлар сони: ', '25'),
                    buildListAbut(
                        Icons.monetization_on, 'Хизматлар сони: ', '25'),
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

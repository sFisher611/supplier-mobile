import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(UrlLauncherUI());
}

class UrlLauncherUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'URL Launcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _launched;
  String _phone = '';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        forceSafariVC: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sendmail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sendsms(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const String toLaunch =
        'https://www.youtube.com/channel/UC9Zn0mKKK1Ei3Hh8QN_9zcw';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    onChanged: (String text) => _phone = text,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: 'Input the phone number to launch')),
              ),
              RaisedButton(
                color: Colors.blueAccent,
                onPressed: () => setState(() {
                  _launched = _makePhoneCall('tel:$_phone');
                }),
                child: const Text('Make phone call'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
              ),
              RaisedButton(
                color: Colors.redAccent,
                onPressed: () => setState(() {
                  _launched = _sendmail(
                      'mailto:codestudio0110@gmail.com?subject=News&body=New%20plugin');
                }),
                child: const Text('Send Mail'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
              ),
              RaisedButton(
                onPressed: () => setState(() {
                  _launched = _launchInBrowser(toLaunch);
                }),
                child: const Text('Launch in browser'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(toLaunch),
              ),
              RaisedButton(
                color: Colors.orange,
                onPressed: () => setState(() {
                  _launched = _launchInWebViewOrVC("https:www.google.com");
                }),
                child: const Text('Launch in app'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
              ),
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: () => setState(() {
                  _launched = _sendsms('sms:0123456789');
                }),
                child: const Text('Send SMS'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
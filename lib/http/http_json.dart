import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supplier_project/db/local_memory.dart';

import 'http_const.dart';

class HttpJson {
  static loginPasswordJson(url, data) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${data['username']}:${data['password']}'));
    var header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': basicAuth
    };

    try {
      var response = await http.post(Uri.http(HttpConst.main_url, url),
          body: jsonEncode(data), headers: header);

      if (response.statusCode == 200) {
        LocalMemory.dataSave('token', basicAuth);
        var row = {'error': false, 'data': jsonDecode(response.body)};

        return row;
      } else {
        var row = {'error': true, 'message': jsonDecode(response.body)};
        return row;
      }
    } catch (e) {
      var row = {'error': true, 'message': "Сервер билан алоқа йўқ!"};
      return row;
    }
  }

  static getJson(url) async {
    var head = await setHeaders();
    try {
      var res =
          await http.get(Uri.http(HttpConst.main_url, url), headers: head);
      if (res.statusCode < 299) {
        var row = {'error': false, 'data': jsonDecode(res.body)['data']};

        return row;
      } else {
        var row = {'error': true, 'message': "Сервер билан алоқа йўқ!"};
        return row;
      }
    } catch (e) {
      var row = {'error': true, 'message': "Сервер билан алоқа йўқ!"};
      return row;
    }
  }

  static getJsonMessage(url) async {
    var head = await setHeaders();
    try {
      var res =
          await http.get(Uri.http(HttpConst.main_url, url), headers: head);
      if (res.statusCode < 299) {
        var row = {'error': false, 'data': jsonDecode(res.body)};

        return row;
      } else {
        var row = {'error': true, 'message': "Сервер билан алоқа йўқ!"};
        return row;
      }
    } catch (e) {
      var row = {'error': true, 'message': "Сервер билан алоқа йўқ!"};
      return row;
    }
  }

  static postJson(url, data) async {
    var head = await setHeaders();
    try {
      var res = await http.post(Uri.http(HttpConst.main_url, url),
          headers: head, body: jsonEncode(data));
      if (res.statusCode < 299) {
        var row = {'error': false, 'data': jsonDecode(res.body)};

        return row;
      } else {
        var row = {'error': true, 'message': jsonDecode(res.body)};
        return row;
      }
    } catch (e) {
      var row = {'error': true, 'message': "Сервер билан алоқа йўқ!"};
      return row;
    }
  }
  static postJsonOther(url, data) async {
    var head = await setHeaders();
    try {
      var res = await http.post(Uri.https(HttpConst.main_url_other, url),
          headers: head, body: jsonEncode(data));
     
        var row = {'error': false, 'data': jsonDecode(res.body)};

        return row;
    
    } catch (e) {
      var row = {'error': true, 'message': "Сервер билан алоқа йўқ!"};
      return row;
    }
  }
  static Future<Map<String, String>> setHeaders() async {
    var token = await LocalMemory.getData('token');

    var header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token'
    };
    return header;
  }
}

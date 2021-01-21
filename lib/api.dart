import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi{
  final String _url = 'http://192.168.43.170:5000/api/v1/';

  //hantar data
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  //edit data
  putData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.put(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }


  deleteData(apiUrl) async {
    var fullUrl = _url + apiUrl ;
    print(fullUrl);

    return await http.delete(
        fullUrl,
        headers: _setHeaders()
    );
  }


  getData(apiUrl) async {
    var fullUrl = _url + apiUrl ;
    print(fullUrl);

    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

class UserService {
  Dio dio = new Dio();
  Response response;
  Future<Response> getHistory(url, cookies) async {
    try {
      Map<String, dynamic> headers = new Map();
      var token = cookies[0].split(';')[0];
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);
      return response = await dio.get(url, options: options);
    } on DioError catch (e) {
      return response = e.response;
    }
  }

  Future<Response> booking(url, _bookTime, _bookDate, cookies) async {
    try {
      Map<String, dynamic> headers = new Map();
      print('cook booking');
      var token = cookies[0].split(';')[0];
      headers['Cookie'] = token;
      headers['Content-Type'] = 'application/json';
      Options options = new Options(headers: headers);
      int time = _bookTime;
      DateTime date = _bookDate;
      return response = await dio.post(url,
          data: {
            "bookedDate":
                DateTime.parse("2014-08-18T08:00:00").toIso8601String(),
            "bookedTime":
                DateTime.parse("2014-08-18T08:00:00").toIso8601String(),
          },
          options: options);
    } on DioError catch (e) {
      print(e.response);
      return response = e.response;
    }
  }

  Future<Response> updateInfo(
      url, _name, _phone, _address, _avatar, email, cookies) async {
    try {
      Map<String, dynamic> headers = new Map();
      print('cook update');
      var token = cookies[0].split(';')[0];
      print(token);
      headers['Cookie'] = token;

      Options options = new Options(headers: headers);
      if (_avatar != null) {
        String _filename = _avatar.path.split('/').last;
        String _filepath = _avatar.path;
        var formData = new FormData.fromMap({
          "name": _name,
          "phone": _phone,
          "address": _address,
          "avatar":
              await MultipartFile.fromFile(_filepath, filename: _filename),
        });
        response = await dio.put(url, data: formData, options: options);
      }
    } on DioError catch (e) {
      return response = e.response;
    }
    return response;
  }
}

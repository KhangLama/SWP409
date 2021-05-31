import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

class UserService {
  Dio dio = new Dio();
  Response response;

  Future<Response> updateInfo(
      url, _name, _phone, _address, _avatar, cookies) async {
    try {
      Map<String, dynamic> headers = new Map();
      print('cook update');
      print(cookies);
      headers['Cookie'] = cookies;
      headers['Accept'] = 'application/json';
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
        print(formData.fields);
        response = await dio.patch(url, data: formData, options: options);
      }
      if (_avatar == null) {
        var formData = new FormData.fromMap({
          "name": _name,
          "phone": _phone,
          "address": _address,
        });
        print('null');
        print(formData.fields);
        response = await dio.patch(url,
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            }));
      }
    } on DioError catch (e) {
      print(e..response);
      return response = e.response;
    }
    return response;
  }
}

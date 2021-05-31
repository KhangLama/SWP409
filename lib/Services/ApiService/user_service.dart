import 'dart:io';

import 'package:dio/dio.dart';

class UserService {
  Dio dio = new Dio();
  Response response;
  Future<Response> updateInfo(
      url, _name, _phone, _address, _avatar, token) async {
    try {
      if (_avatar != null) {
        String _filename = _avatar.path.split('/').last;
        String _filepath = _avatar.path;
        String _token = token;
        print(_filepath);
        var formData = new FormData.fromMap({
          "name": _name,
          "phone": _phone,
          "address": _address,
          "avatar":
              await MultipartFile.fromFile(_filepath, filename: _filename),
        });
        print(formData.fields);
        print(_token);
        response = await dio.patch(url,
            data: formData,
            options: Options(headers: {
              "Authorization": "Bearer " + _token,
            }));
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

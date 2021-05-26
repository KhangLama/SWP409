import 'dart:io';

import 'package:dio/dio.dart';

class UserService {
  Dio dio = new Dio();
  Response response;
  Future<Response> updateInfo(url, _name, _phone, _address, _avatar) async {
    try {
      if (_avatar != null) {
        String _filename = _avatar.split('/').last;
        String _filepath = _avatar;
        print(_filepath);
        var formData = new FormData.fromMap({
          "name": _name,
          "phone": _phone,
          "address": _address,
          "avatar":
              await MultipartFile.fromFile(_filepath, filename: _filename),
        });
        print(formData.fields);
        response = await dio.patch(url,
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
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

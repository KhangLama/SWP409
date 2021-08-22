import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class AuthService {
  Dio dio = new Dio();
  Response response;
  var cookiejar = CookieJar();
  Map<String, String> headers = {};
  Future<Response> signup(url, name, phone, email, password, repassword) async {
    try {
      response = await dio.post(
        url,
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "passwordConfirm": repassword
        },
        options: Options(headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }),
      );
    } on DioError catch (e) {
      return response = e.response;
    }
    return response;
  }

  Future<Response> login(url, email, password) async {
    dio.interceptors.add(CookieManager(cookiejar));
    try {
      response = await dio.post(
        url,
        data: {
          "email": email,
          "password": password,
        },
        options: Options(headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }),
      );
    } on DioError catch (e) {
      print(e);
      return response = e.response;
    }
    return response;
  }

  Future<Response> changePassword(
      url, currentPassword, newPassword, confirmPassword, cookies) async {
    try {
      Map<String, dynamic> headers = new Map();
      var token = cookies[0].split(';')[0];
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);

      return response = await dio.patch(url,
          data: {
            "passwordCurrent": currentPassword,
            "password": newPassword,
            "passwordConfirm": confirmPassword
          },
          options: options);
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
  Future<Response> forgotPassword(url, email) async {
    try {
      response = await dio.post(url,
          data: {"email": email},
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          }));
    } on DioError catch (e) {
      print(e);
      return response = e.response;
    }
    return response;
  }
}

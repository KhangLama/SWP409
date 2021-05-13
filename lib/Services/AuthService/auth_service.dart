import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Dio dio = new Dio();
  var url =
      Uri.parse('https://clinicbackend1.herokuapp.com/api/v1/users/signup');
  var response;
  signup(name, email, password, repassword) async {
    try {
      return response = await http.post(
        url,
        body: {
          "name": name,
          "email": email,
          "password": password,
          "passwordConfirm": repassword
        },
      );

      // data: {
      //   "name": name,
      //   "email": email,
      //   "password": password,
      //   "passwordConfirm": repassword
      // },
      // options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e.error);
    }
  }
}

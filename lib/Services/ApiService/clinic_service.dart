import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ClinicService {
  Dio dio = new Dio();
  Response response;
  Future<Response> getClinics(url) async {
    try {
      return response = await dio.get(url);
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
  }

  Future<Response> register(
    url,
    email,
    name,
    phone,
    description,
    path,
  ) async {
    try {
      FormData data = new FormData.fromMap({
        "email": email,
        "phone": phone,
        "description": description,
        "name": name,
        "coverImage": await MultipartFile.fromFile(path.path),
      });
      print(data.fields);
      response = await dio.post(url,
          data: data,
          options: Options(headers: {"Content-Type": "application/json"}));
      return response;
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
  }
}

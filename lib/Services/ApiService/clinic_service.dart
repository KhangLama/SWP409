import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:swp409/Models/clinic.dart';

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

  Future<Response> register({url, Clinic clinic, path}) async {
    String geo = jsonEncode(clinic.geometry);
    String schedule = jsonEncode(clinic.schedule);
    try {
      var data = new FormData.fromMap({
        "email": clinic.email,
        "phone": clinic.phone,
        "description": clinic.description,
        "name": clinic.name,
        "schedule": schedule,
        "geometry": geo,
        "coverImage": await MultipartFile.fromFile(path.path),
      });
      print('form');
      print(data.fields);
      response = await dio.post(url,
          data: data,
          options: Options(headers: {"content-type": "application/json"}));
      return response;
    } on DioError catch (e) {
      print('error');
      print(e.response.data);
      return response = e.response;
    }
  }
}

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
    try {
      var data = new FormData.fromMap({
        "email": clinic.email,
        "phone": clinic.phone,
        "description": clinic.description,
        "name": clinic.name,
        "startTimeMonday": clinic.schedule[0].startTime,
        "endTimeMonday": clinic.schedule[0].endTime,
        "startTimeTuesday": clinic.schedule[1].startTime,
        "endTimeTuesday": clinic.schedule[1].endTime,
        "startTimeWednesday": clinic.schedule[2].startTime,
        "endTimeWednesday": clinic.schedule[2].endTime,
        "startTimeThursday": clinic.schedule[3].startTime,
        "endTimeThursday": clinic.schedule[3].endTime,
        "startTimeFriday": clinic.schedule[4].startTime,
        "endTimeFriday": clinic.schedule[4].endTime,
        "startTimeSaturday": clinic.schedule[5].startTime,
        "endTimeSaturday": clinic.schedule[5].endTime,
        "startTimeSunday": clinic.schedule[6].startTime,
        "endTimeSunday": clinic.schedule[6].endTime,
        "geometry": geo,
        "coverImage": await MultipartFile.fromFile(path.path),
      });
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

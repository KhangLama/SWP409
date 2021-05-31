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
    //DateTime.parse("2014-08-18T08:00:00")
    try {
      var data = new FormData.fromMap({
        "email": clinic.email,
        "phone": clinic.phone,
        "description": clinic.description,
        "name": clinic.name,
        "startTimeMonday": DateTime.parse(
            "2014-08-18T${clinic.schedule[0].startTime / 60}:${clinic.schedule[0].startTime % 60}:00"),
        "endTimeMonday": DateTime.parse(
            "2014-08-18T${clinic.schedule[0].endTime / 60}:${clinic.schedule[0].endTime % 60}:00"),
        "startTimeTuesday": DateTime.parse(
            "2014-08-18T${clinic.schedule[1].startTime / 60}:${clinic.schedule[1].endTime % 60}:00"),
        "endTimeTuesday": DateTime.parse(
            "2014-08-18T${clinic.schedule[1].endTime / 60}:${clinic.schedule[1].endTime % 60}:00"),
        "startTimeWednesday": DateTime.parse(
            "2014-08-18T${clinic.schedule[2].startTime / 60}:${clinic.schedule[2].startTime % 60}:00"),
        "endTimeWednesday": DateTime.parse(
            "2014-08-18T${clinic.schedule[2].endTime / 60}:${clinic.schedule[2].endTime % 60}:00"),
        "startTimeThursday": DateTime.parse(
            "2014-08-18T${clinic.schedule[3].startTime / 60}:${clinic.schedule[3].startTime % 60}:00"),
        "endTimeThursday": DateTime.parse(
            "2014-08-18T${clinic.schedule[3].endTime / 60}:${clinic.schedule[3].endTime % 60}:00"),
        "startTimeFriday": DateTime.parse(
            "2014-08-18T${clinic.schedule[4].startTime / 60}:${clinic.schedule[4].startTime % 60}:00"),
        "endTimeFriday": DateTime.parse(
            "2014-08-18T${clinic.schedule[4].endTime / 60}:${clinic.schedule[4].endTime % 60}:00"),
        "startTimeSaturday": DateTime.parse(
            "2014-08-18T${clinic.schedule[5].startTime / 60}:${clinic.schedule[5].startTime % 60}:00"),
        "endTimeSaturday": DateTime.parse(
            "2014-08-18T${clinic.schedule[5].endTime / 60}:${clinic.schedule[5].endTime % 60}:00"),
        "startTimeSunday": DateTime.parse(
            "2014-08-18T${clinic.schedule[6].startTime / 60}:${clinic.schedule[6].startTime % 60}:00"),
        "endTimeSunday": DateTime.parse(
            "2014-08-18T${clinic.schedule[6].endTime / 60}:${clinic.schedule[6].endTime % 60}:00"),
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

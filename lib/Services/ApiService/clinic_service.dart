import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:swp409/Models/clinic.dart';

class ClinicService {
  Dio dio = new Dio();
  Response response;

  Future<Response> getBookingsOfClinic(url, cookies) async {
    try {
      Map<String, dynamic> headers = new Map();
      var token = cookies[0].split(';')[0];
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);
      return response = await dio.get(url, options: options);
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
  }

  Future<Response> addReplyClinic(url, cookies, reply) async {
    try {
      Map<String, dynamic> headers = new Map();
      var token = cookies[0].split(';')[0];
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);

      var formData = new FormData.fromMap({
        "reply": reply,
      });
      print(formData.fields);
      return response = await dio.post(url,
          data: {
            "reply": reply,
          },
          options: options);
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
  }

  Future<Response> addReviewClinic(url, cookies, review, rating) async {
    try {
      Map<String, dynamic> headers = new Map();
      var token = cookies[0].split(';')[0];
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);

      var formData = new FormData.fromMap({
        "rating": rating,
        "review": review,
      });
      print(formData.fields);
      return response = await dio.post(url,
          data: {
            "rating": rating,
            "review": review,
          },
          options: options);
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
  }

  Future<Response> updateInfo(url, Clinic clinic, path, cookies) async {
    String geo = jsonEncode(clinic.geometry);
    try {
      Map<String, dynamic> headers = new Map();
      print('cook update');
      var token = cookies[0].split(';')[0];
      print(token);
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);

      var formData = new FormData.fromMap({
        "email": clinic.email,
        "phone": clinic.phone,
        "description": clinic.description,
        "name": clinic.name,
        "geometry": geo,
        "address": clinic.address,
        "coverImage": await MultipartFile.fromFile(path.path),
      });
      print(formData.fields);
      response = await dio.patch(url, data: formData, options: options);
    } on DioError catch (e) {
      print(e..response);
      return response = e.response;
    }
    return response;
  }

  Future<Response> getClinic(url, cookies) async {
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
        // "startTimeMonday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[0].startTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[0].startTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "endTimeMonday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[0].endTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[0].endTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "startTimeTuesday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[1].startTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[1].startTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "endTimeTuesday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[1].endTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[1].endTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "startTimeWednesday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[2].startTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[2].startTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "endTimeWednesday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[2].endTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[2].endTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "startTimeThursday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[3].startTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[3].startTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "endTimeThursday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[3].endTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[3].endTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "startTimeFriday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[4].startTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[4].startTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "endTimeFriday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[4].endTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[4].endTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "startTimeSaturday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[5].startTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[5].startTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "endTimeSaturday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[5].endTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[5].endTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "startTimeSunday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[6].startTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[6].startTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        // "endTimeSunday": DateTime.parse(
        //     "2014-08-18T${(clinic.schedule[6].endTime ~/ 60).toString().padLeft(2, '0')}:${(clinic.schedule[6].endTime % 60).toInt().toString().padLeft(2, '0')}:00"),
        "geometry": geo,
        "coverImage": await MultipartFile.fromFile(path.path),
      });
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

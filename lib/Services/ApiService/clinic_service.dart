import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:swp409/Models/clinic.dart';

class ClinicService {
  Dio dio = new Dio();
  Response response;

  Future<Response> getSymptomsByDiagnose(url) async {
    try {
      return response = await dio.get(url);
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
  }

  Future<Response> getAllSymptom(url) async {
    try {
      return response = await dio.get(url);
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
  }

  Future<Response> getClinicBySymmtoms(url) async {
    try {
      return response = await dio.get(url);
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
  }

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
    List<String> _specialists = <String>[];
    for (int i = 0; i < clinic.specialists.length; i++) {
      _specialists.add(clinic.specialists[i].id);
    }
    String _spec = jsonEncode(_specialists);
    List<String> schedule = ["[]", "[]", "[]", "[]", "[]", "[]", "[]"];
    for (int i = 0; i < 7; i++) {
      if (clinic.schedule[i].workingHours.length != 0) {
        schedule[i] = "[";
        for (int j = 0; j < clinic.schedule[i].workingHours.length; j++) {
          schedule[i] +=
              "[${clinic.schedule[i].workingHours[j].startTime},${clinic.schedule[i].workingHours[j].endTime}]";
          if (j < clinic.schedule[i].workingHours.length - 1) {
            schedule[i] += ",";
          }
        }
        schedule[i] += "]";
      }
    }
    try {
      Map<String, dynamic> headers = new Map();
      print('cook update');
      var token = cookies[0].split(';')[0];
      print(token);
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);
      if (path != null) {
        String _filename = path.path.split('/').last;
        String _filepath = path.path;
        var formData = new FormData.fromMap({
          "sunday": schedule[0],
          "monday": schedule[1],
          "tuesday": schedule[2],
          "wednesday": schedule[3],
          "thursday": schedule[4],
          "friday": schedule[5],
          "saturday": schedule[6],
          "specialists": _spec,
          "email": clinic.email,
          "phone": clinic.phone,
          "geometry": geo,
          "description": clinic.description,
          "name": clinic.name,
          "address": clinic.address,
          "coverImage":
              await MultipartFile.fromFile(_filepath, filename: _filename),
          "deleteCoverImage": clinic.coverImage.filename,
        });
        print(formData.fields);
        response = await dio.patch(url, data: formData, options: options);
      } else {
        var formData = new FormData.fromMap({
          "sunday": schedule[0],
          "monday": schedule[1],
          "tuesday": schedule[2],
          "wednesday": schedule[3],
          "thursday": schedule[4],
          "friday": schedule[5],
          "saturday": schedule[6],
          "specialists": _spec,
          "email": clinic.email,
          "phone": clinic.phone,
          "geometry": geo,
          "description": clinic.description,
          "name": clinic.name,
          "address": clinic.address,
        });
        print(formData.fields);
        response = await dio.patch(url, data: formData, options: options);
      }
    } on DioError catch (e) {
      print(e..response);
      return response = e.response;
    }
    return response;
  }

  Future<Response> updateSchedule(url, Clinic clinic, cookies) async {
    String _schedule = jsonEncode(clinic.schedule);
    List<String> schedule = ["[]", "[]", "[]", "[]", "[]", "[]", "[]"];
    for (int i = 0; i < 7; i++) {
      if (clinic.schedule[i].workingHours.length != 0) {
        schedule[i] = "[";
        for (int j = 0; j < clinic.schedule[i].workingHours.length; j++) {
          schedule[i] +=
              "[${clinic.schedule[i].workingHours[j].startTime},${clinic.schedule[i].workingHours[j].endTime}]";
          if (j < clinic.schedule[i].workingHours.length - 1) {
            schedule[i] += ",";
          }
        }
        schedule[i] += "]";
      }
    }

    try {
      Map<String, dynamic> headers = new Map();
      print('cook update');
      var token = cookies[0].split(';')[0];
      print(token);
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);
      var formData = new FormData.fromMap({
        "sunday": schedule[0],
        "monday": schedule[1],
        "tuesday": schedule[2],
        "wednesday": schedule[3],
        "thursday": schedule[4],
        "friday": schedule[5],
        "saturday": schedule[6],
      });
      print(formData.fields);
      response = await dio.patch(url,
          data: {
            "sunday": schedule[0],
            "monday": schedule[1],
            "tuesday": schedule[2],
            "wednesday": schedule[3],
            "thursday": schedule[4],
            "friday": schedule[5],
            "saturday": schedule[6],
          },
          options: options);
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

  Future<Response> register({url, Clinic clinic, path, specId}) async {
    String geo = jsonEncode(clinic.geometry);
    String _filename = path.path.split('/').last;
    String _filepath = path.path;
    List<String> schedule = ["[]", "[]", "[]", "[]", "[]", "[]", "[]"];
    for (int i = 0; i < 7; i++) {
      if (clinic.schedule[i].workingHours.length != 0) {
        schedule[i] = "[";
        for (int j = 0; j < clinic.schedule[i].workingHours.length; j++) {
          schedule[i] +=
              "[${clinic.schedule[i].workingHours[j].startTime},${clinic.schedule[i].workingHours[j].endTime}]";
          if (j < clinic.schedule[i].workingHours.length - 1) {
            schedule[i] += ",";
          }
        }
        schedule[i] += "]";
      }
    }
    try {
      var data = new FormData.fromMap({
        "email": clinic.email,
        "phone": clinic.phone,
        "description": clinic.description,
        "name": clinic.name,
        "sunday": schedule[0],
        "monday": schedule[1],
        "tuesday": schedule[2],
        "wednesday": schedule[3],
        "thursday": schedule[4],
        "friday": schedule[5],
        "saturday": schedule[6],
        "specialists": specId,
        "geometry": geo,
        "address": clinic.address,
        "coverImage":
            await MultipartFile.fromFile(_filepath, filename: _filename),
      });
      print(data.fields);
      response = await dio.post(url,
          data: data,
          options: Options(headers: {
            "content-type": "application/json",
            'Accept': 'application/json'
          }));
      return response;
    } on DioError catch (e) {
      print('error');
      print(e.response.data);
      return response = e.response;
    }
  }
}

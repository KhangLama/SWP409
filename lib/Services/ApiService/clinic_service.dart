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
    print(path.path);
    String _filename = path.path.split('/').last;
    String _filepath = path.path;
    try {
      Map<String, dynamic> headers = new Map();
      print('cook update');
      var token = cookies[0].split(';')[0];
      print(token);
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);
      if (path != null) {
        var formData = new FormData.fromMap({
          "email": clinic.email,
          "phone": clinic.phone,
          "description": clinic.description,
          "name": clinic.name,
          "geometry": geo,
          "address": clinic.address,
          "coverImage":
              await MultipartFile.fromFile(_filepath, filename: _filename),
          "filename": _filename
        });
        print(formData.fields);
        response = await dio.patch(url, data: formData, options: options);
      } else {
        var formData = new FormData.fromMap({
          "email": clinic.email,
          "phone": clinic.phone,
          "description": clinic.description,
          "name": clinic.name,
          "geometry": geo,
          "address": clinic.address,
        });
        //print(formData.fields);
        response = await dio.patch(url, data: formData, options: options);
      }
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
    String _schedule = jsonEncode(clinic.schedule);
    String _filename = path.path.split('/').last;
    String _filepath = path.path;
    try {
      var data = new FormData.fromMap({
        "email": clinic.email,
        "phone": clinic.phone,
        "description": clinic.description,
        "name": clinic.name,
        "schedule": _schedule,
        "specialists": specId,
        "geometry": geo,
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

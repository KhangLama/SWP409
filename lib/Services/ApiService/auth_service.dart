import 'package:dio/dio.dart';

class AuthService {
  Dio dio = new Dio();
  Response response;
  Future<Response> signup(url, name, email, phone, password, repassword) async {
    try {
      var data2 = {
        "name": name,
        "email": email,
        "password": password,
        "passwordConfirm": repassword,
        "phone": phone
      };
      response = await dio.post(
        url,
        data: data2,
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
}

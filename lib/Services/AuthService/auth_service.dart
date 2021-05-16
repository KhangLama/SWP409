import 'package:dio/dio.dart';

class AuthService {
  Dio dio = new Dio();
  Response response;
  Future<Response> signup(url, name, email, password, repassword) async {
    try {
      response = await dio.post(
        url,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "passwordConfirm": repassword
        },
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {'token': 'token'}),
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
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
    } on DioError catch (e) {
      return response = e.response;
    } 
    return response;
  }
}

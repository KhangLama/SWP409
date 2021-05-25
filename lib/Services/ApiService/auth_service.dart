import 'package:dio/dio.dart';

class AuthService {
  Dio dio = new Dio();
  Response response;
  Future<Response> signup(url, name, email, password, repassword) async {
    String _name = name,
        _email = email,
        _password = password,
        _repassword = repassword;

    try {
      response = await dio.post(
        url,
        data: {
          "name": _name,
          "email": _email,
          "password": _password,
          "passwordConfirm": _repassword
        },
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
      if (email.isNotEmpty && password.isNotEmpty) {
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
      }
    } on DioError catch (e) {
      print(e);
      return response = e.response;
    }
    return response;
  }
}

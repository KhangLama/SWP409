import 'package:dio/dio.dart';

class AuthService {
  Dio dio = new Dio();

  Response response;
  Future<String> getIPAdress() async {
    
    try {
      final url = 'https://api.ipify.org';
      final res = await dio.get(url);
      return res.statusCode == 200 ? res.data : null;
    } on DioError catch (e) {
      print(e);
      return null;
    }
  }

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
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioError catch (e) {
      print(e.error);
    }
    return response;
  }
}

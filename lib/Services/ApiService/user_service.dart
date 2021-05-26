import 'package:dio/dio.dart';

class UserService {
  Dio dio = new Dio();
  Response response;
  Future<Response> updateInfo(url, _name, _phone, _address) async {
    try {
      response = await dio.patch(url,
          data: {"name": _name, "phone": _phone, "address": _address},
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          }));
    } on DioError catch (e) {
      print(e);
      return response = e.response;
    }
    return response;
  }
}

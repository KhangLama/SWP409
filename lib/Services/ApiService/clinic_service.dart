import 'package:dio/dio.dart';

class ClinicService {
  Dio dio = new Dio();
  Response response;
  Future<Response> register(
    url,
    email,
    name,
    phone,
    description,
    path,
  ) async {
    try {
      if (path != null) {
        String _filename = path.path.split('/').last;
        String _filepath = path.path;
        print(_filepath);
        print(_filename);
        FormData formData = new FormData.fromMap({
          "coverImage":
              await MultipartFile.fromFile(_filepath, filename: _filename),
          "email": email,
          "name": name,
          "phone": phone,
          "description": description,
        });
        print(formData);
        response = await dio.post(url,
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            }));
      } else {
        FormData formData = new FormData.fromMap({
          "email": email,
          "name": name,
          "phone": phone,
          "description": description,
        });
        response = await dio.post(url,
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            }));
      }
    } on DioError catch (e) {
      print(e.response.data);
      return response = e.response;
    }
    return response;
  }
}

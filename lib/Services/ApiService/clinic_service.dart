import 'package:dio/dio.dart';

class ClinicService {
  Dio dio = new Dio();
  Response response;
  Future<Response> register(path, url) async {
    try {
      if (path != null) {
        String _filename = path.path.split('/').last;
        String _filepath = path.path;
        print(_filepath);
        print(_filename);
        FormData formData = new FormData.fromMap({
          "coverImage":
              await MultipartFile.fromFile(_filepath, filename: _filename),
        });
        print(formData);
        response = await dio.post(url,
            data: formData,
            options: Options(headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            }));
      }
    } on DioError catch (e) {
      print(e.response.data['message']);
      return response = e.response;
    }
    return response;
  }
}

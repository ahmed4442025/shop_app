import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static Map<String, String> _headers = {};

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      headers: {'lang': 'ar', 'Content-Type': 'application/json'},
    ));
  }

  static Map<String, dynamic> _setHeaders({String lang = 'ar', String? token}) {
    _headers['lang'] = lang;
    if (token != null) {
      _headers['Authorization'] = token;
    } else if (_headers.containsKey('Authorization')) {
      _headers.remove('Authorization');
    }
    return _headers;
  }

  // get request
  static Future<Response> getData(String url, Map<String, dynamic> query,
      {String lang = 'ar', String? token}) async {
    dio.options.headers = _setHeaders(lang: lang, token: token);
    return await dio.get(url, queryParameters: query);
  }

  // post request
  static Future<Response?> postData(String url, Map<String, dynamic> data,
      {Map<String, dynamic>? query, String lang = 'ar', String? token}) async {
    dio.options.headers = _setHeaders(lang: lang, token: token);
    return await dio.post(url, data: data, queryParameters: query);
  }
}

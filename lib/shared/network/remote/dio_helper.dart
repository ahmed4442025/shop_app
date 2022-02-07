import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static Map<String, String> _headers = {};

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      headers: {'lang': 'ar', 'Content-Type': 'application/json'},
      // connectTimeout: 7 * 1000, // 10 seconds
      // receiveTimeout: 7 * 1000,
    ));
  }

  static Map<String, dynamic> _setHeaders({String? lang, String? token}) {
    if (lang != null) {
      _headers['lang'] = lang;
    }
    if (token != null) {
      _headers['Authorization'] = token;
    }
    return _headers;
  }

  // get request
  static Future<Response> getData(String url,
      {Map<String, dynamic>? query, String? lang, String? token}) async {
    dio.options.headers = _setHeaders(lang: lang, token: token);

    return await dio.get(url, queryParameters: query ?? {});
  }

  // post request
  static Future<Response?> postData(String url, Map<String, dynamic> data,
      {Map<String, dynamic>? query, String? lang, String? token}) async {
    dio.options.headers = _setHeaders(lang: lang, token: token);

    return await dio.post(url, data: data, queryParameters: query);
  }
}

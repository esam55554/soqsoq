import 'package:dio/dio.dart';

class HttpHelper {
  final Dio _dio = Dio();
  static HttpHelper? _instance;

  HttpHelper._();

  static HttpHelper get getInstance {
    // if _instance = null then make it =HttpHelper._()
    _instance ??= HttpHelper._();

    return _instance!;
  }

  Future<Response> getRequest({required String url}) async {
    return await _dio.get(url);
  }

  Future<Response> postRequest({
    required String url,
    required FormData data,
  }) async {
    return await _dio.post(url, data: data);
  }
}

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
  Future<Response<dynamic>> putRequest({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }
  // Download File
  Future<Response<dynamic>> downloadFile({
    required String url,
    required String savePath,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }
  // Upload File (Multipart Request)
  Future<Response<dynamic>> uploadFile({
    required String url,
    required String filePath,
    required String fieldName,
    Map<String, dynamic>? additionalData,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
        ...?additionalData,
      });

      final response = await _dio.post(
        url,
        data: formData,
        queryParameters: queryParameters,
        options: options ?? Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }

  // Upload Multiple Files
  Future<Response<dynamic>> uploadMultipleFiles({
    required String url,
    required List<String> filePaths,
    required String fieldName,
    Map<String, dynamic>? additionalData,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      List<MultipartFile> multipartFiles = [];

      for (String filePath in filePaths) {
        multipartFiles.add(await MultipartFile.fromFile(filePath));
      }

      FormData formData = FormData.fromMap({
        fieldName: multipartFiles,
        ...?additionalData,
      });

      final response = await _dio.post(
        url,
        data: formData,
        queryParameters: queryParameters,
        options: options ?? Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }

}

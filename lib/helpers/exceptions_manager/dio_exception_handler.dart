import 'package:dio/dio.dart';
import 'package:soqsoq/helpers/exceptions_manager/app_exceptions.dart';

class DioExceptionHandler extends AppExceptions {
  @override
  String handle(exception) {
    DioException ex = exception as DioException;
    switch (ex.type) {
      case DioExceptionType.badResponse:
        {
          if (ex.response != null) {
            return ex.response?.data["message"];
          }
        }
      case DioExceptionType.connectionError:
        {
          return "No internet, please check your connection...";
        }
      default:
        return "Unknown error, please contact admin...";
    }

    return "";
  }
}

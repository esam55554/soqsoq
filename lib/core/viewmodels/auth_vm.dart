import 'package:soqsoq/core/constants/api_routes.dart';
import 'package:soqsoq/helpers/exceptions_manager/dio_exception_handler.dart';
import 'package:soqsoq/helpers/http_helper.dart';
import 'package:dio/dio.dart';
import 'package:soqsoq/helpers/local_storage_helper.dart';

class AuthVM {
  final HttpHelper _httpHelper = HttpHelper.getInstance;
  final LocalStorageHelper storageHelper = LocalStorageHelper.getInstance;

  bool checkAuth() {
    if (storageHelper.readKey(key: "token") != null) {
      return true;
    }
    return false;
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      FormData loginInfo = FormData.fromMap({
        "email": email,
        "password": password,
      });
      Response<dynamic> res = await _httpHelper.postRequest(
        url: ApiRoutes.LOGIN,
        data: loginInfo,
      );
      Map<String, dynamic> info = res.data["data"];

      storageHelper.writeKey(key: "token", value: info["token"]);
    } catch (e) {
      if (e is DioException) {
        DioExceptionHandler exceptionHandler = DioExceptionHandler();
        return exceptionHandler.handle(e);
      } else {
        return "Error ~_~";
      }
    }
  }

  logout(){
    storageHelper.removeKey(key: "token");
  }

  register() {}

  resetPassword() {}

  forgetPassword() {}
}

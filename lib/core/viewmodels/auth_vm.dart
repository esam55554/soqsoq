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

      if (info["token"] != null) {
        storageHelper.writeKey(key: "token", value: info["token"]);

        // Store user data if available
        if (info["user"] != null) {
          storageHelper.writeKey(key: "user", value: info["user"]);
        }

        return {
          "success": true,
          "message": "Login successful",
          "data": info
        };
      } else {
        return {
          "success": false,
          "message": "Login failed - No token received"
        };
      }
    } catch (e) {
      if (e is DioException) {
        DioExceptionHandler exceptionHandler = DioExceptionHandler();
        return exceptionHandler.handle(e);
      } else {
        return {
          "success": false,
          "message": "Error ~_~: ${e.toString()}"
        };
      }
    }
  }

  Future<dynamic> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? phone,
    String? address,
  }) async {
    try {
      FormData registerInfo = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        if (phone != null && phone.isNotEmpty) "phone": phone,
        if (address != null && address.isNotEmpty) "address": address,
      });

      Response<dynamic> res = await _httpHelper.postRequest(
        url: ApiRoutes.REGISTER,
        data: registerInfo,
      );

      Map<String, dynamic> info = res.data["data"];

      if (info["token"] != null) {
        storageHelper.writeKey(key: "token", value: info["token"]);

        // Store user data if available
        if (info["user"] != null) {
          storageHelper.writeKey(key: "user", value: info["user"]);
        }

        return {
          "success": true,
          "message": "Registration successful",
          "data": info
        };
      } else {
        return {
          "success": false,
          "message": "Registration failed - No token received"
        };
      }
    } catch (e) {
      if (e is DioException) {
        DioExceptionHandler exceptionHandler = DioExceptionHandler();
        return exceptionHandler.handle(e);
      } else {
        return {
          "success": false,
          "message": "Error ~_~: ${e.toString()}"
        };
      }
    }
  }

  Future<dynamic> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      FormData resetInfo = FormData.fromMap({
        "email": email,
        "token": token,
        "password": password,
        "password_confirmation": passwordConfirmation,
      });

      Response<dynamic> res = await _httpHelper.postRequest(
        url: ApiRoutes.RESET_PASSWORD,
        data: resetInfo,
      );

      return {
        "success": true,
        "message": "Password reset successfully",
        "data": res.data
      };
    } catch (e) {
      if (e is DioException) {
        DioExceptionHandler exceptionHandler = DioExceptionHandler();
        return exceptionHandler.handle(e);
      } else {
        return {
          "success": false,
          "message": "Error ~_~: ${e.toString()}"
        };
      }
    }
  }

  Future<dynamic> forgetPassword({
    required String email,
  }) async {
    try {
      FormData forgetInfo = FormData.fromMap({
        "email": email,
      });

      Response<dynamic> res = await _httpHelper.postRequest(
        url: ApiRoutes.FORGOT_PASSWORD,
        data: forgetInfo,
      );

      return {
        "success": true,
        "message": "Password reset instructions sent to your email",
        "data": res.data
      };
    } catch (e) {
      if (e is DioException) {
        DioExceptionHandler exceptionHandler = DioExceptionHandler();
        return exceptionHandler.handle(e);
      } else {
        return {
          "success": false,
          "message": "Error ~_~: ${e.toString()}"
        };
      }
    }
  }

  Future<dynamic> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      FormData changePasswordInfo = FormData.fromMap({
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
      });

      Response<dynamic> res = await _httpHelper.postRequest(
        url: ApiRoutes.CHANGE_PASSWORD,
        data: changePasswordInfo,
      );

      return {
        "success": true,
        "message": "Password changed successfully",
        "data": res.data
      };
    } catch (e) {
      if (e is DioException) {
        DioExceptionHandler exceptionHandler = DioExceptionHandler();
        return exceptionHandler.handle(e);
      } else {
        return {
          "success": false,
          "message": "Error ~_~: ${e.toString()}"
        };
      }
    }
  }

  Future<dynamic> getProfile() async {
    try {
      Response<dynamic> res = await _httpHelper.getRequest(
        url: ApiRoutes.USER_PROFILE,
      );

      // Update stored user data
      if (res.data["data"] != null) {
        storageHelper.writeKey(key: "user", value: res.data["data"]);
      }

      return {
        "success": true,
        "data": res.data["data"]
      };
    } catch (e) {
      if (e is DioException) {
        DioExceptionHandler exceptionHandler = DioExceptionHandler();
        return exceptionHandler.handle(e);
      } else {
        return {
          "success": false,
          "message": "Error ~_~: ${e.toString()}"
        };
      }
    }
  }

  Future<dynamic> updateProfile({
    String? name,
    String? phone,
    String? address,
  }) async {
    try {
      FormData profileInfo = FormData.fromMap({
        if (name != null && name.isNotEmpty) "name": name,
        if (phone != null && phone.isNotEmpty) "phone": phone,
        if (address != null && address.isNotEmpty) "address": address,
      });

      Response<dynamic> res = await _httpHelper.putRequest(
        url: ApiRoutes.UPDATE_PROFILE,
        data: profileInfo,
      );

      // Update stored user data
      if (res.data["data"] != null) {
        storageHelper.writeKey(key: "user", value: res.data["data"]);
      }

      return {
        "success": true,
        "message": "Profile updated successfully",
        "data": res.data["data"]
      };
    } catch (e) {
      if (e is DioException) {
        DioExceptionHandler exceptionHandler = DioExceptionHandler();
        return exceptionHandler.handle(e);
      } else {
        return {
          "success": false,
          "message": "Error ~_~: ${e.toString()}"
        };
      }
    }
  }

  logout() {
    storageHelper.removeKey(key: "token");
    storageHelper.removeKey(key: "user");
  }

  String? getToken() {
    return storageHelper.readKey(key: "token");
  }

  Map<String, dynamic>? getUser() {
    final userData = storageHelper.readKey(key: "user");
    if (userData != null && userData is Map<String, dynamic>) {
      return userData;
    }
    return null;
  }

  void clearAuthData() {
    storageHelper.removeKey(key: "token");
    storageHelper.removeKey(key: "user");
  }
}
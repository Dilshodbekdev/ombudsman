import 'package:dio/dio.dart';
import 'package:ombudsman/src/core/router/app_routes.dart';
import 'package:ombudsman/src/core/router/route_config.dart';
import 'package:ombudsman/src/core/services/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ombudsman/src/core/util/app_constants.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String token = await Prefs.getString(AppConstants.kAccessToken) ?? "";
    String language = await Prefs.getString(AppConstants.kLanguage) ?? "";
    if (token.isNotEmpty) {
      options.headers["Authorization"] = 'Bearer $token';
    }
    //options.headers["Accept-Language"]=language!='uk'?language:'crl';
    /*options.headers["mobile-app-key"] =
        'xnazorat-3a63daeb0f10ed0f104cc9a2406c9988-mobile';*/

    LogService.request(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    LogService.response(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      rootNavigator.currentContext?.goNamed(AppRoutes.oneId.name);
    }
    LogService.errorResponse(err);
    super.onError(err, handler);
  }
}

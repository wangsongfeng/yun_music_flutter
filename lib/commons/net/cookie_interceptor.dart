import 'package:dio/dio.dart';
import 'package:yun_music/services/auth_service.dart';

class CookieInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (AuthService.to.isLoggedInValue && AuthService.to.cookie != null) {
      options.queryParameters['cookie'] = AuthService.to.cookie;
    }
    options.queryParameters['realIp'] = '182.61.200.7';
    super.onRequest(options, handler);
  }
}

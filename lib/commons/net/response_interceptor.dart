// ignore_for_file: unrelated_type_equality_checks

import 'package:dio/dio.dart';
import 'package:yun_music/commons/values/server.dart';

import 'code.dart';
import 'result_data.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final RequestOptions option = response.requestOptions;

    ResultData value;
    try {
      final header = response.headers[Headers.contentTypeHeader];

      if (header != null && header.toString().contains("text") ||
          (response.statusCode! >= 200 && response.statusCode! < 300)) {
        if (option.path.contains('/login/cellphone')) {
          if (response.data['code'].toString() != '200') {
            value = ResultData(response.data, false, response.data['code'],
                msg: response.data['msg'].toString());
          } else {
            value = ResultData(response.data, true, Code.SUCCESS);
          }
        } else {
          value = ResultData(response.data, true, Code.SUCCESS);
        }
      } else {
        value = ResultData(response.data, false, response.data['code']);
      }
    } catch (e) {
      value = ResultData(response.data, false, response.statusCode!);
    }
    response.data = value;
    handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d("request path ${options.path}");
    super.onRequest(options, handler);
  }

  static Future dioError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.badCertificate:
        return '证书有误！';
      case DioExceptionType.badResponse:
        return '服务器异常，请稍后重试！';
      case DioExceptionType.cancel:
        return '请求已被取消，请重新请求';
      case DioExceptionType.connectionError:
        return '连接错误，请检查网络设置';
      case DioExceptionType.connectionTimeout:
        return '网络连接超时，请检查网络设置';
      case DioExceptionType.receiveTimeout:
        return '响应超时，请稍后重试！';
      case DioExceptionType.sendTimeout:
        return '发送请求超时，请检查网络设置';
      case DioExceptionType.unknown:
        // var res = await checkConect();
        return "res" + " \n 网络异常，请稍后重试！";
    }
  }

  // static Future<dynamic> checkConect() async {
  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return 'connected with mobile network';
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return 'connected with wifi network';
  //   } else if (connectivityResult == ConnectivityResult.ethernet) {
  //     return 'connected with ethernet network';
  //   } else if (connectivityResult == ConnectivityResult.vpn) {
  //     return 'connected with vpn network';
  //   } else if (connectivityResult == ConnectivityResult.other) {
  //     return 'connected with other network';
  //   } else if (connectivityResult == ConnectivityResult.none) {
  //     return 'not connected to any network';
  //   } else {
  //     return "not connected to any network";
  //   }
  // }
}

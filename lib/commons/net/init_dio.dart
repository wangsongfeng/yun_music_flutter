// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:yun_music/commons/net/code.dart';
import 'package:yun_music/commons/net/cookie_interceptor.dart';
import 'package:yun_music/commons/net/response_interceptor.dart';
import 'package:yun_music/commons/net/result_data.dart';
import '../values/server.dart';

class HttpManager {
  final Dio _dio = Dio(BaseOptions(baseUrl: SERVER_API_URL));

  Dio getDio() {
    return _dio;
  }

  HttpManager() {
    _dio.interceptors.add(CookieInterceptor());
    _dio.interceptors.add(ResponseInterceptor());
  }

  Future<ResultData> get(String path, dynamic params,
      {bool noTip = false}) async {
    Response response;
    final Options options = Options();
    ResponseType resType = ResponseType.json;
    options.responseType = resType;
    try {
      response = await _dio.get(path,
          queryParameters:
              params == null ? null : Map<String, dynamic>.from(params),
          options: options);
    } on DioException catch (e) {
      print(e);
      return resultError(e, path, noTip);
    }
    if (response.data is DioException) {
      return resultError(response.data, path, noTip);
    }
    final result = response.data as ResultData;
    return result;
  }

  Future<ResultData> post(String path, dynamic params,
      {bool noTip = false}) async {
    Response response;
    try {
      response = await _dio.post(path, data: params);
    } on DioException catch (e) {
      return resultError(e, path, noTip);
    }
    if (response.data is DioException) {
      return resultError(response.data, path, noTip);
    }
    final result = response.data as ResultData;
    return result;
  }

  Future<ResultData> resultError(
      DioException e, String path, bool noTip) async {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response!;
    } else {
      errorResponse =
          Response(statusCode: 666, requestOptions: RequestOptions(path: path));
    }
    if (e.type == DioErrorType.connectionTimeout ||
        e.type == DioErrorType.receiveTimeout) {
      errorResponse.statusCode = Code.NETWORK_TIMEOUT;
    }
    return ResultData(
        Code.errorHandleFunction(errorResponse.statusCode ?? 500,
            await ResponseInterceptor.dioError(e), noTip),
        false,
        errorResponse.statusCode!);
  }
}

final HttpManager httpManager = HttpManager();

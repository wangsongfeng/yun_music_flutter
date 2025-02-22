// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:yun_music/commons/net/code.dart';
import 'package:yun_music/commons/net/cookie_interceptor.dart';
import 'package:yun_music/commons/net/response_interceptor.dart';
import 'package:yun_music/commons/net/result_data.dart';
import '../values/server.dart';

class HttpManager {
  final Dio _dio = Dio(BaseOptions(baseUrl: SERVER_API_URL));

  static late CookieManager cookieManager;
  static late PathProvider pathProvider;

  Dio getDio() {
    return _dio;
  }

  static Future<bool> init({PathProvider? provider, bool debug = false}) async {
    provider ??= PathProvider();
    pathProvider = provider;

    await provider.init();

    cookieManager = CookieManager(
        PersistCookieJar(storage: FileStorage(provider.getCookieSavedPath())));
    return true;
  }

  HttpManager() {
    _dio.interceptors.add(CookieInterceptor());
    _dio.interceptors.add(ResponseInterceptor());

    _dio.interceptors.add(cookieManager);
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
      logger.d(e);
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

  Future<ResultData> postUri<T>(
    DioMetaData metaData, {
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.postUri(metaData.uri,
          data: metaData.data,
          options: metaData.options,
          cancelToken: cancelToken);
    } on DioException catch (e) {
      logger.d('数据错误 $e');
      return resultError(e, 'path', true);
    }
    if (response.data is DioException) {
      return resultError(response.data, 'path', true);
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

class DioMetaData {
  late Uri uri;
  dynamic data;
  Options? options;

  Error? error;

  DioMetaData(this.uri, {this.data, this.options});

  DioMetaData.error(this.error);
}

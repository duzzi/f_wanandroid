

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';

class CustomInterceptorsWrapper extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtil.v('[${options.path}]request start');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LogUtil.d('[${response.requestOptions.path}]response: ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    LogUtil.e('[${err.response?.requestOptions?.path}]error: ${err.response?.statusCode}');
    super.onError(err, handler);
  }
}
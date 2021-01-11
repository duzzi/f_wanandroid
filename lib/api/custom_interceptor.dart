

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';

class CustomInterceptorsWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    LogUtil.v('[${options.path}]request start');
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    LogUtil.e('[${response.request?.path}]response: ${response.statusCode} ${response.data}');
    return super.onResponse(response);
  }

  @override
  Future onError(DioError error) {
    LogUtil.e('[${error.response?.request?.path}]error: ${error.response?.statusCode}');
    return super.onError(error);
  }
}
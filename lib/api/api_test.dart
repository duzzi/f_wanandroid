import 'package:dio/dio.dart';

import 'api_url.dart';

void main() {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://www.wanandroid.com/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));
  dio.get(ApiUrl.homeBanner).then((value) {
    print('$value');
  });
}

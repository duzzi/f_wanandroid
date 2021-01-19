import 'dart:convert';
import 'dart:io';

import 'package:f_wan/bean/banner/banner_response.dart';
import 'package:f_wan/bean/friend/friend_url_response.dart';
import 'package:f_wan/bean/login/account_info_response.dart';
import 'package:f_wan/utils/sp.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import 'api_url.dart';
import 'custom_interceptor.dart';

class ApiService {
  static Dio dio = Dio(BaseOptions(
    baseUrl: "https://www.wanandroid.com/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  )); // 使用默认配置
  static PersistCookieJar _cookieJar;

  static void init() async {
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptorsWrapper());
  }

  static void getHomeBanner(Function callback) async {
    dio.get(ApiUrl.homeBanner).then((value) {
      Banners banners = Banners.fromJson(value.data);
      callback(true, banners.data);
    }, onError: (error) {
      onError(error, callback);
    });
  }

  static Future<Response> getHomeList(int page) async {
    return await dio.get('${ApiUrl.homeList}$page/json', options: getOptions());
  }

  static void getFriendUrl(Function callback) async {
    dio.get(ApiUrl.friendUrl).then((value) {
      FriendUrlResponse response = FriendUrlResponse.fromJson(value.data);
      callback(true, response.data);
    }, onError: (error) {
      onError(error, callback);
    });
  }

  static Future<Response> getProjectType() async {
    return await dio.get('${ApiUrl.projectType}');
  }

  static Future<Response> getProjectList(int pageIndex, int id) async {
    return await dio.get('${ApiUrl.projectList}$pageIndex/json?cid=$id',
        options: getOptions());
  }

  static Future<Response> getWechatChapter() async {
    return await dio.get('${ApiUrl.wechatChapters}');
  }

  static Future<Response> getWechatArticles(int pageIndex, int id) async {
    return await dio.get('${ApiUrl.wechatChapterArticles}$id/$pageIndex/json',
        options: getOptions());
  }

  static Future<Response> getSearchList(int pageIndex, String word) async {
    return await dio.post('${ApiUrl.search}$pageIndex/json',
        data: FormData.fromMap({'k': word}),
        options: getOptions());
  }

  static Future<Response> getKnowledgeSystem() async {
    return await dio.get('${ApiUrl.treeList}');
  }

  static Future<Response> getKnowledgeSystemArticles(
      int pageIndex, int id) async {
    return await dio.get('${ApiUrl.treeArticleList}$pageIndex/json?cid=$id',
        options: getOptions());
  }

  static Future<Response> getCollectListArticles(int pageIndex) async {
    return await dio.get('${ApiUrl.collectList}$pageIndex/json',
        options: getOptions());
  }

  static Future<Response> getHotKey() async {
    return await dio.get('${ApiUrl.hotKey}');
  }

  static Future<Response> collectArticle(int id) async {
    return await dio.post('${ApiUrl.collectArticle}$id/json',
        options: getOptions());
  }

  static Future<Response> unCollectArticle(int id) async {
    return await dio.post('${ApiUrl.unCollectArticle}$id/json',
        options: getOptions());
  }

  ///登录相关

  static void login(String username, String password, Function callback) async {
    print('ApiService.login $username $password');
    PersistCookieJar cookieJar = await getCookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio
        .post(ApiUrl.login,
            data:
                FormData.fromMap({'username': username, 'password': password}))
        .then((value) {
      print('onLogin ${json.encode(value.data)}');
      var accountInfoRsp = AccountInfoResponse.fromJson(value.data);
      handleLoginData(accountInfoRsp, callback, username, password);
    });
  }

  static Future<PersistCookieJar> getCookieJar() async {
    if (_cookieJar == null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      _cookieJar = PersistCookieJar(dir: "$appDocPath/.cookies/");
      print('ApiService.getCookieJar $_cookieJar');
    }
    return _cookieJar;
  }

  static Future<void> handleLoginData(AccountInfoResponse accountInfoRsp,
      Function callback, String username, String password) async {
    if (accountInfoRsp == null || accountInfoRsp.errorCode != 0) {
      clearAccountInfo();
      //登录失败
      callback(false, accountInfoRsp.errorMsg);
    } else {
      //登录成功
      print('ApiService.handleLoginData _cookieJar $_cookieJar');
      List<Cookie> cookies =
          _cookieJar?.loadForRequest(Uri.parse(ApiUrl.baseUrl));
      if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
          var element = cookies[i];
          var name = element.name;
          var value = element.value;
          var expires = element.expires?.millisecondsSinceEpoch;
          if (name == 'token_pass' && value != null) {
            Sp.putExpire(expires);
            Sp.putCookies(cookies.toString());
            break;
          }
        }
      }
      Sp.putAccountInfo(accountInfoRsp.data);
      Sp.putUserName(username);
      Sp.putPassword(password);
      callback(true, accountInfoRsp.data);
    }
  }

  static void clearAccountInfo() {
    _cookieJar?.deleteAll();
    Sp.putAccountInfo(null);
    Sp.putPassword('');
    Sp.putExpire(-1);
    Sp.putCookies('');
  }

  static void logout(Function callback) async {
    await dio.get(ApiUrl.logout).then((value) {
      print('ApiService.logout ${value.data}');
      clearAccountInfo();
      callback(true, null);
    }, onError: (error) {
      onError(error, callback);
    });
  }

  static void onError(error, Function callback) {
    print('ApiService.getHomeBanner error $error');
    if (error is DioError) {
      print('${error.response?.statusCode}');
      callback(false, error.response?.toString());
    } else {
      callback(false, error);
    }
  }

  static getOptions() {
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = Sp.getCookies();
    Options options = new Options(headers: headers);
    return options;
  }
}

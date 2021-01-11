import 'package:appp/page/mine/login_page.dart';
import 'package:appp/page/search/search_page.dart';
import 'package:appp/page/web/webview_page.dart';
import 'package:flutter/material.dart';

class RouteHelper {
  static void openWebViewPage(BuildContext context, String title, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return WebViewPage(title, url);
    }));
  }

  static void openSearchPage(BuildContext context) {
    openPage(context, SearchPage());
  }

  static Future<dynamic>  openLoginPage(BuildContext context) {
    return openPage(context, LoginPage());
  }

  static Future<dynamic> openPage(BuildContext context, Widget page) {
    return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

}

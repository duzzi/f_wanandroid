import 'package:appp/bean/article/article_item.dart';
import 'package:appp/page/mine/login_page.dart';
import 'package:appp/page/search/search_bar_delegate.dart';
import 'package:appp/page/web/webview_page.dart';
import 'package:flutter/material.dart';

class RouteHelper {
  static void openWebViewPage(BuildContext context, String title, String url,
      {ArticleItem articleItem}) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return WebViewPage(title, url, articleItem: articleItem);
    }));
  }

  static void openSearchPage(BuildContext context) {
    showSearch(
        context: context,
        delegate: SearchBarDelegate(
            hintText: "输入你想搜的", hintTextStyle: TextStyle(fontSize: 14)));
  }

  static Future<dynamic> openLoginPage(BuildContext context) {
    return openPage(context, LoginPage());
  }

  static Future<dynamic> openPage(BuildContext context, Widget page) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}

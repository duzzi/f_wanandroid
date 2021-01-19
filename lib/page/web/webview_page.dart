import 'dart:async';
import 'dart:io';

import 'package:f_wan/api/api_service.dart';
import 'package:f_wan/bean/article/article_item.dart';
import 'package:f_wan/event/event_bus.dart';
import 'package:f_wan/event/event_const.dart';
import 'package:f_wan/manager/account_manager.dart';
import 'package:f_wan/utils/route_helper.dart';
import 'package:f_wan/utils/string_util.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  final ArticleItem articleItem;

  WebViewPage(this.title, this.url, {this.articleItem});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _webViewController;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    _webViewController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strClean(widget.title)),
      ),
      body: buildWebView(),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  WebView buildWebView() {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onPageStarted: (url) {
        LogUtil.v("onPageStarted $url");
      },
      onPageFinished: (url) {
        LogUtil.v("onPageFinished $url");
      },
      gestureNavigationEnabled: true,
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    ArticleItem articleItem = widget.articleItem;
    return FloatingActionButton(
      onPressed: () {
        if (!AccountManager.getInstance().isLogin()) {
          RouteHelper.openLoginPage(context).then((value) {

          });
          return;
        }
        if (articleItem != null) {
          if (!articleItem.collect) {
            ApiService.collectArticle(articleItem.id).then((value) {
              if (value?.data["errorCode"] == 0) {
                setState(() {
                  articleItem.collect = true;
                });
                bus.emit(collectEvent);
              }
            });
          } else {
            ApiService.unCollectArticle(articleItem.originId).then((value) {
              if (value?.data["errorCode"] == 0) {
                setState(() {
                  articleItem.collect = false;
                });
                bus.emit(collectEvent);
              }
            });
          }
        }
      },
      child: articleItem == null || !articleItem.collect
          ? Icon(Icons.favorite_border)
          : Icon(Icons.favorite),
    );
  }
}

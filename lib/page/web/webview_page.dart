import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  WebViewPage(this.title, this.url);

  @override
  _WebViewPageState createState() => _WebViewPageState(this.title, this.url);
}

class _WebViewPageState extends State<WebViewPage> {
  final String title;
  final String url;
  WebViewController _webViewController;

  _WebViewPageState(this.title, this.url);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'like',
            onPressed: () {

            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: url,
            onWebViewCreated: (controller) {
              _webViewController = controller;
              LogUtil.v("onWebViewCreated");
            },
            onPageStarted: (url) {
              LogUtil.v("onPageStarted $url");
            },
            onPageFinished: (url) {
              LogUtil.v("onPageFinished $url");
            },
          ),
          Center(
            child: Text(""),

          ),
        ],
      ),
    );
  }
}

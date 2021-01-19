import 'package:f_wan/api/api_service.dart';
import 'package:f_wan/bean/article/article_type.dart';
import 'package:f_wan/bean/wechat/wechat_chapter.dart';
import 'package:f_wan/bean/wechat/wechat_chapter_response.dart';
import 'package:f_wan/global/app_const.dart';
import 'package:f_wan/page/project/article_list_page.dart';
import 'package:f_wan/utils/string_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WechatPage extends StatefulWidget {
  @override
  _WechatPageState createState() => _WechatPageState();
}

class _WechatPageState extends State<WechatPage> with TickerProviderStateMixin {
  List<Widget> _tabWidgets = [];
  List<WechatChapter> _tabItems = [];
  TabController _controller;

  @override
  void initState() {
    super.initState();
    request();
  }

  @override
  void dispose() {
    _tabItems.clear();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "公众号文章",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        toolbarHeight: 72,
        bottom: buildTabBar(),
      ),
      body: buildTabBarView(),
    );
  }

  Widget buildTabBarView() {
    if (_tabItems.isEmpty) {
      return Center(
          child: Text(
        '${AppConst.noData}',
        style: TextStyle(color: Colors.black26),
      ));
    }
    return TabBarView(
      children: buildPage(),
      controller: _controller,
    );
  }

  List<Widget> buildPage() {
    return _tabItems
        .map((e) => ArticleListPage(ArticleType.wechat, id: e.id,))
        .toList();
  }

  TabBar buildTabBar() {
    if (_tabItems.isEmpty) {
      return null;
    }
    _tabWidgets.clear();
    for (var item in _tabItems) {
      _tabWidgets.add(Text('${strClean(item.name)}'));
    }

    return TabBar(
        tabs: _tabWidgets,
        controller: _controller,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.only(bottom: 2.0),
        indicatorWeight: 2.0,
        indicatorColor: Colors.white,
        labelPadding: EdgeInsets.fromLTRB(8, 4, 8, 4));
  }

  void request() {
    Future<Response> future = ApiService.getWechatChapter();
    future.then((response) {
      WechatChapterResponse rsp = WechatChapterResponse.fromJson(response.data);
      if (rsp.data.isNotEmpty) {
        setState(() {
          _tabItems = rsp.data;
          _controller = TabController(length: _tabItems.length, vsync: this);
        });
      }
    });
  }
}

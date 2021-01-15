import 'package:appp/api/api_service.dart';
import 'package:appp/bean/article/article_type.dart';
import 'package:appp/bean/project/project_type_item.dart';
import 'package:appp/bean/project/project_type_response.dart';
import 'package:appp/global/app_const.dart';
import 'package:appp/page/project/article_list_page.dart';
import 'package:appp/utils/string_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  List<Widget> _tabWidgets = [];
  List<ProjectTypeItem> _tabItems = [];
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
          "项目",
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
    List<Widget> list = [];
    for (var value in _tabItems) {
      list.add(ArticleListPage(ArticleType.project, id: value.id));
    }
    return list;
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
    Future<Response> future = ApiService.getProjectType();
    future.then((response) {
      ProjectTypeResponse rsp = ProjectTypeResponse.fromJson(response.data);
      if (rsp.data.isNotEmpty) {
        setState(() {
          _tabItems = rsp.data;
          _controller = TabController(length: _tabItems.length, vsync: this);
        });
      }
    });
  }
}

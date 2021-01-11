import 'package:appp/global/app_const.dart';
import 'package:appp/page/mine/mine_page.dart';
import 'package:appp/page/project/project_page.dart';
import 'package:appp/page/wechat/wechat_page.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'knowledge/knowledge_system_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    SpUtil.getInstance();
  }

  void updateIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _index,
        children: [HomePage(), ProjectPage(), WechatPage(), KnowledgeSystemPage(), MinePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white30,
        selectedItemColor: Colors.black87,
        items: buildBottomItems(),
        onTap: (value) {
          updateIndex(value);
        },
        currentIndex: _index,
      ),
    );
  }

  List<BottomNavigationBarItem> buildBottomItems() {
    List<BottomNavigationBarItem> list = [];
    for (int i = 0; i < AppConst.mainBottomIcons.length; i++) {
      list.add(
        BottomNavigationBarItem(
            icon: Icon(
              AppConst.mainBottomIcons[i],
              color: Colors.black87,
            ),
            label: AppConst.mainBottomLabels[i]),
      );
    }
    return list;
  }
}

import 'dart:async';
import 'dart:io';

import 'package:f_wan/global/app_const.dart';
import 'package:f_wan/page/mine/mine_page.dart';
import 'package:f_wan/page/project/project_page.dart';
import 'package:f_wan/page/wechat/wechat_page.dart';
import 'package:f_wan/utils/toast_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  bool isQuit = false;
  Timer quitTimer;

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
    return WillPopScope(
      onWillPop: () async {
        if (!Navigator.canPop(context)) {
          if (isQuit) {
            exit(0);
          } else {
            showToast("再按一次退出");
            isQuit = true;
            quitTimer = Timer(Duration(seconds: 2), () {
              isQuit = false;
              quitTimer.cancel();
            });
          }
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _index,
          children: [
            HomePage(),
            ProjectPage(),
            WechatPage(),
            KnowledgeSystemPage(),
            MinePage()
          ],
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

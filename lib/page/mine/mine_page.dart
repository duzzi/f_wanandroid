import 'dart:ui';

import 'package:f_wan/global/app_const.dart';
import 'package:f_wan/manager/account_manager.dart';
import 'example/count_down_progress_example.dart';
import 'example/location_example.dart';
import 'example/permission_example.dart';
import 'file:///E:/FlutterProjects/f_wanandroid/lib/page/mine/example/web_example_page.dart';
import 'package:f_wan/page/setting/setting_page.dart';
import 'package:f_wan/utils/route_helper.dart';
import 'package:f_wan/utils/toast_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'my_collection_list.dart';

class MinePage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MinePage> with WidgetsBindingObserver {
  //新加内容
  AppLifecycleState _state;
  String _username = AppConst.notLogin;

  @override
  void initState() {
    super.initState();
    updateUsername();
    WidgetsBinding.instance.addObserver(this);
  }

  void updateUsername() {
    SpUtil.getInstance().then((value) {
      setState(() {
        _username = isLogin()
            ? '${AccountManager.getInstance().getAccountInfo().username}'
            : AppConst.notLogin;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    var isCurrent = ModalRoute.of(context).isCurrent;
    print('_MyPageState.deactivate $isCurrent');
  }

  //新加内容
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _state = state;
    print("state is --> : $_state");
    switch (state) {
      case AppLifecycleState.resumed:
        updateUsername();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(slivers: [
      SliverAppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'settings',
            onPressed: () {
              RouteHelper.openPage(context, SettingPage()).then((value) {
                updateUsername();
              });
            },
          ),
        ],
        pinned: true,
        stretch: true,
        onStretchTrigger: () {
          showToast('不能再拉了');
          return;
        },
        // title: Text('title'),
        expandedHeight: 200.0,
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: <StretchMode>[
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          centerTitle: true,
          title: Text(_username),
          background: InkWell(
            onTap: () {
              if (isLogin()) {
                showToast('已经登录啦');
              } else {
                RouteHelper.openLoginPage(context).then((value) {
                  updateUsername();
                });
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                isLogin()
                    ? Image.asset(
                        "assets/images/temp.png",
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.black87,
                      ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 0.8),
                      end: Alignment(0.0, 0.0),
                      colors: <Color>[
                        Color(0x70000000),
                        Color(0x30000000),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    radius: 36.0,
                    backgroundImage: AssetImage(
                      isLogin()
                          ? "assets/images/temp.png"
                          : "assets/images/avatar_default.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SliverFixedExtentList(
        itemExtent: 48,
        delegate: SliverChildListDelegate(childrenItem()),
      ),
    ]);
  }

  bool isLogin() => AccountManager.getInstance().isLogin();

  List<Widget> childrenItem() {
    List<Widget> list = [];
    list.add(buildItemWidget('我的收藏',Icons.favorite_outline, () {
      if (!isLogin()) {
        RouteHelper.openLoginPage(context);
        return;
      }
      RouteHelper.openPage(context, MyCollectionListPage());
    }));

    list.add(buildItemWidget("WebViewExample", Icons.web,() {
      RouteHelper.openPage(context, WebViewExample());
    }));

    list.add(buildItemWidget("PermissionPage", Icons.lock_open,() {
      RouteHelper.openPage(context, PermissionPage());
    }));
    list.add(buildItemWidget("CountDownPage", Icons.lock_open,() {
      RouteHelper.openPage(context, CountDownPage());
    }));
    list.add(buildItemWidget("LocationExample", Icons.location_on_outlined,() {
      RouteHelper.openPage(context, LocationExample());
    }));
    for (int i = 0; i < 20; i++) {
      list.add(buildItemWidget("item $i",Icons.android_outlined, () {}));
    }
    return list;
  }

  Widget buildItemWidget(String text, IconData iconData, Function f) {
    return Ink(
      child: InkWell(
        onTap: f,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 8, 8, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(text),
              )),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}

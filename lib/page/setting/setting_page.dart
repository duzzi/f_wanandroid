import 'package:f_wan/api/api_service.dart';
import 'package:f_wan/global/app_const.dart';
import 'package:f_wan/manager/account_manager.dart';
import 'package:f_wan/page/base/base_state.dart';
import 'package:f_wan/page/widget/round_corner_button.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends BaseState<SettingPage> {
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();
    _isLogin = AccountManager.getInstance().isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConst.setting),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: !_isLogin ? 0 : 80,
              child: Center(
                child: RoundCornerButton("退出登录", () {
                  showLoadingDialog(context, text: "退出登录中...");
                  ApiService.logout((success, value) {
                    LogUtil.v('退出登录 $success');
                    dismissLoadingDialog(context);
                    setState(() {
                      _isLogin = AccountManager.getInstance().isLogin();
                    });
                  });
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

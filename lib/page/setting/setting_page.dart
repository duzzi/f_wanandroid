import 'package:appp/api/api_service.dart';
import 'package:appp/global/app_const.dart';
import 'package:appp/manager/account_manager.dart';
import 'package:appp/page/widget/loading_dialog.dart';
import 'package:appp/utils/toast_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                child: Ink(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                      child: Text(
                        '退出登录',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    onTap: () {
                      showLoadingDialog(context, text: "登录中...");
                      ApiService.logout((success, value) {
                        LogUtil.v('退出登录 $success');
                        dismissLoadingDialog(context);
                        setState(() {
                          _isLogin = AccountManager.getInstance().isLogin();
                        });
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:appp/api/api_service.dart';
import 'package:appp/page/base/base_state.dart';
import 'package:appp/page/widget/round_corner_button.dart';
import 'package:appp/utils/toast_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController?.dispose();
    _pwdController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('登录'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: "请输入账号"),
              ),
              TextField(
                controller: _pwdController,
                decoration: InputDecoration(labelText: "请输入密码"),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundCornerButton("登录", () {
                  onLogin(context);
                }),
              )
            ],
          ),
        ));
  }

  void onLogin(BuildContext context) {
    var username = _userNameController.text;
    var password = _pwdController.text;
    print('_LoginPageState.onLogin $username $password');
    if (TextUtil.isEmpty(username)||TextUtil.isEmpty(password)) {
      showToast("用户名或密码不能为空");
      return;
    }
    showLoadingDialog(context, text: "登录中...");
    ApiService.login(username, password, (success, data) {
      dismissLoadingDialog(context);
      if (success) {
        Navigator.pop(context, data);
      } else {
        showToast(data?.toString());
      }
    });
  }
}

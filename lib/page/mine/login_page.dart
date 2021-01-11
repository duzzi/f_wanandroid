import 'package:appp/api/api_service.dart';
import 'package:appp/utils/toast_utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              ),
              TextField(
                controller: _pwdController,
              ),
              RaisedButton(
                onPressed: () {
                  var username = _userNameController.text;
                  var password = _pwdController.text;
                  ApiService.login(username, password, (success, data) {
                    if (success) {
                      Navigator.pop(context, data);
                    } else {
                      showToast(data?.toString());
                    }
                  });
                },
                child: Text('登录'),
              )
            ],
          ),
        ));
  }
}

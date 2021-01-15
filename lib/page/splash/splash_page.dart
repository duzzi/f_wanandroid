import 'dart:async';
import 'dart:io';

import 'package:appp/page/main_page.dart';
import 'package:appp/utils/toast_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  void toMainPage() {
    Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(builder: (context) => MainPage()),
      (route) => route == null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children:[
          Center(
            child: Image(
              image: AssetImage("assets/images/ic_launcher.png"),
              width: 50,
              height: 50,
            ),
          ),


        ],
      ),
    );
  }

  Future<void> checkPermission() async {
    Map<Permission, PermissionStatus> statusMap = await [
      // Permission.location,
      Permission.storage,
    ].request();
    var status = PermissionStatus.granted;
    statusMap.forEach((key, value) {
      print('_SplashPageState.checkPermission $key $value');
      if (status != value) {
        status = value;
      }
    });
    LogUtil.v('checkPermission: $statusMap');
    if (status == PermissionStatus.granted) {
      _timer = Timer(Duration(seconds: 3), toMainPage);
      ///todo 跳过按钮
    } else {
      exit(0);
    }
  }
}

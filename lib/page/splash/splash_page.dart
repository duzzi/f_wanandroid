import 'dart:async';
import 'dart:io';

import 'package:f_wan/page/main_page.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'count_down_button.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showCountDown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Frame has been rendered");
      checkPermission();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  toMainPage() {
    print('_SplashPageState.toMainPage');
    Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(builder: (context) => MainPage()),
      (route) => route == null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Center(
              child: Image(
                image: AssetImage("assets/images/ic_launcher.png"),
                width: 50,
                height: 50,
              ),
            ),
            _showCountDown
                ? Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 30,right: 16),
                    child: CountDownButton(toMainPage))
                : Container()
          ],
        ),
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
      setState(() {
        _showCountDown = true;
      });
    } else {
      exit(0);
    }
  }
}

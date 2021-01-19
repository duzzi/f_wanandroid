import 'dart:async';

import 'package:f_wan/global/app_const.dart';
import 'package:flutter/material.dart';

import 'gradient_progress_indicator.dart';

class CountDownButton extends StatefulWidget {
  final Function _callback;

  CountDownButton(this._callback);

  @override
  _CountDownButtonState createState() => _CountDownButtonState();
}

class _CountDownButtonState extends State<CountDownButton> {
  Timer _timer;
  Timer _progressTimer;
  int _progressTime = 0;

  @override
  void initState() {
    super.initState();
    _timer =
        Timer(Duration(milliseconds: AppConst.countDownTime), widget._callback);
    _progressTimer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        _progressTime += 30;
      });
      if (_progressTime >= AppConst.countDownTime) {
        _timer.cancel();
        _progressTimer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer.isActive) {
      _timer.cancel();
    }
    if (_progressTimer.isActive) {
      _progressTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget._callback,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0x88888888),
                borderRadius: BorderRadius.all(Radius.circular(36))),
            child: GradientCircularProgressIndicator(
              colors: [Colors.blue[700], Colors.blue[300]],
              radius: 36.0,
              stokeWidth: 4.0,
              value: _progressTime / AppConst.countDownTime,
              strokeCapRound: true,
              backgroundColor: Colors.white,
            ),
          ),
          Text(
            "跳过 ${(AppConst.countDownTime - _progressTime + AppConst.oneSeconds) ~/ AppConst.oneSeconds}",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

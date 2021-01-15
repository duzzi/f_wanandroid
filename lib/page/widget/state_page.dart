import 'package:appp/global/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.event_note,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(AppConst.noData),
        ),
      ],
    ));
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(
          //   Icons.sync,
          // ),
          SpinKitWave(
            color: Theme.of(context).primaryColor,
            size: 32,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(AppConst.loading),
          ),
        ],
      )),
    );
  }
}

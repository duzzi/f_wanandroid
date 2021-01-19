
import 'package:f_wan/page/splash/count_down_button.dart';
import 'package:flutter/material.dart';

class CountDownPage extends StatefulWidget {
  @override
  _CountDownPageState createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountDownButton((){
          Navigator.pop(context);
        }),
      ),
    );
  }
}

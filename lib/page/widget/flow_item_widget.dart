import 'package:flutter/material.dart';

class FlowItem extends StatelessWidget {
  final String text;

  FlowItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 15, color: Colors.white),
    );
  }
}

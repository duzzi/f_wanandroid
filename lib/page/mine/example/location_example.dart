import 'dart:async';

import 'package:f_wan/page/widget/location_float_button.dart';
import 'package:flutter/material.dart';

class LocationExample extends StatefulWidget {
  @override
  _LocationExampleState createState() => _LocationExampleState();
}

class _LocationExampleState extends State<LocationExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LocationExample"),),
      floatingActionButton: LocationFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(),
    );
  }
}

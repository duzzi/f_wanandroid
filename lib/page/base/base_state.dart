import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  var loading = false;
  var pageIndex = 0;
  var hasMore = true;
}

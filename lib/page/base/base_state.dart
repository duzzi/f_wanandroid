import 'package:f_wan/page/widget/loading_dialog.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  var loading = false;
  var pageIndex = 0;
  var hasMore = true;

  bool _isShow = false;

  void showLoadingDialog(BuildContext context, {String text}) {
    if (!_isShow) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new LoadingDialog(
              text: text == null ? "loading" : text,
            );
          });
      _isShow = true;
    }
  }

  void dismissLoadingDialog(BuildContext context) {
    if (_isShow) {
      Navigator.of(context).pop();
      _isShow = false;
    }
  }

}

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

ClassicalHeader buildClassicalHeader() {
  return ClassicalHeader(
      refreshingText: '刷新中',
      refreshText: '下拉刷新',
      refreshFailedText: '刷新失败',
      refreshedText: '刷新完毕',
      refreshReadyText: '释放刷新',
      infoText:
          '更新于 ${DateUtil.formatDate(DateTime.now(), format: DateFormats.h_m_s)}',
      infoColor: Colors.black54,
      enableHapticFeedback: false);
}

ClassicalFooter buildClassicalFooter() {
  return ClassicalFooter(
      loadingText: '加载中',
      loadedText: '加载完毕',
      loadReadyText: '',
      loadText: '下拉加载',
      infoText:
          '更新于 ${DateUtil.formatDate(DateTime.now(), format: DateFormats.h_m_s)}',
      infoColor: Colors.black54,
      enableHapticFeedback: false);
}

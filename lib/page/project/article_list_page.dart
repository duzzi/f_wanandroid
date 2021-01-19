import 'package:f_wan/api/api_service.dart';
import 'package:f_wan/bean/article/article_response.dart';
import 'package:f_wan/bean/article/article_model.dart';
import 'package:f_wan/bean/article/article_item.dart';
import 'package:f_wan/bean/article/article_type.dart';
import 'package:f_wan/event/event_bus.dart';
import 'package:f_wan/event/event_const.dart';
import 'package:f_wan/page/base/base_state.dart';
import 'package:f_wan/page/home/article_item_widget.dart';
import 'package:f_wan/page/widget/refresh_header_footer.dart';
import 'package:f_wan/page/widget/state_page.dart';
import 'package:f_wan/utils/toast_utils.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ArticleListPage extends StatefulWidget {
  final int id;
  final String keyword;
  final ArticleType articleType;

  ArticleListPage(this.articleType, {this.id, this.keyword});

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends BaseState<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  List<ArticleItem> _datas;

  _ArticleListPageState();

  @override
  void initState() {
    super.initState();
    bus.on(collectEvent, (arg) {
      Future.delayed(Duration(microseconds: 500), () {
        requestData(true);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    bus.off(collectEvent);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh.custom(
      header: buildClassicalHeader(),
      footer: buildClassicalFooter(),
      slivers: _datas == null
          ? []
          : [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  var item = _datas[index];
                  return ArticleItemWidget(item);
                }, childCount: _datas.length),
              )
            ],
      emptyWidget: _datas != null && _datas.isEmpty ? EmptyPage() : null,
      firstRefresh: true,
      firstRefreshWidget: LoadingPage(),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 0), () {
          requestData(true);
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(milliseconds: 10), () {
          requestData(false);
        });
      },
    );
  }

  List<Widget> buildItems() {
    List<Widget> list = [];
    if (_datas != null && _datas.isNotEmpty) {
      for (var value in _datas) {
        list.add(Text('${value.title} '));
      }
    }
    return list;
  }

  void requestData(bool refresh) {
    if (loading || !mounted || (!hasMore && !refresh)) return;
    if (refresh) pageIndex = 0;
    loading = true;
    Future<Response> future;
    if (widget.articleType == ArticleType.project) {
      future = ApiService.getProjectList(pageIndex, widget.id);
    } else if (widget.articleType == ArticleType.wechat) {
      future = ApiService.getWechatArticles(pageIndex, widget.id);
    } else if (widget.articleType == ArticleType.search) {
      future = ApiService.getSearchList(pageIndex, widget.keyword);
    } else if (widget.articleType == ArticleType.tree) {
      future = ApiService.getKnowledgeSystemArticles(pageIndex, widget.id);
    } else if (widget.articleType == ArticleType.collect) {
      future = ApiService.getCollectListArticles(pageIndex);
    } else {
      future = ApiService.getProjectList(pageIndex, widget.id);
    }

    future.then((value) {
      ArticleResponse projectListResponse =
          ArticleResponse.fromJson(value.data);
      if (projectListResponse?.errorCode != 0) {
        showToast(projectListResponse.errorMsg);
        return;
      }
      ArticleModel model = projectListResponse.data;
      if (model == null) {
        return;
      }
      if (mounted) {
        if (_datas == null) {
          _datas = [];
        }
        setState(() {
          if (pageIndex == 0 || refresh) {
            pageIndex = 0;
            _datas.clear();
          }
          _datas.addAll(model.datas);
          if (widget.articleType == ArticleType.collect) {
            for (var value in _datas) {
              value.collect = true;
            }
          }
        });
      }
      hasMore = !model.over;
      pageIndex++;
    });
    loading = false;
  }

  @override
  bool get wantKeepAlive => true;
}

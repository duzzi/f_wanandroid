import 'package:appp/api/api_service.dart';
import 'package:appp/bean/article/article_response.dart';
import 'package:appp/bean/article/article_model.dart';
import 'package:appp/bean/article/article_item.dart';
import 'package:appp/bean/article/article_type.dart';
import 'package:appp/page/base/base_state.dart';
import 'package:appp/page/home/article_item_widget.dart';
import 'package:appp/page/widget/refresh_header_footer.dart';
import 'package:appp/page/widget/state_page.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ArticleListPage extends StatefulWidget {
  final int id;
  final ArticleType articleType;

  ArticleListPage(this.articleType, this.id);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends BaseState<ArticleListPage> with AutomaticKeepAliveClientMixin {
  List<ArticleItem> _datas = [];

  _ArticleListPageState();

  @override
  void initState() {
    super.initState();

    requestData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh.custom(
      header: buildClassicalHeader(),
      footer: buildClassicalFooter(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            var item = _datas[index];
            return ArticleItemWidget(item);
          }, childCount: _datas.length),
        )
      ],
      emptyWidget: _datas.isEmpty ? EmptyPage() : null,
      firstRefresh: true,
      onRefresh: () async {
        requestData();
      },
      onLoad: () async {
        await Future.delayed(Duration(milliseconds: 100), () {
          requestData();
        });
      },
    );
  }

  List<Widget> buildItems() {
    List<Widget> list = [];
    if (_datas.isNotEmpty) {
      for (var value in _datas) {
        list.add(Text('${value.title} '));
      }
    }
    return list;
  }

  void requestData() {
    if (loading || !mounted || !hasMore) return;

    loading = true;
    Future<Response> future;
    if (widget.articleType == ArticleType.project) {
      future = ApiService.getProjectList(pageIndex, widget.id);
    } else if (widget.articleType == ArticleType.wechat) {
      future = ApiService.getWechatArticles(pageIndex, widget.id);
    } else {
      future = ApiService.getProjectList(pageIndex, widget.id);
    }

    future.then((value) {
      ArticleResponse projectListResponse = ArticleResponse.fromJson(value.data);
      ArticleModel model = projectListResponse.data;
      LogUtil.v(model.datas);
      if (mounted) {
        setState(() {
          if (pageIndex == 0) {
            _datas.clear();
          }
          _datas.addAll(model.datas);
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

import 'dart:math';

import 'package:appp/api/api_service.dart';
import 'package:appp/bean/article/article_item.dart';
import 'package:appp/bean/article/article_model.dart';
import 'package:appp/bean/banner/banner_item.dart';
import 'package:appp/bean/friend/friend_url_item.dart';
import 'package:appp/page/base/base_state.dart';
import 'package:appp/page/home/article_item_widget.dart';
import 'package:appp/page/widget/refresh_header_footer.dart';
import 'package:appp/utils/route_helper.dart';
import 'package:appp/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageStatefulWidget();
  }
}

class HomePageStatefulWidget extends BaseState<HomePage> {
  ScrollController _scrollController = ScrollController();
  var _alpha = 0.0;
  var _offset = 0.0;
  var _banners = <BannerItem>[];
  var _friendUrls = <FriendUrlItem>[];
  List<ArticleItem> _list = <ArticleItem>[];

  @override
  void initState() {
    super.initState();
    initScrollController();
    refresh(); //init
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void initScrollController() {
    _scrollController.addListener(() {
      _offset = _scrollController.offset;
      // LogUtil.v('offset: $offset');
      setState(() {
        if (_offset >= 0) {
          _alpha = min(_offset, 255) / 255.0;
        } else {
          _alpha = 0;
        }
      });
    });
  }

  void requestBanner() {
    ApiService.getHomeBanner((bool success, Object data) {
      LogUtil.v("$data");
      if (data is List<BannerItem>) {
        setState(() {
          _banners.clear();
          _banners.addAll(data);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [buildList(), buildHeader()],
    );
  }

  Scaffold buildList() {
    return Scaffold(
        body: EasyRefresh.custom(
      header: buildClassicalHeader(),
      footer: buildClassicalFooter(),
      slivers: [
        buildBanner(),
        buildGrid(),
        SliverList(delegate: SliverChildListDelegate(createArticleItems())),
      ],
      scrollController: _scrollController,
      onRefresh: () async {
        refresh(); //下拉刷新
      },
      onLoad: () async {
        loadNextPage();
      },
      emptyWidget: (_banners.length + _friendUrls.length + _list.length) == 0
          ? Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                    flex: 2,
                  ),
                  Text(
                    '暂无数据',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[400]),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 3,
                  ),
                ],
              ),
            )
          : null,
    ));
  }

  SliverGrid buildGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 70,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 20.0,
        // childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          FriendUrlItem item = _friendUrls[index];
          return Ink(
            child: InkWell(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.adb),
                    ),
                    Text(
                      '${item.name}',
                      maxLines: 1,
                      style: TextStyle(),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              onTap: () {
                RouteHelper.openWebViewPage(context, item.name, item.link);
              },
            ),
          );
        },
        childCount: _friendUrls.length,
      ),
    );
  }

  void refresh() {
    pageIndex = 0;
    requestBanner();
    requestUrl();
    requestArticleList();
  }

  SliverList buildBanner() {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        color: Colors.white24,
        height: _banners.length == 0 ? 0 : 200,
        child: Swiper(
          autoplay: true,
          pagination: SwiperPagination(),
          transformer: ScaleAndFadeTransformer(),
          itemCount: _banners.length,
          itemBuilder: (context, index) {
            BannerItem item = _banners[index];
            return GestureDetector(
              child: Image.network(
                item.imagePath,
                fit: BoxFit.fitWidth,
              ),
              onTap: () {
                RouteHelper.openWebViewPage(context, item.title, item.url);
              },
            );
          },
        ),
      )
    ]));
  }



  Container buildHeader() {
    return Container(
      height: Utils.navigationBarHeight,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0x21, 0x96, 0xf3, _alpha),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Visibility(
            child: Ink(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)), color: Colors.grey[200]),
              child: InkWell(
                borderRadius: BorderRadius.circular(25.0),
                // highlightColor: Colors.transparent,
                // splashColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      Text(
                        "点击搜索",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  RouteHelper.openSearchPage(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  createArticleItems() {
    var items = <Widget>[];
    for (int i = 0; i < _list.length; i++) {
      ArticleItem item = _list[i];
      items.add(ArticleItemWidget(item));
    }
    return items;
  }

  void requestArticleList() {
    if (loading || !mounted || !hasMore) return;
    loading = true;
    Future<Response> future = ApiService.getHomeList(pageIndex);
    future.then((response) {
      ArticleModel articleModel = ArticleModel.fromJson(response.data['data']);
      if (mounted) {
        setState(() {
          if (pageIndex == 0) {
            _list.clear();
          }
          _list.addAll(articleModel.datas);
        });
      }
      hasMore = !articleModel.over;
      pageIndex++;
    }, onError: (error) {
      print('$error');
    });
    loading = false;
  }

  void loadNextPage() {
    requestArticleList();
  }

  void requestUrl() {
    ApiService.getFriendUrl((bool success, Object data) {
      if (success && data is List<FriendUrlItem>) {
        setState(() {
          _friendUrls.clear();
          if (data.length >= 8) {
            _friendUrls.addAll(data.sublist(0, 8));
          }
        });
      }
    });
  }
}

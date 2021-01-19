import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:f_wan/api/api_service.dart';
import 'package:f_wan/bean/article/article_item.dart';
import 'package:f_wan/bean/article/article_model.dart';
import 'package:f_wan/bean/banner/banner_item.dart';
import 'package:f_wan/bean/friend/friend_url_item.dart';
import 'package:f_wan/page/base/base_state.dart';
import 'package:f_wan/page/home/article_item_widget.dart';
import 'package:f_wan/page/widget/refresh_header_footer.dart';
import 'package:f_wan/page/widget/state_page.dart';
import 'package:f_wan/utils/route_helper.dart';
import 'package:f_wan/utils/utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
      // LogUtil.v('offset: $_offset');
      if (_offset > 0) {
        if (_offset > 256 && _alpha == 1) {
          //避免无用setState，否则容易造成列表滑动不流畅
          return;
        }
        var nowAlpha =
            double.parse((min(_offset, 255) / 255.0).toStringAsFixed(2));
        // LogUtil.v("nowAlpha ${nowAlpha.toStringAsFixed(2)}");
        if (((nowAlpha.abs() - _alpha.abs()).abs() <= 0.03)) {
          return;
        }
        setState(() {
          _alpha = nowAlpha;
        });
        // LogUtil.v("_alpha $_alpha");
      } else {
        // LogUtil.v("_alpha $_alpha");
        if (_alpha == 0) {
          //避免无用setState，否则容易造成列表滑动不流畅
          return;
        }
        setState(() {
          _alpha = 0;
        });
      }
    });
  }

  void requestBanner() {
    ApiService.getHomeBanner((bool success, Object data) {
      LogUtil.v("$data");
      if (data is List<BannerItem>) {
        setState(() {
          _banners = [];
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
            requestArticleList(false);
          },
          // firstRefresh: true,
          // firstRefreshWidget: LoadingPage(),
          emptyWidget:
              (_banners.length + _friendUrls.length + _list.length) == 0 &&
                      pageIndex >= 1
                  ? EmptyPage()
                  : null,
        ));
  }

  SliverGrid buildGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 10.0,
        // childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          FriendUrlItem item = _friendUrls[index];
          return Ink(
            child: InkWell(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.adb),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Text(
                        '${item.name}',
                        maxLines: 1,
                        style: TextStyle(),
                        overflow: TextOverflow.ellipsis,
                      ),
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
    print('HomePageStatefulWidget.refresh request');
    requestBanner();
    requestUrl();
    requestArticleList(true);
  }

  SliverList buildBanner() {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        color: Colors.white24,
        height: _banners.length == 0 ? 0 : 200,
        child: Swiper(
          autoplay: _banners.length == 0 ? false : true,
          pagination: SwiperPagination(),
          transformer: ScaleAndFadeTransformer(),
          itemCount: _banners.length,
          itemBuilder: (context, index) {
            BannerItem item = _banners[index];
            return GestureDetector(
              child: CachedNetworkImage(
                imageUrl: item.imagePath,
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
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  color: Colors.grey[200]),
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

  void requestArticleList(bool refresh) {
    print('HomePageStatefulWidget.requestArticleList');
    if (loading || !mounted || (!hasMore && !refresh)) return;
    if (refresh) pageIndex = 0;
    loading = true;
    Future<Response> future = ApiService.getHomeList(pageIndex);
    future.then((response) {
      ArticleModel articleModel = ArticleModel.fromJson(response.data['data']);
      if (mounted) {
        setState(() {
          if (pageIndex == 0 || refresh) {
            pageIndex = 0;
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

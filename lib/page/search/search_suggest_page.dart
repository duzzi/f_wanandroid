import 'package:f_wan/api/api_service.dart';
import 'package:f_wan/bean/search/hot_key.dart';
import 'package:f_wan/bean/search/hot_key_rsp.dart';
import 'package:f_wan/page/widget/flow_item_widget.dart';
import 'package:f_wan/utils/sp.dart';
import 'package:flutter/material.dart';

import 'search_bar_delegate.dart';

class SearchSuggestPage extends StatefulWidget {
  final SearchBarDelegate searchBarDelegate;

  SearchSuggestPage(this.searchBarDelegate);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchSuggestPage> {
  List<HotKey> hotKeys;
  List<String> _searchList;
  @override
  void initState() {
    super.initState();
    _searchList = Sp.getSearchHistory();
    requestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("历史搜索"),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.delete),
                      ),
                    onTap: (){
                        Sp.clearSearchHistory();
                        setState(() {
                          _searchList = Sp.getSearchHistory();
                        });
                    },
                  )
                ],
              ),
            ),
            Wrap(
              children: buildSearchHistoryWidget(),
              spacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("热门搜索"),
            ),
            Wrap(
              children: buildHotKeyWidget(),
              spacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 10,
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  void requestData() {
    ApiService.getHotKey().then((value) {
      HotKeyRsp rsp = HotKeyRsp.fromJson(value.data);
      if (rsp != null) {
        setState(() {
          hotKeys = rsp.data;
        });
      }
    });
  }

  List<Widget> buildHotKeyWidget() {
    return hotKeys == null
        ? []
        : hotKeys
        .map((e) => buildInk(e.name))
        .toList();
  }

  Ink buildInk(String name) {
    return Ink(
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: InkWell(
        child: Container(
          child: FlowItem('$name'),
          padding: EdgeInsets.fromLTRB(14, 4, 14, 4),
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        onTap: () {
          widget.searchBarDelegate.query = name;
          widget.searchBarDelegate.showResults(context);
        },
      ),
    );
  }

  List<Widget> buildSearchHistoryWidget() {
    return _searchList == null
        ? []
        : _searchList
        .map((e) => buildInk(e))
        .toList();
  }
}

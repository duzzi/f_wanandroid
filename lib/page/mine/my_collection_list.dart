import 'package:f_wan/bean/article/article_type.dart';
import 'package:f_wan/page/project/article_list_page.dart';
import 'package:flutter/material.dart';

class MyCollectionListPage extends StatefulWidget {
  @override
  _MyCollectionListPageState createState() => _MyCollectionListPageState();
}

class _MyCollectionListPageState extends State<MyCollectionListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
      ),
      body: ArticleListPage(ArticleType.collect),
    );
  }
}

import 'package:appp/bean/article/article_type.dart';
import 'package:appp/page/project/article_list_page.dart';
import 'package:appp/utils/route_helper.dart';
import 'package:flutter/material.dart';

class KnowledgeSystemArticlePage extends StatefulWidget {
  final int id;
  final String keyword;

  KnowledgeSystemArticlePage({this.id, this.keyword});

  @override
  _KnowledgeSystemArticlePageState createState() =>
      _KnowledgeSystemArticlePageState();
}

class _KnowledgeSystemArticlePageState
    extends State<KnowledgeSystemArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.keyword),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              RouteHelper.pop(context);
            },
          )),
      body: ArticleListPage(ArticleType.tree, id: widget.id),
    );
  }
}

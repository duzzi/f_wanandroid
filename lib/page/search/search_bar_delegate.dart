import 'package:f_wan/bean/article/article_type.dart';
import 'package:f_wan/page/project/article_list_page.dart';
import 'package:f_wan/page/search/search_suggest_page.dart';
import 'package:f_wan/utils/sp.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  SearchBarDelegate({
    String hintText,
    TextStyle hintTextStyle,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldStyle: hintTextStyle,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
      Center(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
            child: Text("搜索"),
          ),
          onTap: () {
            if(TextUtil.isEmpty(query)){
              return;
            }
            showResults(context);
          },
        ),
      ),
    ];
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);
    Sp.putSearchHistory(query);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResultPage();
  }

  Widget buildSearchResultPage() {
    return ArticleListPage(
      ArticleType.search,
      keyword: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchSuggestPage(this);
  }
}

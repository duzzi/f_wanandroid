import 'package:appp/api/api_service.dart';
import 'package:appp/bean/article/article_type.dart';
import 'package:appp/bean/knowledge/knowledge_system_model.dart';
import 'package:appp/bean/knowledge/knowledge_system_response.dart';
import 'package:appp/page/project/article_list_page.dart';
import 'package:appp/page/widget/flow_item_widget.dart';
import 'package:appp/page/widget/refresh_header_footer.dart';
import 'package:appp/utils/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'knowledge_system_article_page.dart';

class KnowledgeSystemPage extends StatefulWidget {
  @override
  _KnowledgeSystemPageState createState() => _KnowledgeSystemPageState();
}

class _KnowledgeSystemPageState extends State<KnowledgeSystemPage> {
  List<KnowledgeSystemModel> _datas = [];

  @override
  void initState() {
    super.initState();

    requestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('知识体系'),
        centerTitle: true,
      ),
      body: EasyRefresh.custom(
        header: buildClassicalHeader(),
        slivers: [
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            var value = _datas[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(value.name),
                  ),
                  Wrap(
                    children: value.children == null
                        ? []
                        : createFlowItem(value.children),
                    spacing: 16,
                    runSpacing: 10,
                  )
                ],
              ),
            );
          }, childCount: _datas.length))
        ],
        onRefresh: () async => requestData(),
      ),
    );
  }

  void requestData() async {
    ApiService.getKnowledgeSystem().then((value) {
      KnowledgeSystemResponse response =
          KnowledgeSystemResponse.fromJson(value.data);
      if (response != null) {
        List<KnowledgeSystemModel> datas = response.data;
        if (datas != null && datas.isNotEmpty) {
          setState(() {
            _datas.clear();
            _datas.addAll(datas);
          });
        } else {}
      }
    });
  }

  List<Widget> createFlowItem(List<KnowledgeSystemModel> children) {
    return children
        .map((e) => Ink(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: InkWell(
                child: Container(
                  child: FlowItem('${e.name}'),
                  padding: EdgeInsets.fromLTRB(14, 4, 14, 4),
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                onTap: () {
                  RouteHelper.openPage(
                      context,
                      KnowledgeSystemArticlePage(
                        id: e.id,
                        keyword: e.name,
                      ));
                },
              ),
            ))
        .toList();
  }
}

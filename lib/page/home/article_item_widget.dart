import 'package:appp/utils/route_helper.dart';
import 'package:appp/utils/string_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:appp/bean/article/article_item.dart';

class ArticleItemWidget extends StatelessWidget {
  final ArticleItem _item;

  ArticleItemWidget(this._item);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shadowColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              RouteHelper.openWebViewPage(context, _item.title, _item.link,articleItem: _item);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      buildTitleDesc(),
                      buildPic(),
                    ],
                  ),
                  buildBottomRow()
                ],
              ),
            ),
          ),
        ),
        // padding: EdgeInsets.all(10),
        // color: Colors.white,
      ),
    );
  }

  Expanded buildTitleDesc() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strClean(_item.title),
            style: TextStyle(color: Colors.black87, fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: _item.desc.isEmpty
                ? EdgeInsets.zero
                : const EdgeInsets.only(top: 6, bottom: 6),
            child: Text(
              strClean(_item.desc),
              style: TextStyle(color: Colors.grey[500]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPic() {
    bool hasPic = !TextUtil.isEmpty(_item.envelopePic);
    return !hasPic
        ? Container(
            width: 0,
            height: 0,
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CachedNetworkImage(
              imageUrl: _item.envelopePic,
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    strokeWidth: 2,
                  ),
                  height: 20,
                  width: 20,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 64,
              height: 96,
            ),
          );
  }

  Row buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Offstage(
          offstage: _item.tags == null || _item.tags.isEmpty,
          child: Container(
              padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
              child: _item.tags == null || _item.tags.isEmpty
                  ? null
                  : Text(
                      _item.tags[0].name,
                      style: buildBottomTextStyle(),
                    ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green[500],
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            _item.superChapterName == null ? "" : _item.superChapterName,
            style: buildBottomTextStyle(),
          ),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            _item.author == null
                ? (_item.shareUser == null ? "" : _item.shareUser)
                : (_item.author),
            style: buildBottomTextStyle(),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time,
              size: 15,
              color: Colors.grey[500],
            ),
            Container(
              width: 2,
            ),
            Text(
              _item.niceDate == null ? "" : _item.niceDate,
              style: buildBottomTextStyle(),
            ),
          ],
        ),
      ],
    );
  }

  TextStyle buildBottomTextStyle() =>
      TextStyle(color: Colors.grey[500], fontSize: 13);
}

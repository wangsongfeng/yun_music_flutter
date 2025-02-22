import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/search/models/search_hot_wrap.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';

class SearchHotlist extends StatelessWidget {
  const SearchHotlist({super.key, required this.title, this.searchHotList});

  final String title;

  final List<SearchHotDataItem>? searchHotList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adapt.screenW() - Adapt.px(160),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppThemes.color_250,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        borderRadius: BorderRadius.circular(6.0),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      margin: const EdgeInsets.only(left: 16, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            width: double.infinity,
            height: 0.8,
            color: AppThemes.diver_color,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: searchHotList!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 16),
            itemBuilder: (BuildContext context, int index) {
              bool isTop = index <= 2;
              SearchHotDataItem item = searchHotList![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Text(
                      "${index + 1}",
                      style: headline2Style().copyWith(
                          fontSize: 16,
                          color: isTop ? Colors.red : AppThemes.textColor999),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        item.searchWord ?? "",
                        softWrap: true,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: headline2Style().copyWith(
                            fontSize: 15,
                            color:
                                isTop ? Colors.black : AppThemes.textColor999),
                      ),
                    ))
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}

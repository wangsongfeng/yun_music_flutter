import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/search/models/search_hot_wrap.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/values/function.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';

class SearchHottopic extends StatelessWidget {
  const SearchHottopic(
      {super.key,
      required this.title,
      this.searchTopicList,
      required this.searchChange});

  final String title;

  final List<SearchHotTopicItem>? searchTopicList;

  final ParamSingleCallback<String> searchChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adapt.screenW() - Adapt.px(160),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color.fromRGBO(38, 37, 42, 1.0)
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color:
                context.isDarkMode ? Colors.transparent : AppThemes.color_250,
            offset: const Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        borderRadius: BorderRadius.circular(6.0),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      margin: const EdgeInsets.only(left: 8, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: body1Style()
                .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            width: double.infinity,
            height: 0.8,
            color: context.isDarkMode
                ? AppThemes.diver_color.withOpacity(0.1)
                : AppThemes.diver_color,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: searchTopicList!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 16),
            itemBuilder: (BuildContext context, int index) {
              bool isTop = index <= 2;
              SearchHotTopicItem item = searchTopicList![index];
              return GestureDetector(
                onTap: () {
                  searchChange.call(item.title ?? "");
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Text(
                        "${index + 1}",
                        style: headline2Style().copyWith(
                            fontSize: 16,
                            color: isTop
                                ? Colors.red
                                : context.isDarkMode
                                    ? Colors.white
                                    : AppThemes.textColor999),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          item.title ?? "",
                          softWrap: true,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: headline2Style().copyWith(
                              fontSize: 15,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : isTop
                                      ? Colors.black
                                      : AppThemes.textColor999),
                        ),
                      ))
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}

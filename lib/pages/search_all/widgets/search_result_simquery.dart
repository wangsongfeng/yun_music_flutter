// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';

import '../../../commons/values/function.dart';
import '../../../utils/adapt.dart';
import '../../search/models/search_result_wrap.dart';
import 'search_result_header.dart';

class SearchResultSimquery extends StatelessWidget {
  const SearchResultSimquery(
      {super.key, this.simQuery, required this.searchChange});
  final SearchComplexSimQuery? simQuery; //相关搜索
  final ParamSingleCallback<String> searchChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchResultHeader(title: "相关搜索", showRightBtn: false),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: simQuery!.sim_querys
                    .map((e) => GestureDetector(
                          onTap: () {
                            searchChange.call(e.keyword ?? "");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, bottom: 5, top: 5),
                            decoration: const BoxDecoration(
                                color: AppThemes.color_237,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: Text(
                              e.keyword ?? "",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontFamily: W.fonts.IconFonts,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        )
      ],
    );
  }
}

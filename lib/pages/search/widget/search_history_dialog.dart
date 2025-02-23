import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../../commons/values/function.dart';

class SearchHistoryDialog extends StatelessWidget {
  const SearchHistoryDialog(
      {super.key, this.sureCall, this.onClose, required this.content});

  final ParamVoidCallback? sureCall;
  final ParamVoidCallback? onClose;

  final String content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            width: Adapt.px(300),
            height: Adapt.px(136),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 30, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: AppThemes.body1_txt_color,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            onClose!.call();
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(22)),
                                border: Border.all(
                                    width: Dimens.gap_dp1,
                                    color: AppThemes.color_173)),
                            child: const Center(
                              child: Text(
                                '取消',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            sureCall!.call();
                          },
                          child: Container(
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22)),
                            ),
                            child: const Center(
                              child: Text(
                                '确定',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: Dimens.gap_dp12),
          IconButton(
              onPressed: () {
                onClose!.call();
              },
              icon: Image.asset(
                ImageUtils.getImagePath('cm6_post_event_image_close'),
                width: 30,
              ))
        ],
      ),
    );
  }
}

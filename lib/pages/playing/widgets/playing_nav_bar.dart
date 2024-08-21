import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/models/song_model.dart';
import '../../../commons/res/dimens.dart';
import '../../../utils/image_utils.dart';

class PlayingNavBar extends StatelessWidget implements PreferredSizeWidget {
  const PlayingNavBar({super.key, this.song});

  final Song? song;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: Get.theme.appBarTheme.toolbarHeight,
      width: double.infinity,
      // padding: EdgeInsets.only(left: Adapt.px(2), right: Adapt.px(10)),
      margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(left: 16),
              child: Image.asset(
                ImageUtils.getImagePath('cm8_nav_icn_down'),
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  song?.name ?? "",
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: Dimens.gap_dp18,
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        song?.arString() ?? "",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: Dimens.font_sp13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: Dimens.gap_dp18,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(right: 16),
            child: Image.asset(
              ImageUtils.getImagePath('cm6_nav_icn_share'),
              width: 28,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.theme.appBarTheme.toolbarHeight ?? 56);
}

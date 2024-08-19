// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/skeleton/music_skeleton.dart';

class MusicRecmSkeleton extends StatelessWidget {
  const MusicRecmSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //1
        Container(
          color: Get.theme.cardColor,
          child: Skeleton(
            child: Container(
              color: Get.theme.cardColor,
              height: Dimens.gap_dp140,
              margin: EdgeInsets.fromLTRB(
                  Dimens.gap_dp15, Dimens.gap_dp5, Dimens.gap_dp15, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: AppThemes.color_245,
                ),
              ),
            ),
          ),
        ),

        //2
        Container(
          color: Get.theme.cardColor,
          height: Dimens.gap_dp95,
          child: ListView.separated(
              padding: EdgeInsets.only(
                  left: Dimens.gap_dp15, right: Dimens.gap_dp15),
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Skeleton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: Dimens.gap_dp46,
                          height: Dimens.gap_dp46,
                          color: AppThemes.color_245,
                        ),
                      ),
                      SizedBox(height: Dimens.gap_dp5),
                      Container(
                        width: Dimens.gap_dp46,
                        height: 15,
                        color: AppThemes.color_245,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: Dimens.gap_dp24);
              },
              itemCount: 6),
        ),

        //3
        buildPlayListContent(context),

        // buildPlayListContent(context),
      ],
    );
  }

  Widget buildPlayListContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
      ),
      child: SizedBox(
        height: Dimens.gap_dp213,
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Skeleton(
                child: Container(
                  height: Dimens.gap_dp48,
                  padding: EdgeInsets.only(top: Dimens.gap_dp5),
                  margin: EdgeInsets.only(
                      left: Dimens.gap_dp15, right: Dimens.gap_dp15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: Dimens.gap_dp120,
                          height: Dimens.gap_dp24,
                          decoration: const BoxDecoration(
                            color: AppThemes.color_245,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          )),
                      Container(
                          width: Dimens.gap_dp48,
                          height: Dimens.gap_dp24,
                          decoration: const BoxDecoration(
                            color: AppThemes.color_245,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          )),
                    ],
                  ),
                ),
              ),
            ),

            //横向滚动
            Flexible(
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp15, right: Dimens.gap_dp15),
                  itemBuilder: (context, index) {
                    return Skeleton(
                      child: SizedBox(
                        height: Dimens.gap_dp109,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Dimens.gap_dp4,
                              margin: EdgeInsets.only(
                                  left: Dimens.gap_dp12,
                                  right: Dimens.gap_dp12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300.withOpacity(0.4),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(Dimens.gap_dp12),
                                    topRight: Radius.circular(Dimens.gap_dp12)),
                              ),
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(Dimens.gap_dp10),
                              child: Container(
                                width: Dimens.gap_dp105,
                                height: Dimens.gap_dp105,
                                color: AppThemes.color_245,
                              ),
                            ),
                            SizedBox(height: Dimens.gap_dp5),
                            Container(
                                width: Dimens.gap_dp76,
                                height: Dimens.gap_dp14,
                                decoration: const BoxDecoration(
                                  color: AppThemes.color_245,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                )),
                            SizedBox(height: Dimens.gap_dp5),
                            Container(
                                width: Dimens.gap_dp60,
                                height: Dimens.gap_dp14,
                                decoration: const BoxDecoration(
                                  color: AppThemes.color_245,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: Dimens.gap_dp9);
                  },
                  itemCount: 6),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/single_category/single_category_controller.dart';
import 'package:yun_music/utils/image_utils.dart';

class SingleCatHeader extends StatelessWidget {
  const SingleCatHeader({super.key, required this.controller});

  final SingleCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: Colors.white,
          width: double.infinity,
          height: controller.headerH.value,
          child: Stack(
            children: [
              if (controller.headerAlpha.value == 1.0)
                AnimatedOpacity(
                  opacity: controller.headerAlpha.value,
                  duration: controller.headerAlpha.value == 1.0
                      ? const Duration(milliseconds: 300)
                      : const Duration(milliseconds: 100),
                  child: SizedBox(
                      height: controller.headerH.value,
                      child: _buildCategoryView()),
                )
              else
                const SizedBox.shrink(),
              if (controller.sortAlpha.value == 1.0)
                AnimatedOpacity(
                  opacity: controller.sortAlpha.value,
                  duration: controller.sortAlpha.value == 1.0
                      ? const Duration(milliseconds: 300)
                      : const Duration(milliseconds: 100),
                  child: _buildSortView(),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ));
  }

  Widget _buildCategoryView() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: controller.areaList
                .map((e) => GestureDetector(
                      onTap: () {
                        controller.setCurrentArea(e);
                      },
                      child: Row(
                        children: [
                          Text(e["name"]!,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: controller.currentArea["area"] ==
                                          e["area"]
                                      ? Colors.red
                                      : AppThemes.body1_txt_color
                                          .withOpacity(0.9))),
                          const SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
          Row(
            children: controller.typeList
                .map((e) => GestureDetector(
                      onTap: () {
                        controller.setCurrenttype(e);
                      },
                      child: Row(
                        children: [
                          Text(e["name"]!,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: controller.currentType["type"] ==
                                          e["type"]
                                      ? Colors.red
                                      : AppThemes.body1_txt_color
                                          .withOpacity(0.9))),
                          const SizedBox(
                            width: 46,
                          )
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _buildSortView() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            (controller.currentArea["area"] == "-1" &&
                    controller.currentType["type"] == "-1")
                ? "全部歌手"
                : "${controller.currentArea["name"]}.${controller.currentType["name"]}",
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppThemes.textColor333),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              controller.headerH.value = 78.0;
              controller.headerAlpha.value = 1.0;
              controller.sortAlpha.value = 0.0;
            },
            child: Row(
              children: [
                Image.asset(
                  ImageUtils.getImagePath("cm_btn_filter"),
                  width: 14,
                ),
                const SizedBox(width: 4),
                const Text(
                  "筛选",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppThemes.body2_txt_color),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

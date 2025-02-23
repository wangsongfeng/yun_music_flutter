// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/mine/mine_controller.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/widgets/network_img_layer.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';

class MineAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MineAppbar({super.key, required this.controller});

  final MineController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: Colors.white.withOpacity(controller.appbar_alpha.value),
        width: Adapt.screenW(),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 6, top: Adapt.topPadding(), right: 6),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Container(
                    color: Colors.transparent,
                    height: 50,
                    width: 50,
                    padding:
                        EdgeInsets.only(left: Adapt.px(2), right: Adapt.px(10)),
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset(
                          ImageUtils.getImagePath('home_top_bar_menus'),
                          color: controller.appbar_alpha.value < 0.2
                              ? Colors.white
                              : AppThemes.body2_txt_color
                                  .withOpacity(controller.appbar_alpha.value),
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox.shrink()),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    width: 50,
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 26,
                        height: 26,
                        child: Image.asset(
                          ImageUtils.getImagePath('home_top_bar_search'),
                          color: controller.appbar_alpha.value < 0.2
                              ? Colors.white
                              : AppThemes.body2_txt_color
                                  .withOpacity(controller.appbar_alpha.value),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    width: 50,
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 26,
                        height: 26,
                        child: Image.asset(
                          ImageUtils.getImagePath('cb'),
                          color: controller.appbar_alpha.value < 0.2
                              ? Colors.white
                              : AppThemes.body2_txt_color
                                  .withOpacity(controller.appbar_alpha.value),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: Adapt.screenW(),
              height: 50,
              padding: const EdgeInsets.only(left: 6, top: 0, right: 6),
              child: Center(
                child: Stack(
                  children: [
                    Obx(() {
                      return AnimatedOpacity(
                        opacity: controller.appbar_alpha.value == 0.0 ? 1.0 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageUtils.getImagePath('a-jiayou'),
                              width: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '加油',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(1.0),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      );
                    }),
                    Obx(() {
                      return AnimatedOpacity(
                        opacity: controller.appbar_alpha.value >= 1.0 ? 1.0 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: AnimatedSlide(
                          offset: Offset(0,
                              controller.appbar_alpha.value >= 1.0 ? 0 : -0.5),
                          duration: const Duration(milliseconds: 100),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: NetworkImgLayer(
                                  width: 24,
                                  height: 24,
                                  src:
                                      'https://q1.itc.cn/q_70/images03/20240807/4802bc995acb4420bcc4b49035244907.jpeg',
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '那个人那个梦',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(50 + Adapt.topPadding());
}

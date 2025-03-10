// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/mine/mine_controller.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../../commons/widgets/network_img_layer.dart';

class MineHeader extends StatelessWidget {
  const MineHeader({super.key, required this.controller});

  final MineController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height:
              controller.headerHeight.value + controller.extraPicHeight.value,
          color: Colors.black87,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 0),
                child: Image.asset(
                  ImageUtils.getImagePath('mine_header'),
                  height: double.infinity,
                  width: Adapt.screenW(),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                  child: Container(
                color: Colors.black87.withOpacity(0.1),
              )),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: Adapt.screenW(),
                  height: 200,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                        0.0,
                        0.5,
                        1.0
                      ], //[渐变起始点, 渐变结束点]
                          //渐变颜色[始点颜色, 结束颜色]
                          colors: [
                        Color.fromRGBO(15, 15, 15, 0),
                        Color.fromRGBO(15, 15, 15, 0.8),
                        Color.fromRGBO(15, 15, 15, 0.9)
                      ])),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(42)),
                          border: Border.all(width: 1.0, color: Colors.white)),
                      width: 84,
                      height: 84,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(42)),
                        child: NetworkImgLayer(
                          width: 84,
                          height: 84,
                          src:
                              'https://q1.itc.cn/q_70/images03/20240807/4802bc995acb4420bcc4b49035244907.jpeg',
                        ),
                      ),
                    ),
                    _buildUserNameWidget(),
                    _buildTimeWidget(),
                    _buildCountWidget(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildRowBtnWidget('zuijinbofang', '最近'),
                          buildRowBtnWidget('down_5', '本地'),
                          buildRowBtnWidget('huiyunpan1', '云盘'),
                          buildRowBtnWidget('iocn_yigoumaide', '最近'),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.15),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageUtils.getImagePath('mine_menu1'),
                                  width: 14,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget buildRowBtnWidget(String imagename, String title) {
    return GestureDetector(
      onTap: () {
        print("1");
      },
      child: Container(
        width: 80,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageUtils.getImagePath(imagename),
              width: 16,
              color: Colors.white,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCountWidget() {
    return Container(
      padding: const EdgeInsets.only(bottom: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCountItem('3', '关注'),
          _buildCountItem('2', '粉丝'),
          _buildCountItem('Lv.8', '等级'),
          _buildCountItem('378时', '听歌'),
        ],
      ),
    );
  }

  Widget _buildCountItem(String count, String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 2),
          Text(
            name,
            style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeWidget() {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageUtils.getImagePath('mine_huizhang'),
            color: Colors.white.withOpacity(0.7),
            width: 10,
          ),
          const SizedBox(width: 3),
          Text(
            '9枚徽章',
            style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 8),
          Container(
            width: 0.8,
            height: 6,
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(width: 8),
          Text(
            '河南 郑州',
            style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 8),
          Container(
            width: 1.5,
            height: 1.5,
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(width: 8),
          Text(
            '村龄7年',
            style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildUserNameWidget() {
    return Container(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '那个人那个梦',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              Image.asset(
                ImageUtils.getImagePath('cm8_settingtab_vipcard_free_icon'),
                width: 60,
                height: 20,
              )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '北城以念，何以为安',
            style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

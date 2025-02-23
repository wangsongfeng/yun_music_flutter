import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/pages/dynamic_page/models/square_info.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/values/function.dart';
import '../../../commons/widgets/network_img_layer.dart';
import '../../../commons/widgets/parsed_text/match_text.dart';
import '../../../commons/widgets/parsed_text/parsed_text.dart';
import '../../../utils/image_utils.dart';

class SquareListItem extends StatefulWidget {
  const SquareListItem({super.key, required this.model});

  final SquareList model;

  @override
  State<SquareListItem> createState() => _SquareListItemState();
}

class _SquareListItemState extends State<SquareListItem> {
  String? get identityIconUrl => null;

  Future onLikeDynamic() async {
    int count = widget.model.likeNum!;
    bool status = widget.model.zanStatus! > 0 ? true : false;
    if (status) {
      widget.model.likeNum = count - 1;
      widget.model.zanStatus = 0;
    } else {
      widget.model.likeNum = count + 1;
      widget.model.zanStatus = 1;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 6, left: 16, right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //头像
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              creatAvatar(widget.model.userInfo!.headurl!, identityIconUrl),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.userInfo!.nick!,
                    style: const TextStyle(
                        color: AppThemes.body1_txt_color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.model.userInfo!.decs!,
                    style: const TextStyle(
                        color: AppThemes.color_165,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48 + 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textContent(widget.model.content!, context, false),
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  child: _buildNineGuard(widget.model.picurl!),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 16),
                  child: _creatMenuPage(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //头像
  Widget creatAvatar(String avatar, String? identityIconUrl) {
    double size = 48.0;
    return NetworkImgLayer(
      width: size * 1.1,
      height: size,
      src: avatar,
      customplaceholder: Container(
        width: size,
        height: size,
        color: AppThemes.white,
        child: Image.asset(
          ImageUtils.getImagePath('icon_avatar_nor'),
          color: AppThemes.color_204,
        ),
      ),
      imageBuilder: (context, imageProvider) {
        return SizedBox(
          width: size * 1.1,
          height: size,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipOval(
                child: Image(
                  image: imageProvider,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
              ),
              if (identityIconUrl != null)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ClipOval(
                    child: NetworkImgLayer(
                        width: 0.4 * size,
                        height: 0.4 * size,
                        src: identityIconUrl),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  Widget textContent(String mTextContent, BuildContext context, bool isDetail) {
    if (!isDetail) {
      //如果字数过长
      if (mTextContent.length > 150) {
        mTextContent = '${mTextContent.substring(0, 148)} ... 展开';
      }
    }
    mTextContent = mTextContent.replaceAll("\\n", "\n");
    return Container(
        alignment: FractionalOffset.centerLeft,
        padding: const EdgeInsets.only(top: 6),
        child: ParsedText(
          text: mTextContent,
          style: const TextStyle(
              color: AppThemes.body1_txt_color,
              height: 1.6,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          parse: <MatchText>[
            MatchText(
                pattern: r"\[(@[^:]+):([^\]]+)\]",
                style: const TextStyle(
                    color: Color(0xff5B778D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                renderText: ({String str = '', String pattern = ''}) {
                  Map<String, String?> map = <String, String>{};
                  RegExp customRegExp = RegExp(pattern);
                  RegExpMatch? match = customRegExp.firstMatch(str);
                  map['display'] = match?.group(1);
                  map['value'] = match?.group(2);
                  return map;
                },
                onTap: (content, contentId) {}),
            MatchText(
                pattern: '#.*?#',
                //       pattern: r"\B#+([\w]+)\B#",
                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                style: const TextStyle(
                    color: Color(0xff5B778D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                renderText: ({String str = '', String pattern = ''}) {
                  Map<String, String> map = <String, String>{};

                  String idStr =
                      str.substring(str.indexOf(":") + 1, str.lastIndexOf("#"));
                  String showStr = str
                      .substring(str.indexOf("#"), str.lastIndexOf("#") + 1)
                      .replaceAll(":$idStr", "");
                  map['display'] = showStr;
                  map['value'] = idStr;
                  //   print("正则:"+str+"---"+idStr+"--"+startIndex.toString()+"--"+str.lastIndexOf("#").toString());

                  return map;
                },
                onTap: (String content, String contentId) async {}),
            MatchText(
              pattern: '(\\[/).*?(\\])',
              //       pattern: r"\B#+([\w]+)\B#",
              //   pattern: r"\[(#[^:]+):([^#]+)\]",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              renderText: ({String? str, String? pattern}) {
                Map<String, String> map = <String, String>{};
                String mEmoji2 = "";
                try {
                  String mEmoji =
                      str?.replaceAll(RegExp('(\\[/)|(\\])'), "") ?? "";
                  int mEmojiNew = int.parse(mEmoji);
                  mEmoji2 = String.fromCharCode(mEmojiNew);
                } on Exception catch (_) {
                  mEmoji2 = "";
                }
                map['display'] = mEmoji2;

                return map;
              },
            ),
            MatchText(
                pattern: '展开',
                //       pattern: r"\B#+([\w]+)\B#",
                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                style: const TextStyle(
                    color: Color(0xff5B778D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                renderText: ({String? str, String? pattern}) {
                  Map<String, String> map = <String, String>{};
                  map['display'] = '展开';
                  map['value'] = '展开';
                  return map;
                },
                onTap: (display, value) async {}),
          ],
        ));
  }

  //九宫格Widget
  Widget _buildNineGuard(List<String> picUrlList) {
    double width = Adapt.screenW() - 40 - 48 - 12;
    int len = picUrlList.length;
    double imageEdge = 2;
    if (len == 0) {
      return const SizedBox.shrink();
    } else if (len == 1) {
      double imageW = 160;
      double imageH = 160 / (3 / 4.0);
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(RouterPath.PreView_Page, arguments: {
              "picUrlList": picUrlList,
              "defaultIndex": 0,
            });
          },
          child: NetworkImgLayer(
              width: imageW,
              height: imageH,
              src: picUrlList.first,
              imageBuilder: (context, provider) {
                return Hero(
                  tag: picUrlList.first,
                  child: Image(
                    image: provider,
                    fit: BoxFit.cover,
                  ),
                );
              }),
        ),
      );
    } else if (len == 2) {
      double imageW = (width - imageEdge) / 2.0;
      double imageH = imageW;
      return Container(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouterPath.PreView_Page, arguments: {
                    "picUrlList": picUrlList,
                    "defaultIndex": 0,
                  });
                },
                child: NetworkImgLayer(
                    width: imageW,
                    height: imageH,
                    src: picUrlList.first,
                    imageBuilder: (context, provider) {
                      return Hero(
                        tag: picUrlList.first,
                        child: Image(
                          image: provider,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
              ),
              const SizedBox(width: 2),
              GestureDetector(
                onTap: () => Get.toNamed(RouterPath.PreView_Page, arguments: {
                  "picUrlList": picUrlList,
                  "defaultIndex": 1,
                }),
                child: NetworkImgLayer(
                    width: imageW,
                    height: imageH,
                    src: picUrlList[1],
                    imageBuilder: (context, provider) {
                      return Hero(
                        tag: picUrlList[1],
                        child: Image(
                          image: provider,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      );
    } else {
      //算出一共有几行
      int rowlength = 0;
      //一共有几列
      int conlength = 0;
      double itemW = 0;
      double itemH = 0;
      if (len == 3 || len == 6 || len == 9 || len == 4) {
        if (len == 3) {
          rowlength = 1;
          conlength = 3;
        } else if (len == 6) {
          rowlength = 2;
          conlength = 3;
        } else if (len == 9) {
          rowlength = 3;
          conlength = 3;
        } else {
          rowlength = 2;
          conlength = 2;
        }
        itemW = (width - imageEdge * 2) / 3.0;
        itemH = itemW;
        List<Widget> rowswidget = [];
        List<Widget> colums = [];
        for (int row = 0; row < rowlength; row++) {
          List<Widget> rowArr = [];
          for (var col = 0; col < conlength; col++) {
            int index = row * conlength + col;
            rowArr.add(Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterPath.PreView_Page, arguments: {
                      "picUrlList": picUrlList,
                      "defaultIndex": index,
                    });
                  },
                  child: NetworkImgLayer(
                      width: itemW,
                      height: itemH,
                      src: picUrlList[index],
                      imageBuilder: (context, provider) {
                        return Hero(
                          tag: picUrlList[index],
                          child: Image(
                            image: provider,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
                SizedBox(
                  width: col == conlength - 1 ? 0 : imageEdge,
                )
              ],
            ));
          }
          rowswidget.add(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: rowArr,
          ));
        }
        for (var i = 0; i < rowswidget.length; i++) {
          colums.add(Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              rowswidget[i],
              SizedBox(height: imageEdge),
            ],
          ));
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: colums,
          ),
        );
      } else {
        rowlength = 2;
        List<Widget> rowswidget = [];
        List<Widget> colums = [];

        for (var row = 0; row < rowlength; row++) {
          if (len == 5) {
            if (row == 0) {
              itemW = (width - imageEdge) / 2.0;
              itemH = itemW;
              conlength = 2;
            } else {
              itemW = (width - imageEdge * 2) / 3.0;
              itemH = itemW;
              conlength = 3;
            }
          } else if (len == 7) {
            if (row == 0) {
              itemW = (width - imageEdge * 2) / 3.0;
              itemH = itemW;
              conlength = 3;
            } else {
              itemW = (width - imageEdge * 3) / 4.0;
              itemH = itemW;
              conlength = 4;
            }
          }
          List<Widget> rowArr = [];
          for (var col = 0; col < conlength; col++) {
            int index =
                row == 0 ? row * conlength + col : row * (conlength - 1) + col;
            rowArr.add(Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterPath.PreView_Page, arguments: {
                      "picUrlList": picUrlList,
                      "defaultIndex": index,
                    });
                  },
                  child: NetworkImgLayer(
                      width: itemW,
                      height: itemH,
                      src: picUrlList[index],
                      imageBuilder: (context, provider) {
                        return Hero(
                          tag: picUrlList[index],
                          child: Image(
                            image: provider,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
                SizedBox(
                  width: col == conlength - 1 ? 0 : imageEdge,
                )
              ],
            ));
          }
          rowswidget.add(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: rowArr,
          ));
        }

        for (var i = 0; i < rowswidget.length; i++) {
          colums.add(Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              rowswidget[i],
              SizedBox(height: imageEdge),
            ],
          ));
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: colums,
          ),
        );
      }
    }
  }

  Widget _creatMenuPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItem('cm8_mlog_playlist_share', "分享", false, () {}),
        _buildItem(
            'cm8_mlog_playlist_comment',
            widget.model.commentNum! > 0 ? "${widget.model.commentNum!}" : "评论",
            false,
            () {}),
        _buildItem(
            widget.model.zanStatus == 0
                ? 'voice_play_releated_song_like'
                : 'voice_play_releated_song_liked',
            widget.model.likeNum! > 0 ? "${widget.model.likeNum!}" : '收藏',
            widget.model.zanStatus == 0 ? false : true, () {
          onLikeDynamic();
        }),
        GestureDetector(
          onTap: () {},
          child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                ImageUtils.getImagePath('cb'),
                width: Dimens.gap_dp18,
                height: Dimens.gap_dp18,
                color: AppThemes.color_150,
              )),
        ),
      ],
    );
  }

  Widget _buildItem(String iconName, String name, bool canClicked,
      ParamVoidCallback callBack) {
    final fColor = Get.isDarkMode ? AppThemes.color_109 : AppThemes.color_128;

    return GestureDetector(
      onTap: callBack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageUtils.getImagePath(iconName),
            width: Dimens.gap_dp18,
            height: Dimens.gap_dp18,
            colorBlendMode: BlendMode.srcIn,
            color: canClicked ? Colors.red : fColor,
          ),
          SizedBox(width: Dimens.gap_dp2),
          Text(
            name,
            style: TextStyle(
                color: canClicked ? fColor : fColor,
                fontSize: Dimens.font_sp11,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

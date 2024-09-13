import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/element_button_widget.dart';
import 'package:yun_music/commons/widgets/general_album_item.dart';
import 'package:yun_music/commons/widgets/general_song_one.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/recommend/models/creative_model.dart';
import 'package:yun_music/pages/recommend/models/recom_new_song.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';
import '../../../commons/res/routes_utils.dart';

class RecomSongAlbum extends StatefulWidget {
  const RecomSongAlbum(
      {super.key,
      required this.creatives,
      required this.itemHeight,
      required this.bottomRadius});

  final List<CreativeModel> creatives;

  final double itemHeight;

  final bool bottomRadius;

  @override
  State<RecomSongAlbum> createState() => _RecomSongAlbumState();
}

class _RecomSongAlbumState extends State<RecomSongAlbum>
    with AutomaticKeepAliveClientMixin {
  final List<String> types = List.empty(growable: true);

  final List<Widget> tabs = List.empty(growable: true);

  //当前选中的tab
  final curSelectedIndex = 0.obs;

  void initData() {
    final theme = Get.theme;
    if (types.isNotEmpty) types.clear();
    if (tabs.isNotEmpty) tabs.clear();
    for (final element in widget.creatives) {
      if (!types.contains(element.creativeType)) {
        types.add(element.creativeType!);
      }
    }
    for (var i = 0; i < types.length; i++) {
      final creative = widget.creatives
          .firstWhere((e) => e.creativeType == types.elementAt(i));
      tabs.add(Row(
        key: Key("tab_$i"),
        children: [
          if (tabs.isNotEmpty)
            Container(
              width: Dimens.gap_dp1,
              height: Dimens.gap_dp16,
              margin:
                  EdgeInsets.only(left: Dimens.gap_dp8, right: Dimens.gap_dp8),
              color: theme.dividerColor,
            ),
          GestureDetector(
            child: Obx(
              () => Text(
                creative.uiElement!.mainTitle!.title.toString(),
                style: curSelectedIndex.value == i
                    ? headlineStyle()
                    : headlineStyle().copyWith(
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.6)
                            : const Color.fromARGB(200, 135, 135, 135)),
              ),
            ),
            onTap: () {
              curSelectedIndex.value = i;
            },
          )
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    initData();
    return Container(
      height: widget.itemHeight,
      decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.gap_dp10),
              topRight: Radius.circular(Dimens.gap_dp10),
              bottomLeft:
                  Radius.circular(widget.bottomRadius ? Dimens.gap_dp10 : 0),
              bottomRight:
                  Radius.circular(widget.bottomRadius ? Dimens.gap_dp10 : 0))),
      child: Column(
        children: [
          //tab
          _buildTabLayout(),
          //page
          Expanded(
            child: Obx(() => _buildPage(widget.creatives.where((element) =>
                element.creativeType ==
                types.elementAt(curSelectedIndex.value)))),
          )
        ],
      ),
    );
  }

  Widget _buildTabLayout() {
    final elementButton = widget.creatives.firstWhere((element) =>
        element.creativeType == types.elementAt(curSelectedIndex.value));
    return Container(
      height: Dimens.gap_dp48,
      padding: EdgeInsets.only(
          left: Dimens.gap_dp15, right: Dimens.gap_dp15, top: Dimens.gap_dp5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Row(
              children: tabs,
            ),
          ),
          Positioned(
            right: 0,
            child: Obx(() => elementButtonWidget(
                    widget.creatives
                        .firstWhere((element) =>
                            element.creativeType ==
                            types.elementAt(curSelectedIndex.value))
                        .uiElement
                        ?.button, onPressed: () {
                  RoutesUtils.routeFromActionStr(
                      elementButton.uiElement?.button?.action);
                })),
          )
        ],
      ),
    );
  }

  Widget _buildPage(Iterable<CreativeModel> datas) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.91),
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: _buildPageItems(datas.elementAt(index).resources!),
          ),
        );
      },
      itemCount: datas.length,
    );
  }

  List<Widget> _buildPageItems(List<Resources> resources) {
    if (GetUtils.isNull(resources)) return List.empty();
    final List<Widget> widgets = List.empty(growable: true);
    for (final element in resources) {
      var childView = Dimens.empty;
      switch (element.resourceType) {
        case 'song': //新歌
          final song = RecomNewSong.fromJson(element.resourceExtInfo)
              .buildSong(element.action);
          childView = GeneralSongOne(
            songInfo: song,
            uiElementModel: element.uiElement,
            onPressed: () {},
          );
          break;
        case 'album': //新碟
        case 'digitalAlbum': //数字专辑
          final list = element.resourceExtInfo['artists'] as List;
          childView = GeneralAlbumItem(
              artists: list.map((e) => Ar.fromJson(e)).toList(),
              uiElementModel: element.uiElement,
              action: element.action!);
          break;
        case 'voice':
          //热门博客
          childView = _buildVoice(element);
          break;
        case 'voiceList':
          //有声书
          childView = _buildVoice(element, isVoice: false);
          break;
      }
      widgets.add(Container(
        padding: EdgeInsets.only(right: Dimens.gap_dp15),
        child: Column(
          children: [
            // if (widgets.isNotEmpty)
            //   Container(
            //     margin: EdgeInsets.only(left: Adapt.px(58)),
            //     child: Divider(height: Dimens.gap_dp1),
            //   ),
            SizedBox(
              height: Adapt.px(58),
              child: childView,
            )
          ],
        ),
      ));
    }
    return widgets;
  }

//热门博客
  Widget _buildVoice(Resources resources, {bool isVoice = true}) {
    final uiElement = resources.uiElement;
    return BounceTouch(
        onPressed: () {},
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.gap_dp10),
              child: NetworkImgLayer(
                width: Dimens.gap_dp50,
                height: Dimens.gap_dp50,
                src: uiElement.image?.imageUrl ?? '',
                imageBuilder: (context, provider) {
                  return Stack(
                    children: [
                      Positioned.fill(
                          child: Image(
                        image: provider,
                        fit: BoxFit.cover,
                      )),
                      if (isVoice)
                        Positioned(
                          right: Dimens.gap_dp2,
                          bottom: Dimens.gap_dp2,
                          child: Image.asset(
                            ImageUtils.getImagePath('icon_play_small'),
                            width: Dimens.gap_dp20,
                            height: Dimens.gap_dp20,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
            SizedBox(width: Dimens.gap_dp10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    uiElement.mainTitle?.title ?? '',
                    style: headline1Style(),
                  ),
                  SizedBox(height: Dimens.gap_dp4),
                  Row(
                    children: [
                      Container(
                        height: 16,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 3),
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        decoration: BoxDecoration(
                          color: uiElement.labelType?.toLowerCase() == 'yellow'
                              ? Colors.orange.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(3),
                          border: uiElement.labelType?.toLowerCase() != 'yellow'
                              ? Border.all(
                                  width: Dimens.gap_dp1,
                                  color: captionStyle().color!.withOpacity(0.2))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            uiElement.labelTexts?.join('/') ?? '',
                            style: TextStyle(
                              fontSize: Dimens.font_sp10,
                              color:
                                  uiElement.labelType?.toLowerCase() == 'yellow'
                                      ? Colors.orange
                                      : captionStyle().color!.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        uiElement.subTitle?.title ?? '',
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: captionStyle(),
                      ))
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

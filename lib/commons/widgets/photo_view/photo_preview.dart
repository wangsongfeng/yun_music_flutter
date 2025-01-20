import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/widgets/photo_view/photo_controller.dart';

import '../../../utils/approute_observer.dart';
import '../../event/play_bar_event.dart';

class PhotoPreview extends StatefulWidget {
  const PhotoPreview({super.key});

  @override
  State<PhotoPreview> createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> with RouteAware {
  final controller = GetInstance().putOrFind(() => PhotoController());

  final ScrollController _extendNestCtr = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
    _extendNestCtr.dispose();
  }

  @override
  void didPopNext() {
    //上一个页面pop回到当前页面 viewWillappear
    super.didPopNext();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
  }

  List<String>? picUrlList;
  int? defaultIndex;

  @override
  void initState() {
    super.initState();

    picUrlList = Get.arguments['picUrlList'];
    defaultIndex = Get.arguments['defaultIndex'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            color: Colors.transparent,
            child: PhotoViewGallery.builder(
              itemCount: picUrlList!.length,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(picUrlList![index]),
                  initialScale: PhotoViewComputedScale.contained * 0.98,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: picUrlList![index]),
                  onTapUp: (context, details, controllerValue) {
                    Get.back();
                  },
                );
              },
              pageController: PageController(initialPage: defaultIndex!),
              scrollDirection: Axis.horizontal,
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!.toDouble(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

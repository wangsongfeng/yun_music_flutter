import 'package:get/get.dart';
import 'package:yun_music/pages/playlist_collection/playlist_collection_controller.dart';

class PlaylistCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaylistCollectionController>(
        () => PlaylistCollectionController());
  }
}

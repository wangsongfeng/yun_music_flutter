import 'package:get/get.dart';
import 'package:yun_music/pages/day_song_recom/controller.dart';

class RcmdSongDayBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaySongRecmController>(() => DaySongRecmController());
  }
}

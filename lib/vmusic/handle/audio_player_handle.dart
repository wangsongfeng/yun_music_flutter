import 'package:audio_service/audio_service.dart';

abstract class AudioPlayerHandle implements AudioHandler {
  // 更改播放列表
  Future<void> changeQueueLists(List<MediaItem> list);

  // 从下表播放
  Future<void> playIndex(int index);

  // 设置songurl
  Future<void> readySongUrl();

  // 添加fmitems
  Future<void> addFmItems(List<MediaItem> mediaItems, bool isAddcurIndex);
}

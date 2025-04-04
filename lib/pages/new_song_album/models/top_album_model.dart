import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import 'top_album_cover_info.dart';

class TopAlbumModel implements ExpandableListSection<TopAlbumCoverInfo> {
  final String? label;
  final DateTime? dateTime;
  final List<TopAlbumCoverInfo> data;

  const TopAlbumModel({this.label, this.dateTime, required this.data});

  @override
  List<TopAlbumCoverInfo> getItems() {
    return data;
  }

  @override
  bool isSectionExpanded() {
    return true;
  }

  @override
  void setSectionExpanded(bool expanded) {}
}

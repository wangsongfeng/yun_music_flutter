
import 'package:flutter/material.dart';

class GeneralSliverDelegate extends SliverPersistentHeaderDelegate {
  PreferredSizeWidget child;
  GeneralSliverDelegate({required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

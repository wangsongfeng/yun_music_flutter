import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/player/player_service.dart';
import 'package:yun_music/utils/adapt.dart';

class MusicPlaybarOverlay {
  OverlayEntry? _overlayEntry;
  MusicPlaybarOverlay._();

  static final MusicPlaybarOverlay instance = MusicPlaybarOverlay._();
  factory MusicPlaybarOverlay() => instance;

  void show(BuildContext context, Widget child) {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: (context) {
        return Obx(() {
          return AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: PlayerService.to.plarBarBottom.value,
              duration: const Duration(milliseconds: 200),
              child: Material(
                color: Colors.transparent,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: PlayerService.to.playBarHeight.value,
                  child: child,
                ),
              ));
        });
      });
      Overlay.of(context).insert(_overlayEntry!);

      _overlayEntry?.markNeedsBuild();
    }
  }

  void hide() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}

class CustomDialogShow {
  OverlayEntry? _overlayEntry;
  CustomDialogShow._();

  static final CustomDialogShow instance = CustomDialogShow._();
  factory CustomDialogShow() => instance;

  void show(
      {required BuildContext context,
      Color bgColor = Colors.transparent,
      required Widget child}) {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: (context) {
        return Container(
          color: bgColor,
          width: Adapt.screenW(),
          height: Adapt.screenH(),
          child: child,
        );
      });
      Overlay.of(context).insert(_overlayEntry!);

      _overlayEntry?.markNeedsBuild();
    }
  }

  void hide() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}

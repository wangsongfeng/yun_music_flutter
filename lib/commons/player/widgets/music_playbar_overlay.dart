import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/player/player_service.dart';

class MusicPlaybarOverlay {
  OverlayEntry? _overlayEntry;
  MusicPlaybarOverlay._();

  static final MusicPlaybarOverlay instance = MusicPlaybarOverlay._();
  factory MusicPlaybarOverlay() => instance;

  void show(BuildContext _context, Widget _child) {
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
                  child: _child,
                ),
              ));
        });
      });
      Overlay.of(_context).insert(_overlayEntry!);

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

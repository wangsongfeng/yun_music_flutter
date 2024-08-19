import 'package:flutter/material.dart';
import 'package:yun_music/commons/player/player_service.dart';
import 'package:yun_music/commons/values/server.dart';

extension QuitPlayerExt on BuildContext {
  PlayerService get playerService {
    try {
      return PlayerService.to;
    } catch (e, stacktrace) {
      logger.e(stacktrace.toString());
      rethrow;
    }
  }
}

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// const SERVER_API_URL = 'https://netease-cloud-music-api-masterxing.vercel.app';
const SERVER_API_URL = 'https://neteasecloudmusicapi-one-tan.vercel.app';
const NEW_SERVER_URL = "https://music.163.com";

const HOSTS = [
  'music.163.com',
  'interface.music.163.com',
  'interface3.music.163.com'
];

const CACHE_NET_IMAGE_HEADER = {
  "User-Agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.76"
};
final logger = Logger(
  printer: PrettyPrinter(lineLength: 20),
  output: DebugPrintConsoleOutput(),
);

class DebugPrintConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final element in event.lines) {
      debugPrint(element);
    }
  }
}

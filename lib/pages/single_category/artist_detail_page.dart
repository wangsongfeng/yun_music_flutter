import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/single_category/artist_detail_controller.dart';

class ArtistDetailPage extends StatefulWidget {
  const ArtistDetailPage({super.key});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  late ArtistDetailController? artistDetailController;

  @override
  void initState() {
    super.initState();
    artistDetailController = Get.put(ArtistDetailController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}

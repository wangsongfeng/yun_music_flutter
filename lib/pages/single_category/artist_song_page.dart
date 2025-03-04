import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';

class ArtistSongPage extends StatelessWidget {
  const ArtistSongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppThemes.app_main,
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
            height: 66,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "$index",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        itemCount: 60,
      ),
    );
  }
}

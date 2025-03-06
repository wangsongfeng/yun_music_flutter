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
      child: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemBuilder: (context, index) {
              return Container(color: Colors.blueGrey, height: 100);
            },
            itemCount: 40,
          )
        ],
      ),
    );
  }
}

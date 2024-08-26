import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/utils/image_utils.dart';

class UserAvatarPage extends StatelessWidget {
  const UserAvatarPage(
      {super.key,
      required this.avatar,
      this.size = 35,
      this.identityIconUrl,
      this.holderAsset});

  final String avatar;
  final double size;
  final String? identityIconUrl;
  final String? holderAsset;

  @override
  Widget build(BuildContext context) {
    final sizeL = Size(size, size);
    return NetworkImgLayer(
      width: size * 1.1,
      height: size,
      src: ImageUtils.getImageUrlFromSize(avatar, sizeL),
      customplaceholder: holderAsset != null
          ? ClipOval(
              child: Image.asset(
                holderAsset!,
                fit: BoxFit.cover,
                width: size,
                height: size,
              ),
            )
          : place,
      imageBuilder: (context, imageProvider) {
        return SizedBox(
          width: size * 1.1,
          height: size,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipOval(
                child: Image(
                  image: imageProvider,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
              ),
              if (identityIconUrl != null)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ClipOval(
                    child: NetworkImgLayer(
                        width: 0.4 * size,
                        height: 0.4 * size,
                        src: identityIconUrl!),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  Widget get place => ClipOval(
        child: Container(
          width: size,
          height: size,
          color: AppThemes.color_245,
          child: Image.asset(
            ImageUtils.getImagePath('icon_avatar_nor'),
            color: AppThemes.color_204,
          ),
        ),
      );
}

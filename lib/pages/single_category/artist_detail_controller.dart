import 'package:get/get.dart';
import 'package:yun_music/api/artist_api.dart';

class ArtistDetailController extends GetxController {
  late String? artistid;

  @override
  void onReady() {
    super.onReady();

    artistid = Get.arguments["artist_id"].toString();
    print(artistid);
    requestDataDetail();
  }

  //
  Future requestDataDetail() async {
    await ArtistApi.requestArtistDetail(artistId: artistid!);
    await ArtistApi.artistDesc(artistid!);
  }
}

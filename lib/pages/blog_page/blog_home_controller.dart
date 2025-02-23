import 'package:get/get.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/pages/blog_page/models/blog_home_model.dart';

class BlogHomeController extends SuperController<BlogHomeModel?> {
  //recommend data
  late final recomData = Rx<BlogHomeModel?>(null);

  @override
  void onReady() {
    super.onReady();

    _requestData();
  }

  void loadRefresh() {
    _requestData();
  }

  //请求数据
  Future<void> _requestData() async {
    MusicApi.getBlogHomeData().then((value) {
      return value;
    }).then((value) {
      //获取banner
      MusicApi.getBlogBannerData().then((banner) {
        if (banner != null) {
          value?.banner = banner;
        }
        return value;
      }).then((value) {
        //获取个人喜欢的数据
        MusicApi.getBlogPersonData().then((person) {
          if (person != null) {
            value?.personal = person;
          }
          recomData.value = value;
          if (recomData.value == null) {
            change(state, status: RxStatus.error());
          } else {
            change(recomData.value, status: RxStatus.success());
          }
        }, onError: (err) {
          if (recomData.value == null) {
            change(state, status: RxStatus.error());
          } else {
            change(recomData.value, status: RxStatus.success());
          }
        });
      }, onError: (err) {
        if (recomData.value == null) {
          change(state, status: RxStatus.error());
        } else {
          change(recomData.value, status: RxStatus.success());
        }
      });
    }, onError: (err) {
      if (recomData.value == null) {
        change(state, status: RxStatus.error());
      } else {
        change(recomData.value, status: RxStatus.success());
      }
    });
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}

import 'package:get/get.dart';
import '../commons/event/index.dart';
import '../commons/event/login_event.dart';
import '../commons/models/login_response.dart';
import '../commons/values/constants.dart';
import '../commons/values/server.dart';
import '../utils/common_utils.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final isLoggedIn = false.obs;

  bool get isLoggedInValue => isLoggedIn.value;

  String? cookie =
      'MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/neapi/feedback;;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/wapi/feedback;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/api/feedback;;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/api/clientlog;;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/weapi/clientlog;;__csrf=b23f469cec467a9e31b54d78fa04368b; Max-Age=1296010; Expires=Tue, 13 Aug 2024 08:43:17 GMT; Path=/;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/eapi/feedback;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/wapi/feedback;;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/weapi/feedback;;MUSIC_A=005C0A18B861C913581F7387DF64D4E03F70F85D605FBBF7EBA234BA9CF518021A02D8889CF9F4175B93CD5E26D0EA848AD6570B2434EDA04208DB050AF27AAA9B04908BE8C057D7BCF42934EFD6049D7DE523D6B1351DE08E0AF9D5D99E986C28683DB526A189EF36C071EFF6BC95F0EB272CD8122597B5C6E0D8AF6A381209B99DDE6E761CD26BF68016ACBB6A26A857857B41F8D5E21E1026308C79DD5E0BFE011902138FF54D4DF0214E079598B56DAE02801E1245E28E672C14DC1164EE83A769F75F5292C3341694466581C42D0B8528988819E17A2A6F2E7C7F0EBAAF859DE6AF35AC2C43F96978958A5DF12DD4EBA5114D404A0EACE7E8037CE355A4067FF19A88235090DB77773B505B9449A8CBD357F272EC9A080762DA3A2DB1DC7E04CABC1E889A739E7B7FD7C216043886C91F5DCDF7D2566E3BAAA272EC6194D2EC0852D780B733B76FCBF37512CB4E37DA0C0B92349D738079B7FA7683D28215; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/;;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/neapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/openapi/clientlog;;MUSIC_SNS=; Max-Age=0; Expires=Mon, 29 Jul 2024 08:43:07 GMT; Path=/;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/eapi/feedback;;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/openapi/clientlog;;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/eapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/wapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/weapi/clientlog;;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/wapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/neapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/eapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/neapi/feedback;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/api/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/weapi/feedback;;MUSIC_A_T=1720544557582; Max-Age=2147483647; Expires=Sat, 16 Aug 2092 11:57:14 GMT; Path=/api/feedback;';
  // String? cookie;
  int? userId = 12158006801;

  final loginData = Rx<LoginResponse?>(null);

  @override
  void onInit() {
    super.onInit();

    final loginCache = box.read<Map<String, dynamic>>(CACHE_LOGIN_DATA);
    if (loginCache != null) {
      logger.d('有登陆信息');
      login(LoginResponse.fromJson(loginCache));
    }
  }

  //登陆处理逻辑
  void login(LoginResponse loginResponse) {
    refreshCookie(loginResponse.cookie);
    userId = loginResponse.profile?.userId ?? loginResponse.account.id;
    loginData.value = loginResponse;
    box.write(CACHE_LOGIN_DATA, loginResponse.toJson());
    isLoggedIn.value = true;
    eventBus.fire(LoginEvent(true));
  }

  /*退出登陆成功后 清除本地缓存*/
  Future<void> logout() async {
    loginData.value = null;
    cookie = null;
    await box.remove(CACHE_LOGIN_DATA);
    isLoggedIn.value = false;
    eventBus.fire(LoginEvent(false));
  }

  void refreshCookie(String s) {
    cookie = Uri.encodeComponent(s);
    logger.i(cookie);
  }
}

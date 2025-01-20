import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:encrypt/encrypt.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yun_music/commons/net/init_dio.dart';
import 'package:yun_music/commons/values/platform_utils.dart';
import 'package:yun_music/services/auth_service.dart';

import 'package:encrypt/encrypt.dart' as EncryptLib;

import '../../api/bujuan_api.dart';
import '../values/server.dart';
import 'encrypt_ext.dart';
import 'package:pointycastle/export.dart' hide Algorithm;

class CookieInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.method == 'POST' &&
        HOSTS.contains(options.uri.host) &&
        options.extra['hookRequestData']) {
      options.contentType = Headers.formUrlEncodedContentType;
      options.headers[HttpHeaders.refererHeader] = NEW_SERVER_URL;
      var realIP = options.extra['realIP'];
      options.headers[HttpHeaders.userAgentHeader] =
          _chooseUserAgent(options.extra['userAgent']);
      if (realIP != null) {
        options.headers['X-Real-IP'] = realIP;
      }

      var cookies = await loadCookies(host: options.uri);
      var cookiesSb = StringBuffer(CookieManager.getCookies(cookies));
      options.extra['cookies'].forEach((key, value) {
        cookiesSb.write(
            ' ;${Uri.encodeComponent(key)}=${Uri.encodeComponent(value)}');
      });
      options.headers[HttpHeaders.cookieHeader] = cookiesSb.toString();
      options.extra['cookiesHash'] =
          await loadCookiesHash(cookies: cookies) + 0;

      if (!(options.extra['hookRequestDataSuccess'] ?? false)) {
        switch (options.extra['encryptType']) {
          case EncryptType.LinuxForward:
            _handleLinuxForward(options);
            break;
          case EncryptType.WeApi:
            _handleWeApi(options);
            break;
          case EncryptType.EApi:
            _handleEApi(options, cookies);
            break;
        }
        options.extra['hookRequestDataSuccess'] = true;
      }
    } else {
      if (AuthService.to.isLoggedInValue && AuthService.to.cookie != null) {
        options.queryParameters['cookie'] = AuthService.to.cookie;
      }
      options.queryParameters['realIp'] = '182.61.200.7';
    }

    super.onRequest(options, handler);
  }
}

Future<List<Cookie>> loadCookies({Uri? host}) async {
  host ??= Uri.parse(NEW_SERVER_URL);
  return (HttpManager.cookieManager.cookieJar).loadForRequest(host);
}

Future<int> loadCookiesHash({List<Cookie>? cookies}) async {
  cookies ??= await loadCookies();
  // int hash = hashList(cookies.map((e) => e.toString()));
  int hash = 0;
  int loginRefreshVersion = 0;
  return hash + loginRefreshVersion;
}

String _chooseUserAgent(UserAgent agent) {
  var random = Random();
  switch (agent) {
    case UserAgent.Random:
      return userAgentList[random.nextInt(userAgentList.length)];
    case UserAgent.Pc:
      return userAgentList[random.nextInt(5) + 8];
    case UserAgent.Mobile:
      return userAgentList[random.nextInt(7)];
  }
}

void _handleEApi(RequestOptions option, List<Cookie> cookies) {
  var oldUriStr = option.uri.toString();
  option.path = oldUriStr.replaceAll(RegExp(r'\w*api'), 'eapi');

  var header = {};
  Map<String, String> cookiesMap =
      cookies.fold(<String, String>{}, (map, element) {
    map[element.name] = element.value;
    return map;
  });
  header['osver'] = cookiesMap['osver'];
  header['deviceId'] = cookiesMap['deviceId'];
  header['appver'] = cookiesMap['appver'] ?? '8.0.00';
  header['versioncode'] = cookiesMap['versioncode'] ?? '140';
  header['mobilename'] = cookiesMap['mobilename'];
  header['buildver'] =
      cookiesMap['mobilename'] ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
  header['resolution'] = cookiesMap['resolution'] ?? '1920x1080';
  header['os'] = cookiesMap['os'] ?? 'android';
  header['channel'] = cookiesMap['channel'];
  header['__csrf'] = cookiesMap['__csrf'] ?? '';
  if (cookiesMap['MUSIC_U'] != null) {
    header['MUSIC_U'] = cookiesMap['MUSIC_U'];
  }
  if (cookiesMap['MUSIC_A'] != null) {
    header['MUSIC_A'] = cookiesMap['MUSIC_A'];
  }
  header['requestId'] =
      '${DateTime.now().millisecondsSinceEpoch}${Random().nextInt(1000).toString().padLeft(4, '0')}';

  // map可能是<String,Int>类型的，默认转换成<String,dynamic>
  option.data = Map.from(option.data);
  option.data['header'] = header;

  var url = option.extra['eApiUrl'];
  var body = jsonEncode(option.data);
  var message = 'nobody${url}use${body}md5forencrypt';
  var digest =
      Encrypted(MD5Digest().process(Uint8List.fromList(utf8.encode(message))))
          .base16;
  var data = '$url-36cd479b6b5-$body-36cd479b6b5-$digest';

  final encrypted = Encrypter(AES(Key.fromUtf8(_KeyEApi), mode: AESMode.ecb))
      .encrypt(data, iv: IV.fromLength(0))
      .base16
      .toUpperCase();

  option.data = 'params=${Uri.encodeComponent(encrypted)}';
}

void _handleWeApi(RequestOptions option) {
  var oldUriStr = option.uri.toString();
  option.path = oldUriStr.replaceAll(RegExp(r'\w*api'), 'weapi');

  //weApi方式请求body里面需要带上csrfToken字段，这个是登录请求set-cookie返回的
  String csrfToken = '';
  try {
    csrfToken = RegExp(r'_csrf=([^(;|$)]+)')
            .firstMatch(option.headers[HttpHeaders.cookieHeader] ?? '')
            ?.group(1) ??
        '';
  } catch (e) {}
  if (csrfToken.isNotEmpty) {
    // map可能是<String,Int>类型的，默认转换成<String,dynamic>
    option.data = Map.from(option.data);
    option.data['csrf_token'] = csrfToken;
  }

  String body = jsonEncode(option.data);

  //1. 固定密钥加密原始数据
  final key = EncryptLib.Key.fromUtf8(_presetKeyWeApi);
  final iv = EncryptLib.IV.fromUtf8(_ivWeApi);
  final encrypter =
      EncryptLib.Encrypter(EncryptLib.AES(key, mode: EncryptLib.AESMode.cbc));
  final encrypted = encrypter.encrypt(body, iv: iv);

  //2. 生成一个16位密钥A
  Uint8List randomKeyBytes = Uint8List.fromList(List.generate(16, (int index) {
    return _BASE62.codeUnitAt(Random().nextInt(62));
  }));

  //3. 用密钥A再次加密步骤1的结果
  final key2 = EncryptLib.Key(randomKeyBytes);
  final encrypterBody =
      EncryptLib.Encrypter(EncryptLib.AES(key2, mode: EncryptLib.AESMode.cbc));
  final encryptedBody = encrypterBody.encrypt(encrypted.base64, iv: iv);

  //4. RSA加密密钥A
  final parser = EncryptLib.RSAKeyParser();
  final encrypter3 = EncryptLib.Encrypter(
      RSAExt(publicKey: parser.parse(_publicKeyWeApi) as RSAPublicKey?));
  final encrypted3 =
      encrypter3.encryptBytes(List.from(randomKeyBytes.reversed));

  // 5. 组合结果
  option.data =
      'params=${Uri.encodeQueryComponent(encryptedBody.base64)}&encSecKey=${Uri.encodeQueryComponent(encrypted3.base16)}';
}

const _presetKeyWeApi = '0CoJUm6Qyw8W8jud';
const _ivWeApi = '0102030405060708';

const _KeyEApi = 'e82ckenh8dichen8';

const _publicKeyWeApi =
    '-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgtQn2JZ34ZC28NWYpAUd98iZ37BUrX/aKzmFbt7clFSs6sXqHauqKWqdtLkF2KexO40H1YTX8z2lSgBBOAxLsvaklV8k4cBFK9snQXE9/DDaFt6Rr7iVZMldczhC0JNgTz+SHXT6CBHuX3e9SdB1Ua44oncaTWz7OBGLbCiK45wIDAQAB\n-----END PUBLIC KEY-----';
const _BASE62 =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
const String _presetKeyLinuxForward = 'rFgB&h#%2?^eDg:Q';

void _handleLinuxForward(RequestOptions option) {
  var oldUriStr = option.uri.toString();

  option.path = Uri(
          scheme: option.uri.scheme,
          host: option.uri.host,
          path: 'api/linux/forward')
      .toString();

  var newData = {
    'method': option.method,
    'url': oldUriStr.replaceAll(RegExp(r'\w*api'), 'api'),
    'params': option.data
  };

  final key = EncryptLib.Key.fromUtf8(_presetKeyLinuxForward);
  final encrypter =
      EncryptLib.Encrypter(EncryptLib.AES(key, mode: EncryptLib.AESMode.ecb));
  final encrypted = encrypter.encrypt(jsonEncode(newData));

  option.data = 'eparams=${Uri.encodeQueryComponent(encrypted.base16)}';
}

class PathProvider {
  var _cookiePath = '';
  var _dataPath = '';

  init() async {
    if (PlatformUtils.isWeb) return;
    _cookiePath =
        "${(await getApplicationSupportDirectory()).absolute.path}/zmusic/.cookies/";
    _dataPath =
        "${(await getApplicationSupportDirectory()).absolute.path}/zmusic/.data/";
  }

  String getCookieSavedPath() {
    return _cookiePath;
  }

  String getDataSavedPath() {
    return _dataPath;
  }
}

import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigUtils {
  static final FirebaseRemoteConfigUtils _configUtils =
      FirebaseRemoteConfigUtils._internal();
  factory FirebaseRemoteConfigUtils() {
    return _configUtils;
  }
  FirebaseRemoteConfigUtils._internal();
  static const String openAppAdsId = 'adunitid';
  // static const String openAppAdsShowOrNot = 'ads_show_flag';
  static final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;
  static String get appOpenId => _remoteConfig.getString(openAppAdsId);
  // static bool get isOpenAdsShowOrNot =>
  //     _remoteConfig.getBool(openAppAdsShowOrNot);
  Future<void> initMethod() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 1),
            minimumFetchInterval: const Duration(seconds: 0)),
      );
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print(e);
    }
  }
}

import 'package:appp/bean/login/account_info.dart';
import 'package:flustars/flustars.dart';

class Sp {
  static final String keyExpire = "key_expire";
  static final String keyCookies = "key_cookie";
  static final String keyUserName = "key_username";
  static final String keyPassword = "key_password";
  static final String keyAccountInfo = "key_account_info";

  static void putExpire(int expire) {
    SpUtil.putInt(keyExpire, expire);
  }

  static int getExpire(int expire) {
    return SpUtil.getInt(keyExpire);
  }

  static void putCookies(String cookies) {
    SpUtil.putString(keyCookies, cookies);
  }

  static String getCookies() {
    return SpUtil.getString(keyCookies);
  }

  static void putUserName(String username) {
    SpUtil.putString(keyUserName, username);
  }

  static String getUserName() {
    return SpUtil.getString(keyUserName);
  }

  static void putPassword(String password) {
    SpUtil.putString(keyPassword, password);
  }

  static String getPassword() {
    return SpUtil.getString(keyPassword);
  }

  static putAccountInfo(AccountInfo accountInfo) {
    print('Sp.putAccountInfo ${accountInfo?.toJson()}');
    SpUtil.putObject(keyAccountInfo, accountInfo);
  }

  static AccountInfo getAccountInfo() {
    AccountInfo accountInfo;
    Map map = SpUtil.getObject(keyAccountInfo);
    if (map == null) return null;
    try {
      print('Sp.getAccountInfo SpUtil.getObject(keyAccountInfo) $map');
      accountInfo = AccountInfo.fromJson(map);
      print('Sp.getAccountInfo $accountInfo');
    } catch (e) {
      print(e);
    }
    return accountInfo;
  }
}

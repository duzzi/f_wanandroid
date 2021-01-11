import 'package:appp/bean/login/account_info.dart';
import 'package:appp/utils/sp.dart';

class AccountManager extends IAccountManager {
  static AccountManager _accountManager;

  static AccountManager getInstance() {
    if (_accountManager == null) {
      _accountManager = AccountManager();
    }

    return _accountManager;
  }

  @override
  AccountInfo getAccountInfo() {
    return Sp.getAccountInfo();
  }

  @override
  bool isLogin() {
    return getAccountInfo() != null;
  }
}

abstract class IAccountManager {
  bool isLogin();

  AccountInfo getAccountInfo();
}

import 'package:get_storage/get_storage.dart';

import '../../features/auth/data/models/auth_res.dart';

enum AppMode { testEngine, collectData }

class LocalStorageService {
  final GetStorage _getStorage = GetStorage();
  LocalStorageService();

  Future<void> removeAll() async {
    _getStorage.erase();
  }

  //save token
  String? get authToken {
    return _getStorage.read<String>(LocalDBConstant.token);
  }

  Future<void> saveAuthToken(String token) async {
    return _getStorage.write(LocalDBConstant.token, token);
  }

  Future<void> removeAuthToken() async {
    return _getStorage.remove(LocalDBConstant.token);
  }

  // users info
  Future<void> saveUserInfo(AssessorInfo user) async {
    return _getStorage.write(LocalDBConstant.user, user.toJson());
  }

  AssessorInfo? get userInfo {
    var json = _getStorage.read<Map<String, dynamic>?>(LocalDBConstant.user);
    if (json != null) {
      return AssessorInfo.fromJson(json);
    }
    return null;
  }
}

class LocalDBConstant {
  LocalDBConstant._();
  static const String token = 'token';
  static const String user = 'current-user';
  static const String mode = 'app-mode';
  static const String damageTypes = 'damage-types';
}

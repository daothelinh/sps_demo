import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sps_demo/core/services/shared_pref/shared_preferences.dart';
import 'package:sps_demo/features/auth/data/models/auth_res.dart';

import '../../../../../../core/services/local_storage_service.dart';
import '../../../../../../routes.dart';

class LoginController extends GetxController {
  final DoLogin doLogin;

  LoginController({
    required this.doLogin,
  });
  //loginpage
  final TextEditingController usernameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  var tokenLogin = ''.obs;
  late Rx<AuthRes?> loginRes;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loginRes = Rx<AuthRes?>(null);
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferenceHelper sharedPreferenceHelper = Get.find();
    var userName = await sharedPreferenceHelper.getUserName;
    // var password = await sharedPreferenceHelper.getPassword;
    if (userName != null) {
      usernameController.text = userName;
      // passwordController.text = password;
      doLoginUser(fullName: userName);
    }
  }

  void doLoginUser({required String fullName}) async {
    if (loading.value) return;

    SharedPreferenceHelper sharedPreferenceHelper = Get.find();
    try {
      loading.value = true;
      var result = await doLogin(fullName: fullName);
      await processUsecaseResult(
        result: result,
        onSuccess: (res) {
          if (res is AuthRes) {
            loginRes.value = res;
            LocalStorageService().saveUserInfo(res.assessorInfo);
            //doGetDamageTypes();
            sharedPreferenceHelper.saveUserName(fullName);

            Get.offAllNamed(Routes.home);
            Snackbar.show(type: SnackbarType.success, message: res.msg);
          }
        },
        shouldShowFailure: (p0) => true,
      );
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }
}

class DoLogin {}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sps_demo/ui/snackbar.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/shared_pref/shared_preferences.dart';
import '../../../../routes.dart';
import '../../../../ui/process_usecase_result.dart';
import '../../data/models/auth_res.dart';
import '../../domain/usecase/do_login.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // final LoginController loginController;
  // AuthController({required this.loginController});

  final PageController pageController = PageController();
  late TabController tabController;

  // @override
  // void onInit() {
  //   super.onInit();
  //   tabController = TabController(length: 2, vsync: this);
  // }

  void onTabTapped(int index) {
    pageController.jumpToPage(index);
  }

  final DoLogin doLogin;

  AuthController({
    required this.doLogin,
    Key? key,
    // loginController,
  });
  //loginpage
  // final TextEditingController usernameController = TextEditingController();
  String passwordController = "123456";
  String phoneController = "0397302290";
  var tokenLogin = ''.obs;
  late Rx<AuthRes?> loginRes;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loginRes = Rx<AuthRes?>(null);
    tabController = TabController(length: 2, vsync: this);
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferenceHelper sharedPreferenceHelper = Get.find();
    var phoneNumber = await sharedPreferenceHelper.getPhoneNumber;
    var password = await sharedPreferenceHelper.getPassword;
    if (phoneNumber != null && password != null) {
      phoneController = phoneNumber;
      passwordController = password;
      doLoginUser(phoneNumber: phoneNumber, password: password);
    }
  }

  void doLoginUser(
      {required String phoneNumber, required String password}) async {
    if (loading.value) return;

    SharedPreferenceHelper sharedPreferenceHelper = Get.find();
    try {
      loading.value = true;
      var result = await doLogin(phoneNumber: phoneNumber, password: password);
      await processUsecaseResult(
        result: result,
        onSuccess: (res) {
          if (res is AuthRes) {
            loginRes.value = res;
            LocalStorageService().saveUserInfo(res.assessorInfo);
            // doGetDamageTypes();
            sharedPreferenceHelper.saveUserName(phoneNumber);
            // sharedPreferenceHelper.savePassword(password);

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

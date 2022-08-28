import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sps_demo/ui/snackbar.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/shared_pref/shared_preferences.dart';
import '../../../../routes.dart';
import '../../../../ui/process_usecase_result.dart';
import '../../data/models/auth_res.dart';
import '../../domain/usecase/do_login.dart';
import '../widgets/login/controller/login_controller.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // final LoginController loginController;
  // AuthController({required this.loginController});

  final PageController pageController = PageController();
  // late TabController tabController;

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
    if (userName != null) {
      usernameController.text = userName;
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

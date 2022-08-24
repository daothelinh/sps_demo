import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sps_demo/features/auth/presentation/widgets/login/controller/login_controller.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final LoginController loginController;
  AuthController({required this.loginController});

  final PageController pageController = PageController();
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  void onTabTapped(int index) {
    pageController.jumpToPage(index);
  }
}

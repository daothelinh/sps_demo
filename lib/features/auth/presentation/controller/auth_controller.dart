import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
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

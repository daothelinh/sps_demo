import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum AppMode { testEngine, collectData }

class HomeController extends GetxController {
  // final DoFilterFolder doFilterFolder;

  // HomeController(this.doFilterFolder);

}

late RefreshController folderRefreshCtrl;

int pageIndex = 1;
int pageSize = 9;

var sortValue = ''.obs;
var filterLoading = ''.obs;
late Rx<AppMode> appMode;
Rx<String> appModeToString = Rx<String>('Test Engine');

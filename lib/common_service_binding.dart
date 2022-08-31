import 'package:get/get_connect/connect.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:sps_demo/core/services/local_storage_service.dart';
import 'package:sps_demo/core/services/shared_pref/shared_preferences.dart';
import 'package:sps_demo/resful/resful_module.dart';
import 'package:sps_demo/resful/resful_module_impl.dart';

class CommonServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Logger>(Logger());
    Get.put<GetConnect>(GetConnect());
    Get.lazyPut(() => SharedPreferenceHelper());
    Get.put<SharedPreferenceHelper>(SharedPreferenceHelper(), permanent: true);
    Get.put<LocalStorageService>(LocalStorageService());
    Get.put<RestfulModule>(RestfulModuleImpl());
  }
}

import 'package:get/get.dart';

import 'features/auth/domain/usecase/do_login.dart';

class UseCaseBinding extends Bindings {
  @override
  void dependencies() {
    //auth
    Get.lazyPut(() => DoLogin(Get.find()));
  }
}

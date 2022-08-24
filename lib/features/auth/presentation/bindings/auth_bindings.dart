import 'package:get/get.dart';

import '../widgets/login/controller/login_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginController(
        doLogin: Get.find(),
      ),
    );
  }
}

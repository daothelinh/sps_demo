import 'package:get/get.dart';
import 'package:sps_demo/features/auth/domain/usecase/do_login.dart';
import 'package:sps_demo/features/auth/presentation/controller/auth_controller.dart';

import '../widgets/login/controller/login_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(loginController: Get.find()));
    Get.lazyPut(
      () => LoginController(
        doLogin: Get.find(),
      ),
    );
  }
}

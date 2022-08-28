import 'package:get/get.dart';
import 'package:sps_demo/features/auth/presentation/controller/auth_controller.dart';

import '../widgets/login/controller/login_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(() => AuthController(doLogin: Get.find()));
    // Get.lazyPut(
    //   () => LoginController(
    //     doLogin: Get.find(),
    //   ),
    // );
  }
}

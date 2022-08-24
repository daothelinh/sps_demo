import 'package:get/get.dart';
import 'package:sps_demo/repository_bindings.dart';
import 'package:sps_demo/usecase_bindings.dart';

import 'features/auth/auth_page.dart';
import 'features/auth/presentation/bindings/auth_bindings.dart';
import 'features/home/home_page.dart';

class Routes {
  Routes._();

  static const String auth = '/auth';
  static const String home = '/home';
  static final routes = [
    GetPage(
      name: auth,
      page: () => const AuthPage(),
      bindings: [
        RepositoryBinding(),
        UseCaseBinding(),
        AuthBindings(),
      ],
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
  ];
}

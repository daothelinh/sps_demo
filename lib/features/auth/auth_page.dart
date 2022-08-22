import 'package:flutter/material.dart';
import 'package:sps_demo/core/values/strings.dart';
import 'package:get/get.dart';
import 'package:sps_demo/features/auth/presentation/controller/auth_controller.dart';

import 'presentation/widgets/login/login_page.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({Key? key}) : super(key: key);

  // const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      toolbarOpacity: 0.0,
      automaticallyImplyLeading: false,
      toolbarHeight: 370,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: const <Widget>[
            Image(
              image: AssetImage('assets/images/auth_background.png'),
              fit: BoxFit.fill,
            )
          ],
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            AppStrings.helloWords,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'SVN-Gilroy', fontSize: 35, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              AppStrings.appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'assets/fonts/SVN-Gilroy-Bold.ttf',
                color: Colors.white,
                fontSize: 50,
              ),
            ),
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar: appbar,
        body: const LoginPage(),
      ),
    );
  }
}

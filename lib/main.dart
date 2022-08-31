import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sps_demo/common_service_binding.dart';
import 'package:sps_demo/routes.dart';
// import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: Routes.routes,
      initialRoute: Routes.auth,
      initialBinding: CommonServiceBinding(),
    );
  }
}

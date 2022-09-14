import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sps_demo/core/values/strings.dart';
import 'package:sps_demo/features/home/home_page.dart';

class AIModeCamera extends GetView<Widget> {
  const AIModeCamera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.black,
            // leadingWidth: 0,
            toolbarHeight: 60,
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(35),
                padding: EdgeInsets.zero,
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Get.to(() => const HomePage());
                },
              ),
            ),
            title: const TabBar(
              // controller: controller.tabController,
              tabs: [
                Tab(
                  text: AppStrings.frontCam,
                ),
                Tab(
                  text: AppStrings.spaceCam,
                ),
                Tab(
                  text: AppStrings.rearCam,
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CupertinoButton(
                    borderRadius: BorderRadius.circular(35),
                    padding: EdgeInsets.zero,
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.flash_off,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {}),
              )
            ],
          ),
          // body: CameraAwesome(
          //   testMode: false,
          //   photoSize: controller.photoSize,
          //   sensor: controller.sensor,
          //   captureMode: controller.captureMode,),
        ),
      ),
    );
  }
}

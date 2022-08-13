import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
      ],
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.deepPurple[200], shape: BoxShape.circle),
          child: Image.asset('assets/images/customer_avatar.png',
              fit: BoxFit.cover),
        ),
      ),
      title: const Text(
        'Jane Hopper',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'assets/fonts/SVN-Gilroy-Bold.ttf'),
      ),
    );
    final body = Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Container(
            child: Image.asset('assets/images/insurance_launch_icon.png'),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
            label: const Text('Add New Claim'))
      ],
    );
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar: appbar,
        body: body,
      ),
    );
  }
}

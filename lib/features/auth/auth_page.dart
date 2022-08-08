import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/auth_background.png'))),
      child: const Text('welcome!'),
    );
  }
}

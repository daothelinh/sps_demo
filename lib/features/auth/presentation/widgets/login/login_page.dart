import 'package:flutter/material.dart';
import 'package:sps_demo/core/values/strings.dart';

import '../../../../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            child: Container(
              height: 56,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: 'SVN-Gilroy',
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    hintText: AppStrings.customerName,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16, left: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    AppStrings.loginButton,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SVN-Gilroy',
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../core/values/strings.dart';
import '../../../auth/presentation/controller/auth_controller.dart';

class PersonDrawer extends StatelessWidget {
  const PersonDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text('Jane Hopper'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text(
                AppStrings.logOut,
                style: TextStyle(
                  fontFamily: 'SVN-Gilroy',
                  fontSize: 18,
                ),
              ),
              onTap: () {
                logOut();
              },
            )
          ],
        ),
      ),
    );
  }
}

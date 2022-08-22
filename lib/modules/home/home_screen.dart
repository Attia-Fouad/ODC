import 'package:flutter/material.dart';
import 'package:odc/modules/authintication/auth_screen.dart';

import '../../shared/components/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(onPressed: (){signOut(context,const AuthScreen());}, child: Text('logout'))

        ],
      ),
    );
  }
}

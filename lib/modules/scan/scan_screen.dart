import 'package:flutter/material.dart';
import 'package:odc/modules/authintication/auth_screen.dart';

import '../../shared/components/constants.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  TextButton(
          child: Text(''),
        onPressed: (){
          signOut(
            context,
            const AuthScreen(),
          );
        },

      ),
    );
  }
}

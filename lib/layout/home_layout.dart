import 'package:flutter/material.dart';
import 'package:odc/modules/authintication/auth_screen.dart';
import 'package:odc/shared/components/constants.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text('Home'),
          TextButton(onPressed: (){
            signOut(context,const AuthScreen());
          }, child: const Text("LogOut")),
        ],
      ),
    );
  }
}

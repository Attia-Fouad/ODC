import 'package:flutter/material.dart';
import 'package:odc/shared/components/constants.dart';

class splach extends StatefulWidget {
  @override
  _splachState createState() => _splachState();
}

class _splachState extends State<splach> {
  @override
  void initState() {
    super.initState();
    _naviagatohome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Image(
            image: AssetImage(
              'assets/images/logo.png',
            ),
            // fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  void _naviagatohome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget!));
  }
}
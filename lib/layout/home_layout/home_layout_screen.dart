
//................
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:odc/layout/cubit/cubit.dart';
import 'package:odc/layout/cubit/states.dart';

import '../../modules/home/home_screen.dart';
import '../../modules/notification/notification_screen.dart';
import '../../modules/profile/profile_screen.dart';
import '../../modules/scan/scan_screen.dart';
import '../../modules/search/search_screen.dart';
import '../../shared/styles/icon_broken.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppCubit.get(context);
        return Scaffold(
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar:CurvedNavigationBar(
            items:  <Widget>[
              ImageIcon(
                AssetImage("assets/images/leave.png"),
                color: cubit.currentIndex==0?Colors.white:Colors.black,
              ),
              Icon(
                IconBroken.Scan,
                color: cubit.currentIndex==1?Colors.white:Colors.black,
              ),
              Icon(
                  IconBroken.Home,
                color: cubit.currentIndex==2?Colors.white:Colors.black,
              ),
              Icon(IconBroken.Notification,
                color: cubit.currentIndex==3?Colors.white:Colors.black,
              ),
              Icon(IconBroken.Profile,
                color: cubit.currentIndex==4?Colors.white:Colors.black,
              ),
            ],
            index: cubit.currentIndex,
            height: 64.0,
            color: HexColor('#faf9f7'),
            buttonBackgroundColor: HexColor('#1ABC00'),
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              cubit.changeBottom(index);
            },
            letIndexChange: (index) => true,
          ),
        );
      },
    );
  }
}

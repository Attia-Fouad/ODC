

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
          body:SafeArea(
            child: PageView(
              controller: cubit.pageController,
              onPageChanged: (index){
                cubit.changeBottom(index);
              },
              scrollDirection: Axis.horizontal,
              children:  const [
                 SearchScreen(),
                 ScanScreen(),
                 HomeScreen(),
                 NotificationScreen(),
                 ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar:CurvedNavigationBar(
            items: const <Widget>[
              ImageIcon(
                AssetImage("assets/images/leave.png"),
              ),
              Icon(
                IconBroken.Scan,
              ),
              Icon(IconBroken.Home),
              Icon(IconBroken.Notification),
              Icon(IconBroken.Profile),
            ],
            index: cubit.currentIndex,
            height: 64.0,
            color: HexColor('#faf9f7'),
            buttonBackgroundColor: HexColor('#1ABC00'),
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              cubit.pageController.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut,);
              cubit.changeBottom(index);
            },
            letIndexChange: (index) => true,
          ),
        );
      },
    );
  }
}

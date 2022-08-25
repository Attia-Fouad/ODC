import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:odc/modules/address/address_screen.dart';
import 'package:odc/modules/search/search_screen.dart';
import 'package:odc/shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/MyPostsModel.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Cart',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) =>false,
            widgetBuilder: (BuildContext context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/cart1.png',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Your cart is empty',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Sorry, the keyword you entered cannot',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: HexColor('#2121219C'),
                    fontSize: 18,
                  ),),
                  Text('be found, please check again or search with',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: HexColor('#2121219C'),
                      fontSize: 18,
                    ),),

                  Text('another keyword.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: HexColor('#2121219C'),
                    fontSize: 18,
                  ),),
                ],
              ),
            ),
            fallbackBuilder: (BuildContext context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/cart1.png',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Your cart is empty',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Sorry, the keyword you entered cannot',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: HexColor('#2121219C'),
                      fontSize: 18,
                    ),),
                  Text('be found, please check again or search with',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: HexColor('#2121219C'),
                      fontSize: 18,
                    ),),

                  Text('another keyword.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: HexColor('#2121219C'),
                      fontSize: 18,
                    ),),
                ],
              ),
            ),
            ),
          ),
        );
      },
    );
  }

}

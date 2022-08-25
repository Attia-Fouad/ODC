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

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    defaultFormField(
                      prefixIcon: IconBroken.Search,
                        suffixIcon: IconBroken.Filter,
                        controller: searchController,
                        type: TextInputType.text,
                        validator: (String? value){
                          if(value!.isEmpty)
                            {
                              return 'Search must not be empty';
                            }
                        },
                    ),
                    SizedBox(height: 150,),
                    Image.asset(
                      'assets/images/cart1.png',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Not found',
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

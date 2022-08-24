import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:odc/layout/plants_model/Data.dart';
import 'package:odc/layout/plants_model/PlantsModel.dart';
import 'package:odc/modules/address/address_screen.dart';
import 'package:odc/modules/cart/cart_screen.dart';
import 'package:odc/modules/search/search_screen.dart';
import 'package:odc/shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/MyPostsModel.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) =>cubit.plantsModel?.data!=null,
          widgetBuilder: (BuildContext context) => DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: const Center(child: Text(
                  'Discussion Forums',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ),
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              navigateTo(context, const SearchScreen());
                            },
                            child: Container(
                              height:54 ,
                              decoration: BoxDecoration(
                                color: HexColor('#F5F5F5'),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: const [
                                    Icon(IconBroken.Search),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Search',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        InkWell(
                          onTap: (){
                            navigateTo(context, const CartScreen());
                          },
                          child: Container(
                            width: 51,
                              height: 46,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: HexColor('#1ABC00'),
                              ),
                              child: const Icon(
                                  IconBroken.Buy,
                                color: Colors.white,
                              )
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child:  TabBar(
                        labelColor: HexColor('#1ABC00'),
                        unselectedLabelColor:HexColor('#8A8A8A'),
                        indicatorColor: HexColor('#1ABC00'),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: const [
                          Tab(
                            child: Text(
                              'All',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Plants',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Seeds',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Tools',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        child:     TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  GridView.count(
                                    mainAxisSpacing: 1,
                                    crossAxisSpacing: 1,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    childAspectRatio: 1 / 1.58,
                                    crossAxisCount: 2,
                                    children: List.generate(
                                        10,
                                            (index) =>
                                                buildProductItem(cubit.plantsModel!.data![index]),),
                                  ),
                                ],
                              ),
                            ),

                            Center(child:  Text('Plants')),
                            Center(child:  Text('Seeds')),
                            Center(child:  Text('Tools')),
                          ],

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallbackBuilder: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  buildProductItem(Data model)=> Column(
    children: [
      SizedBox(
        height: 45,
      ),
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 230,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 10,
                      color: Colors.grey),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                 Text(
                  model.name!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text("70 EGP"),
                defaultButton(width: 150,
                    text: "Add To Cart", radius: 20, function: (){},background: HexColor('#1ABC00'))
              ],
            ),
          ),
          Positioned(
            top: -40,
            left: 10,
            child: Image.asset(
                'assets/images/plant.png'
            ),
          ),
          Positioned(
            top: 40,
            left: 90,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.remove,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  "1",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 16),
                ),
                const SizedBox(
                  width: 12,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.add,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ],
  );
}

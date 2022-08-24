import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:odc/layout/home_layout/home_layout_screen.dart';
import 'package:odc/shared/components/constants.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class AddressScreen extends StatelessWidget {
   AddressScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var addressController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppSuccessGetLocationState)
          {
            addressController.text=AppCubit.get(context).address.toString();
          }
        if(state is AppSuccessClaimFreeSeedsState){
          if(state.message=='Success') {
            navigateAndFinish(context, const HomeLayoutScreen());
          }
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 150,
                      ),
                      const Text('Get Seeds For Free',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),),
                      const SizedBox(height: 10,),
                      const Text('Enter your Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),),
                      const SizedBox(height: 35,),
                      defaultFormField(
                         onTap: (){
                           cubit.getCurrentLocation();
                           cubit.getAddress(cubit.position);
                         },
                        suffixIcon: IconBroken.Location,
                        controller: addressController,
                        label: 'Address',
                        type: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Address must be not empty';
                          } else {
                            return null;
                          }

                        },
                      ),
                      const SizedBox(height: 20,),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (BuildContext context) =>
                        state is !AppLoadingClaimFreeSeedsState,
                        widgetBuilder: (BuildContext context) =>
                            defaultButton(
                                text: 'Send',
                                background: HexColor('#1ABC00'),
                                function: (){
                              if (formKey.currentState!.validate()) {
                                cubit.claimFreeSeeds(address: addressController.text,token: token!);
                              }
                            },radius: 10),
                        fallbackBuilder: (BuildContext context) =>
                        const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(height: 20,),
                      defaultButton(
                        textColor: HexColor('#979797'),
                          text: 'Save For Later',
                          background: HexColor('#F0F0F0'),
                          function: (){
                            navigateAndFinish(context, const HomeLayoutScreen());
                          },radius: 10),



                    ],
                  ),
                ),
              ),
            ),
          ),

        );
      },
    );
  }
}

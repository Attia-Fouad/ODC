import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:odc/layout/home_layout/home_layout_screen.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class EditNameScreen extends StatelessWidget {
  const EditNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstNameController=TextEditingController();
    var lastNameController=TextEditingController();
    var formKey = GlobalKey<FormState>();
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppSuccessUpdateUserNameState)
          {
            AppCubit.get(context).getUserData(token!);
            navigateTo(context, const HomeLayoutScreen());
          }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        firstNameController.text=cubit.userModel!.data!.firstName!;
        lastNameController.text=cubit.userModel!.data!.lastName!;
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text(
              'Edit User Name',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 21,
              ),
            )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    const SizedBox(height: 15,),
                    defaultFormField(
                      controller: firstNameController,
                      label: 'FirstName',
                      type: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'First Name must be not empty';
                        } else {
                          return null;
                        }

                      },
                    ),
                    const SizedBox(height: 15,),
                    defaultFormField(
                      controller: lastNameController,
                      label: 'Last Name',
                      type: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Last Name must be not empty';
                        } else {
                          return null;
                        }

                      },
                    ),
                    const SizedBox(height: 20,),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                      state is !AppLoadingUpdateUserNameState,
                      widgetBuilder: (BuildContext context) =>
                          defaultButton(
                            background: HexColor('#1ABC00'),
                              text: 'Update', function: (){
                            if (formKey.currentState!.validate()) {
                              cubit.updateUserName(
                                  token: token!,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                              );
                            }
                          },radius: 8),
                      fallbackBuilder: (BuildContext context) =>
                      const Center(child: CircularProgressIndicator()),
                    ),



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

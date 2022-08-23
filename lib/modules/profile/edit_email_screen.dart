import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:odc/layout/home_layout/home_layout_screen.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class EditEmailScreen extends StatelessWidget {
  const EditEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailNameController=TextEditingController();
    var newEmailNameController=TextEditingController();
    var formKey = GlobalKey<FormState>();
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppSuccessUpdateUserEmailState)
          {
            AppCubit.get(context).getUserData(token!);
            navigateTo(context, const HomeLayoutScreen());
          }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text(
              'Edit User Email',
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
                      controller: emailNameController,
                      label: 'Enter Your Email',
                      type: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email must be not empty';
                        }
                        else if (!value.toString().contains('@') ||
                            !value.toString().contains('.com')) {
                          return 'ex: example@mail.com';
                        }
                        else if(emailNameController.text!=cubit.userModel!.data!.email)
                        {
                          return 'Email is Incorrect';
                        }
                        else {
                          return null;
                        }

                      },
                    ),
                    const SizedBox(height: 15,),
                    defaultFormField(
                      controller: newEmailNameController,
                      label: 'New Email',
                      type: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'New Email must be not empty';
                        }
                        else if (!value.toString().contains('@') ||
                            !value.toString().contains('.com')) {
                          return 'ex: example@mail.com';
                        }
                        else {
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
                              cubit.updateUserEmail(
                                  token: token!,
                                email: newEmailNameController.text,
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

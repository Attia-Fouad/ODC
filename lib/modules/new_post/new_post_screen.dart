import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:odc/layout/home_layout/home_layout_screen.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreatePostSuccessState) {
          navigateAndFinish(context, const HomeLayoutScreen());
        }
        if (state is AppPostImagePickedSuccessState) {
          AppCubit.get(context).convertImageToBase64();
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Create New Post',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          cubit.postImage != null,
                      widgetBuilder: (BuildContext context) => Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 140.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: FileImage(cubit.postImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () {
                                  cubit.removePostImage();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      fallbackBuilder: (BuildContext context) => InkWell(
                        onTap: () {
                          cubit.getPostImage();
                        },
                        child: Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Plus,
                                  color: HexColor('#1ABC00'),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Add Photo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: HexColor('#1ABC00'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          width: 136,
                          height: 136,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: HexColor('#1ABC00')),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: titleController,
                        label: 'Title',
                        type: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Title must not be empty ...';
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Description must not be empty ...';
                        }
                      },
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        label: Text('Description'),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          cubit.postImage != null,
                      widgetBuilder: (BuildContext context) => defaultButton(
                          background: HexColor('#1ABC00'),
                          radius: 10,
                          text: 'Post',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.createPost(
                                token: token!,
                                title: titleController.text,
                                description: descriptionController.text,
                                image: cubit.base64Image,
                              );
                            }
                          }),
                      fallbackBuilder: (BuildContext context) => defaultButton(
                          background: HexColor('#8F8D8D'),
                          radius: 10,
                          text: 'Post',
                          function: () {
                            showToast(
                                state: ToastStates.ERROR,
                                text: 'You Should Add Image');
                          }),
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

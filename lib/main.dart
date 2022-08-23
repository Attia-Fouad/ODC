import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/shared/bloc_observer.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/networks/local/cache_helper.dart';
import 'package:odc/shared/networks/remote/dio_helper.dart';
import 'package:odc/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/home_layout/home_layout_screen.dart';
import 'modules/authintication/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData(key:'token');
  rememberMe = CacheHelper.getData(key:'rememberMe');
  Widget widget;
  if (token!=null&&rememberMe!=null) {
    widget = const HomeLayoutScreen();
  } else {
    widget = const AuthScreen();
  }



  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget  {
  Widget startWidget;
  MyApp({Key? key,
    required this.startWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {
        },
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );

  }
}

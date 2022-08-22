

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/layout/cubit/states.dart';
import 'package:odc/modules/authintication/cubit/cubit.dart';
import 'package:odc/modules/scan/scan_screen.dart';

import '../../models/UserModel.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/notification/notification_screen.dart';
import '../../modules/profile/profile_screen.dart';
import '../../modules/search/search_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/networks/end_points.dart';
import '../../shared/networks/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 2;
  PageController pageController=PageController(initialPage: 2);

  bool isFav=false;

  void changeBottom(int index) {
    currentIndex = index;
    if(index==4)
      {
          getUserData(userToken!);

      }

    emit(AppChangeBottomNavState());
  }

  UserModel? userModel;
  void getUserData(String token) {
    emit(AppLoadingUserDataState());
    DioHelper.getData(
      url: USER_DATA,
      token: token,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(AppSuccessUserDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorUserDataState(error: error.toString()));
    });
  }
/*
  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(AppSuccessCategoriesState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorCategoriesState(error: error.toString()));
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites({required int productId}) {
    favorites[productId] = !favorites[productId]!;
    emit(AppFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(AppSuccessFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(AppErrorFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(AppLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(AppSuccessGetFavoritesState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorGetFavoritesState(error: error.toString()));
    });
  }

  AppLoginModel? userDataModel;
  void getUserData() {
    emit(AppLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userDataModel = AppLoginModel.fromJson(value.data);
      //print(value.data.toString());

      emit(AppSuccessUserDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorUserDataState(error: error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(AppLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userDataModel = AppLoginModel.fromJson(value.data);
      //print(value.data.toString());
      emit(AppSuccessUpdateUserState());
      showToast(text: 'Update Successfully', state: ToastStates.SUCCESS);
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorUpdateUserState(error: error.toString()));
    });
  }


*/
}

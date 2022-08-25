import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:odc/layout/cubit/states.dart';
import 'package:odc/models/products_model/ProductsModel.dart';
import 'package:odc/modules/posts/posts_screen.dart';
import 'package:odc/modules/scan/scan_screen.dart';
import 'package:odc/shared/components/components.dart';
import '../../location_helper.dart';
import '../../models/MyPostsModel.dart';
import '../../models/blogs_model/BlogsModel.dart';
import '../../models/plants_model/PlantsModel.dart';
import '../../models/seeds_model/SeedsModel.dart';
import '../../models/tools_model/ToolsModel.dart';
import '../../models/user_model/UserModel.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/notification/notification_screen.dart';
import '../../modules/profile/profile_screen.dart';
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
    if(index==2)
    {
      getPlants(token!);
      getSeeds(token!);
      getTools(token!);
      getProducts(token!);
      getBlogs(token!);
    }
    if(index==4)
      {
          getUserData(token!);
      }
    if(index==0)
    {
      getUserData(token!);
      getMyPosts(token!);
    }

    emit(AppChangeBottomNavState());
  }

  List<Widget> screens = [
  const PostsScreen(),
  const ScanScreen(),
  const HomeScreen(),
  const NotificationScreen(),
  const ProfileScreen(),
  ];

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


  MyPostsModel? myPostsModel;
  void getMyPosts(String token) {
    emit(AppLoadingGetMyPostsState());
    DioHelper.getData(
      url: MY_POSTS,
      token: token,
    ).then((value) {
      myPostsModel = MyPostsModel.fromJson(value.data);
      emit(AppSuccessGetMyPostsState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorGetMyPostsState(error: error.toString()));
    });
  }

  PlantsModel? plantsModel;
  void getPlants(String token) {
    emit(AppLoadingGetPlantsState());
    DioHelper.getData(
      url: PLANTS,
      token: token,
    ).then((value) {
      plantsModel = PlantsModel.fromJson(value.data);
      emit(AppSuccessGetPlantsState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorGetPlantsState(error: error.toString()));
    });
  }

  ProductsModel? productsModel;
  void getProducts(String token) {
    emit(AppLoadingGetProductsState());
    DioHelper.getData(
      url: PRODUCTS,
      token: token,
    ).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      emit(AppSuccessGetProductsState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorGetProductsState(error: error.toString()));
    });
  }

  SeedsModel? seedsModel;
  void getSeeds(String token) {
    emit(AppLoadingGetSeedsState());
    DioHelper.getData(
      url: SEEDS,
      token: token,
    ).then((value) {
      seedsModel = SeedsModel.fromJson(value.data);
      emit(AppSuccessGetSeedsState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorGetSeedsState(error: error.toString()));
    });
  }


  ToolsModel? toolsModel;
  void getTools(String token) {
    emit(AppLoadingGetToolsState());
    DioHelper.getData(
      url: TOOLS,
      token: token,
    ).then((value) {
      toolsModel = ToolsModel.fromJson(value.data);
      emit(AppSuccessGetToolsState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorGetToolsState(error: error.toString()));
    });
  }

  BlogsModel? blogsModel;
  void getBlogs(String token) {
    emit(AppLoadingGetBlogsState());
    DioHelper.getData(
      url: BLOGS,
      token: token,
    ).then((value) {
      blogsModel = BlogsModel.fromJson(value.data);
      emit(AppSuccessGetBlogsState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AppErrorGetBlogsState(error: error.toString()));
    });
  }




  void updateUserName({
    required String token,
    required String firstName,
    required String lastName,
  }) {
    emit(AppLoadingUpdateUserNameState());

    DioHelper.patchData(
      token: token,
        url: UPDATE_USER_NAME,
        data: {
          'firstName': firstName,
          'lastName': lastName,
        }).then((value) {
      showToast(state: ToastStates.SUCCESS,text:value.data['message']);
      emit(AppSuccessUpdateUserNameState());
    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      if(error is DioError)
      {
        showToast(state: ToastStates.ERROR,text: error.response!.data!['message']);
      }
      emit(AppErrorUpdateUserNameState(error: error.toString()));
    });
  }

  void updateUserEmail({
    required String token,
    required String email,
  }) {
    emit(AppLoadingUpdateUserEmailState());

    DioHelper.patchData(
        token: token,
        url: UPDATE_USER_NAME,
        data: {
          'email': email,
        }).then((value) {
      showToast(state: ToastStates.SUCCESS,text:value.data['message']);
      emit(AppSuccessUpdateUserEmailState());
    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      if(error is DioError)
      {
        showToast(state: ToastStates.ERROR,text: error.response!.data!['message']);
      }
      emit(AppErrorUpdateUserEmailState(error: error.toString()));
    });
  }


  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    getCurrentLocation();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position= await Geolocator.getCurrentPosition();
    return await Geolocator.getCurrentPosition();
  }


   Position? position;



  Future<void> getCurrentLocation() async {
    await LocationHelper.determinePosition();
    position =
    await Geolocator.getLastKnownPosition();
    getAddress(position);
    print('My Lat Log ..........');
    print(position?.longitude);
    print(position?.latitude);
    emit(AppSuccessGetLocationState());
  }

  dynamic address;
  Future<void> getAddress(Position? p) async
  {
    List<Placemark> placemarks = await placemarkFromCoordinates(p!.latitude, p.longitude);
    address=placemarks[0].locality;

  }


  void claimFreeSeeds({
    required String token,
    required String address,
  }) {
    emit(AppLoadingClaimFreeSeedsState());

    DioHelper.postData(
        token: token,
        url: CLAIM_FREE_SEEDS,
        data: {
          'address': address,
        }).then((value) {
      showToast(state: ToastStates.SUCCESS,text:value.data['message']);
      emit(AppSuccessClaimFreeSeedsState(message: value.data['type']));
    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      if(error is DioError)
      {
        showToast(state: ToastStates.ERROR,text: error.response!.data!['message']);
      }
      emit(AppErrorClaimFreeSeedsState(error: error.toString()));
    });
  }




  File? postImage;
  Uint8List? bytes;
  String? base64Image;
  final ImagePicker picker = ImagePicker();
  void removePostImage() {
    postImage = null;
    emit(AppRemovePostImageState());
  }

  Future<void> getPostImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    postImage = File(image!.path);
    emit(AppPostImagePickedSuccessState());
  }

  void convertImageToBase64()
  {
    bytes=File(postImage!.path).readAsBytesSync();
    base64Image=base64Encode(bytes!);
    print('iamge base 64 here');
    print(base64Image);
  }


  void createPost({
    required String token,
    required String? title,
    required String? description,
    required String? image,
  }) {
    emit(AppCreatePostLoadingState());

    DioHelper.postData(
        token: token,
        url: CREATE_POST,
        data: {
          'title': title,
          'description': description,
          'imageBase64': 'data:image/png;base64,$image',
        }).then((value) {
      showToast(state: ToastStates.SUCCESS,text:value.data['message']);
      getMyPosts(token);
      emit(AppCreatePostSuccessState());
    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      if(error is DioError)
      {
        showToast(state: ToastStates.ERROR,text: error.response!.data!['message']);
      }
      emit(AppCreatePostErrorState(error: error.toString()));
    });
  }





}

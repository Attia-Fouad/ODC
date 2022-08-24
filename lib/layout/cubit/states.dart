
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppLoadingHomeDataState extends AppStates {}

class AppSuccessHomeDataState extends AppStates {}

class AppErrorHomeDataState extends AppStates {
  String? error;
  AppErrorHomeDataState({this.error});
}

class AppSuccessCategoriesState extends AppStates {}

class AppErrorCategoriesState extends AppStates {
  String? error;
  AppErrorCategoriesState({this.error});
}


class AppFavoritesState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppErrorFavoritesState extends AppStates {
  String? error;
  AppErrorFavoritesState({this.error});
}

class AppLoadingGetFavoritesState extends AppStates {}

class AppSuccessGetFavoritesState extends AppStates {}

class AppErrorGetFavoritesState extends AppStates {
  String? error;
  AppErrorGetFavoritesState({this.error});
}

class AppLoadingUserDataState extends AppStates {}

class AppSuccessUserDataState extends AppStates {}

class AppErrorUserDataState extends AppStates {
  String? error;
  AppErrorUserDataState({this.error});
}

class AppLoadingUpdateUserState extends AppStates {}

class AppSuccessUpdateUserState extends AppStates {}

class AppErrorUpdateUserState extends AppStates {
  String? error;
  AppErrorUpdateUserState({this.error});
}

class AppSuccessAddItemToCartState extends AppStates {}
class AppSuccessRemoveItemFromCartState extends AppStates {}
class AppSuccessCalcTotalState extends AppStates {}



class AppLoadingGetMyPostsState extends AppStates {}

class AppSuccessGetMyPostsState extends AppStates {}

class AppErrorGetMyPostsState extends AppStates {
  String? error;
  AppErrorGetMyPostsState({this.error});
}
class AppLoadingUpdateUserNameState extends AppStates {}

class AppSuccessUpdateUserNameState extends AppStates {}

class AppErrorUpdateUserNameState extends AppStates {
  String? error;
  AppErrorUpdateUserNameState( {this.error});
}

class AppLoadingUpdateUserEmailState extends AppStates {}

class AppSuccessUpdateUserEmailState extends AppStates {}

class AppErrorUpdateUserEmailState extends AppStates {
  String? error;
  AppErrorUpdateUserEmailState( {this.error});

}


class AppSuccessGetLocationState extends AppStates {}



class AppLoadingClaimFreeSeedsState extends AppStates {}

class AppSuccessClaimFreeSeedsState extends AppStates {
  String? message;
  AppSuccessClaimFreeSeedsState( {this.message});
}

class AppErrorClaimFreeSeedsState extends AppStates {
  String? error;
  AppErrorClaimFreeSeedsState( {this.error});

}



class AppLoadingGetPlantsState extends AppStates {}

class AppSuccessGetPlantsState extends AppStates {}

class AppErrorGetPlantsState extends AppStates {
  String? error;
  AppErrorGetPlantsState({this.error});
}




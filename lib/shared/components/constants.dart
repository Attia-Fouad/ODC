 import '../networks/local/cache_helper.dart';
import 'components.dart';

void signOut(context,widget) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, widget);
      showToast(
          text: 'LogOut',
          state: ToastStates.WARNING);
    }
  });
}


 String? token;
 String? userToken;


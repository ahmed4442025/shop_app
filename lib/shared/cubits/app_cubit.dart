import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models_scr/login/login_scr.dart';
import 'package:shop_app/shared/Preferences/preferences_names.dart';
import 'package:shop_app/shared/other/help_methods.dart';
import '../Preferences/chash_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  static void init() {}

  // Preferences vars
  bool isDark = CacheHelper.getBool(key: PrefrKeys.isDark) ?? false;

  // cache
  void changeIsDark() {
    isDark = !isDark;
    CacheHelper.setValue(key: 'isDark', value: isDark);
    emit(AppChangeDarkModState());
  }

  // ===========  login page  ================
  // login page vars
  PageController pageConroller = PageController();
  bool isLastIntro = false;

  VoidCallback nextPageControl(BuildContext context) => () {
        if (isLastIntro) {
          skipIntro(context);
        } else {
          pageConroller.nextPage(
              duration: const Duration(microseconds: 750),
              curve: Curves.fastLinearToSlowEaseIn);
        }
      };

  void isThislast(int index, int total, BuildContext context) {
    if (index == total - 1) {
      isLastIntro = true;
    }else{
      isLastIntro = false;
    }
  }

  void skipIntro(context){
    CacheHelper.setValue(key: PrefrKeys.firstTime, value: false);
    HelpMethods.openScrNoBack(context, LoginScr());
  }
}

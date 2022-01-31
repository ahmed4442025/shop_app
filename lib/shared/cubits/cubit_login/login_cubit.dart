import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/models_scr/login/login/login_scr.dart';
import 'package:shop_app/shared/Preferences/chash_helper.dart';
import 'package:shop_app/shared/Preferences/preferences_names.dart';
import 'package:shop_app/shared/network/strings/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/other/help_methods.dart';
import 'package:shop_app/shared/other/show_hide_pass.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) {
    return BlocProvider.of(context);
  }

  // ===========  intro page  ================
  // intro page vars
  PageController pageIntroConrol = PageController();
  bool isLastIntro = false;

  VoidCallback nextPageControl(BuildContext context) => () {
        if (isLastIntro) {
          skipIntro(context);
        } else {
          pageIntroConrol.nextPage(
              duration: const Duration(microseconds: 750),
              curve: Curves.fastLinearToSlowEaseIn);
        }
      };

  void isThislast(int index, int total, BuildContext context) {
    if (index == total - 1) {
      isLastIntro = true;
    } else {
      isLastIntro = false;
    }
  }

  void skipIntro(context) {
    CacheHelper.setValue(key: PrefrKeys.firstTime, value: false);
    HelpMethods.openScrNoBack(context, LoginScr());
  }

  void logOut(context) {
    CacheHelper.removeKey(PrefrKeys.token);
    HelpMethods.openScrNoBack(context, LoginScr());
  }

  // ===========  login page  ================
  //vars
  ShowHidePass izPass = ShowHidePass();

  static void init() {}

  void saveLastEmail(String email) {
    CacheHelper.setValue(key: PrefrKeys.lastEmail, value: email);
  }

  String getLastEmail() {
    return CacheHelper.getString(key: PrefrKeys.lastEmail) ?? '';
  }

  void login(String email, String pass, {bool savaEmail = true}) async {
    emit(LoginLoadingState());
    var data = {'email': email, 'password': pass};
    if(savaEmail){
      saveLastEmail(email);
    }
    DioHelper.postData(EndPoint.login, data).then((value) {
      LoginModel model = LoginModel.fromJson(value!.data);
      CacheHelper.setValue(key: PrefrKeys.token, value: model.data!.token);
      emit(LoginSuccessState(model));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  VoidCallback changePassShow() => () {
        izPass.changeShow();
        emit(LoginChangePassIcoState());
      };
}

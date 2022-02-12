import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home/home_layout.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/register_fields.dart';
import 'package:shop_app/models/register_res_model.dart';
import 'package:shop_app/models_scr/login/login/login_scr.dart';
import 'package:shop_app/shared/Preferences/chash_helper.dart';
import 'package:shop_app/shared/Preferences/preferences_names.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/network/strings/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/other/components.dart';
import 'package:shop_app/shared/other/help_methods.dart';
import 'package:shop_app/shared/other/show_hide_pass.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) {
    return BlocProvider.of(context);
  }

  void init(context) {
    cubit = AppCubit.get(context);
  }

  late AppCubit cubit;

  // ===========  intro page  ================
  // intro page vars
  PageController pageIntroConrol = PageController();
  bool isLastIntro = false;

  VoidCallback nextPageControl(BuildContext context) =>
          () {
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
    DioHelper.postData(EndPoint.logout, {}, token: cubit.token).then((value) {
      LogOutModel model = LogOutModel.fromJson(value!.data);
      if (model.status ?? false) {
        CacheHelper.removeKey(PrefrKeys.token);
        cubit.token = '';
        HelpMethods.openScrNoBack(context, LoginScr());
      } else {
        Components.showToast(model.message.toString(), clr: Colors.red);
      }
    }).catchError((e) {
      Components.showToast(e.toString(), clr: Colors.red);
    });
  }

  // ===========  login page  ================
  //vars
  ShowHidePass izPassLoginScr = ShowHidePass();
  ShowHidePass izPassRegisterScr = ShowHidePass();

  void saveLastEmail(String email) {
    CacheHelper.setValue(key: PrefrKeys.lastEmail, value: email);
  }

  String getLastEmail() {
    return CacheHelper.getString(key: PrefrKeys.lastEmail) ?? '';
  }

  void login(String email, String pass, BuildContext context,
      {bool savaEmail = true}) async {
    emit(LoginLoadingState());
    var data = {'email': email, 'password': pass};
    if (savaEmail) {
      saveLastEmail(email);
    }
    DioHelper.postData(EndPoint.login, data).then((value) {
      LoginModel model = LoginModel.fromJson(value!.data);
      CacheHelper.setValue(key: PrefrKeys.token, value: model.data!.token);
      cubit.token = model.data!.token ?? '';
      Components.showToast(model.message ?? 'no');
      cubit.initDefult().then((value) => emit(LoginSuccessState(model)));
    }).catchError((error) {
      Components.showToast(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  void registerNew(RegisterFields user, context, {bool openScr = true}) {
    emit(LoginLoadingRegisterState());
    var data = user.toData();
    DioHelper.postData(EndPoint.register, data, token: '').then((value) {
      RegisterRespModel model = RegisterRespModel.fromJson(value!.data);
      if (model.status ?? false) {
        CacheHelper.setValue(key: PrefrKeys.token, value: model.data!.token);
        cubit.token = model.data!.token ?? '';
        cubit.initDefult().then((value) {
          emit(LoginSuccessRegisterState());
          HelpMethods.openScrNoBack(context, HomeLayout());
        });
      } else {
        Components.showToast(model.message ?? 'not Register');
        emit(LoginFaildRegisterState());
      }
    }).catchError((error) {
      Components.showToast(error.toString());
      emit(LoginErrorRegisterState());
    });
  }

  void updateUser(RegisterFields user) {
    emit(LoginLoadingUpdateUserState());
    var data = user.toData();
    DioHelper.putData(EndPoint.update_profile, data, token: cubit.token)
        .then((value) {
      ProfileModel model = ProfileModel.fromJson(value!.data);
      if (model.status ?? false) {
        CacheHelper.setValue(
            key: PrefrKeys.lastEmail, value: model.data!.email);
        Components.showToast(model.message ?? 'ok');
        cubit.getSittingsHttp().then((value) => {
        emit(LoginSuccessUpdateUserState())
        });
      } else {
        Components.showToast(model.message ?? 'not Updated');
        emit(LoginFaildUpdateUserState());
      }
    }).catchError((error) {
      Components.showToast(error.toString());
      emit(LoginErrorUpdateUserState());
    });
  }

  VoidCallback changePassLoginShow() =>
          () {
        izPassLoginScr.changeShow();
        emit(LoginChangePassIcoState());
      };

  VoidCallback changePassRegisterShow() =>
          () {
        izPassRegisterScr.changeShow();
        emit(LoginChangePassIcoState());
      };
}

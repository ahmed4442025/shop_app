import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/models_scr/login/cubit/login_states.dart';
import 'package:shop_app/shared/network/strings/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/other/show_hide_pass.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) {
    return BlocProvider.of(context);
  }

  //vars
  ShowHidePass izPass = ShowHidePass();

  static void init() {}

  void login(String email, String pass) async {
    emit(LoginLoadingState());
    var data = {'email': email, 'password': pass};
    DioHelper.postData(EndPoint.login, data).then((value) {
      emit(LoginSuccessState(LoginModel.fromJson(value!.data)));
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

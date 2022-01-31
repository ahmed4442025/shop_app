import 'package:shop_app/models/login/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  LoginModel loginmodel = LoginModel();

  LoginSuccessState(this.loginmodel);
}

class LoginLoadingState extends LoginStates {}

class LoginFaildState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePassIcoState extends LoginStates {}

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeDarkModState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppLoadingHttpState extends AppStates {}

class AppSuccessHttpState extends AppStates {}

class AppErrorHttpState extends AppStates {
  String error;

  AppErrorHttpState(this.error);
}

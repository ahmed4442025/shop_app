abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeDarkModState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppLoadingHttpHomeState extends AppStates {}

class AppSuccessHttpHomeState extends AppStates {}

class AppErrorHttpHomeState extends AppStates {
  String error;

  AppErrorHttpHomeState(this.error);
}

class AppLoadingHttpCatState extends AppStates {}

class AppSuccessHttpCatState extends AppStates {}

class AppErrorHttpCatState extends AppStates {
  String error;

  AppErrorHttpCatState(this.error);
}

class AppSuccessHttpFavChangeState extends AppStates {}
class AppLoadingHttpFavChangeState extends AppStates {}

class AppErrorHttpFavChangeState extends AppStates {
  String error;

  AppErrorHttpFavChangeState(this.error);
}
class AppSuccessHttpFavGetState extends AppStates {}
class AppLoadingHttpFavGetState extends AppStates {}

class AppErrorHttpFavGetState extends AppStates {
  String error;

  AppErrorHttpFavGetState(this.error);
}

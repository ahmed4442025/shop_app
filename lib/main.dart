import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Intro_home_layout.dart';
import 'package:shop_app/models_scr/login/login_scr.dart';
import 'package:shop_app/shared/Preferences/preferences_names.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/Preferences/chash_helper.dart';
import 'package:shop_app/shared/cubits/app_cubit.dart';
import 'package:shop_app/shared/cubits/app_states.dart';
import 'package:shop_app/shared/cubits/block_observer.dart';
import 'package:shop_app/shared/setting/vars.dart';
import 'package:shop_app/shared/styles/thems.dart';

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await CacheHelper.init();
      DioHelper.init();
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          Vars.init(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: MyThemes.themeLight(),
            darkTheme: MyThemes.themeDark(),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            // ******** I'M HERE **********
            home: checkHomeScr(),
          );
        },
      ),
    );
  }
}

Widget checkHomeScr() {
  bool izFirstTime = CacheHelper.getBool(key: PrefrKeys.firstTime) ?? true;
  String token = CacheHelper.getString(key: PrefrKeys.token) ?? '';
  if (izFirstTime) {
    return IntroHomeLayout();
  } else if (token.isEmpty) {
    return LoginScr();
  } else {
    return LoginScr();
  }
}

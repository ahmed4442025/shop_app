import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/Preferences/preferences_names.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/strings/end_points.dart';
import '../../Preferences/chash_helper.dart';
import 'app_states.dart';
import 'dart:io';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void init(context) {
    _getLocalLang();
    getHomeLocalTest(context);
  }

  // Preferences vars
  bool isDark = CacheHelper.getBool(key: PrefrKeys.isDark) ?? false;
  String token = CacheHelper.getString(key: PrefrKeys.token) ?? '';
  String? lang;

  // cache
  void changeIsDark() {
    isDark = !isDark;
    CacheHelper.setValue(key: PrefrKeys.isDark, value: isDark);
    emit(AppChangeDarkModState());
  }

  void _getLocalLang() {
    lang = CacheHelper.getString(key: PrefrKeys.lang);
    if (lang == null) {
      lang = Platform.localeName.split('_')[0].toLowerCase();
      if (!(lang == 'ar' || lang == 'en')) {
        lang = 'en';
      }
      CacheHelper.setValue(key: PrefrKeys.lang, value: lang);
    }
    // emit(AppErrorHttpState('error'));
    print('lang : $lang');
  }

  // ===========  home layout  ================
  //  home layout vars

  int homeNavIndex = 0;
  HomeModel? homeModel;

  void changeNavIndex(int index) {
    homeNavIndex = index;
    emit(AppChangeBottomNavState());
  }

  void getHomeHttp() async {
    emit(AppLoadingHttpState());
    await DioHelper.getData(EndPoint.home, token: token, lang: lang ?? 'ar')
        .then((value) {
      HomeModel home = HomeModel.fromJson(value.data);
      emit(AppSuccessHttpState());
    });
  }

  void getHomeLocalTest(context) async {
    emit(AppLoadingHttpState());
    await Future.delayed(Duration(seconds: 3)).then((value) async {
      String data =  await DefaultAssetBundle.of(context).loadString("assets/test/home_model_json.txt");
      final jsonResult = jsonDecode(data);
      homeModel = HomeModel.fromJson(jsonResult);
      print('Success get json from local asset');
      emit(AppSuccessHttpState());
    });
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/add_favor_model.dart';
import 'package:shop_app/models/categorries/categories.dart';
import 'package:shop_app/models/favoriets_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/shared/Preferences/preferences_names.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/strings/end_points.dart';
import '../../Preferences/chash_helper.dart';
import 'app_states.dart';
import 'dart:io';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Future<bool> init() async{
    _getLocalLang();
    if(token != ''){
      getHomeHttp();
      getCatHttp();
      getFavoritesHttp();
      await getSittingsHttp();
    }
    return true;

  }
  Future<bool> initDefult() async{
    homeModel = null;
    catModel = null;
    favorites = null;
    profile = null;
    izFav = {};
    await init();
    return true;
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

  void changeNavIndex(int index) {
    if (homeNavIndex != index) {
      homeNavIndex = index;
      emit(AppChangeBottomNavState());
    }
  }

  // ===========  http ===============
  HomeModel? homeModel;
  CategoriesModel? catModel;
  FavoritesModel? favorites ;
  ProfileModel? profile ;
  Map<int, bool> izFav = {};

  Future<int> getHomeHttp() async {
    emit(AppLoadingHttpHomeState());
    await DioHelper.getData(EndPoint.home, token: token, lang: lang ?? 'ar')
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var item in homeModel!.data!.products!) {
        izFav[item.id ?? -1] = item.inFavorites ?? false;
      }
      emit(AppSuccessHttpHomeState());
    });
    return 0;
  }

  void getCatHttp() async {
    emit(AppLoadingHttpCatState());
    await DioHelper.getData(EndPoint.categories, lang: lang ?? 'ar')
        .then((value) {
      catModel = CategoriesModel.fromJson(value.data);
      emit(AppSuccessHttpCatState());
    });
  }

  void getFavoritesHttp() async {
    emit(AppLoadingHttpFavGetState());
    await DioHelper.getData(EndPoint.favorites, token: token).then((value) {
      favorites = FavoritesModel.fromJson(value.data);
      for (var item in favorites!.data!.favorites!) {
        izFav[item.id ?? -1] = true;
      }
      emit(AppSuccessHttpFavGetState());
    });
  }

  void addOrREmoveFavor(int id) async {
    izFav[id] = !(izFav[id] ?? false);
    emit(AppLoadingHttpFavChangeState());
    await DioHelper.postData(EndPoint.favorites, {'product_id': id},
            token: token)
        .then((value) {
      AddFavorModel fav = AddFavorModel.fromJson(value!.data);
      if (fav.status ?? false) {
        emit(AppSuccessHttpFavChangeState());
      }else{
        izFav[id] = !(izFav[id] ?? true);
        emit(AppErrorHttpFavChangeState('${fav.message}'));
      }
      getFavoritesHttp();
      print(fav.message);
    }).catchError((e) {
      emit(AppErrorHttpFavChangeState(e.toString()));
      print(e.toString());
      izFav[id] = !(izFav[id] ?? true);
    });
  }

  Future<bool> getSittingsHttp() async {
    await DioHelper.getData(EndPoint.profile, token: token).then((value) {
      profile = ProfileModel.fromJson(value.data);
      emit(AppSuccessHttpFavGetState());
    });
    return true;
  }



  // ==========  TEST LOCAL  ============
  void getHomeLocalTest(context) async {
    emit(AppLoadingHttpHomeState());
    await Future.delayed(Duration(seconds: 2)).then((value) async {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/test/home_model_json.txt");
      final jsonResult = jsonDecode(data);
      homeModel = HomeModel.fromJson(jsonResult);
      for (var item in homeModel!.data!.products!) {
        izFav[item.id ?? -1] = item.inFavorites ?? false;
      }
      print('Success get json from local asset');
      emit(AppSuccessHttpHomeState());
    });
  }

  // ========= TEMP ==========
  Axis? carousScrollDirection;

  void randomScrollDirection() {
    emit(AppChangeDarkModState());
    var rng = Random();
    var b = rng.nextBool() ? Axis.vertical : Axis.horizontal;
    carousScrollDirection = b;
    print(b);
  }
}

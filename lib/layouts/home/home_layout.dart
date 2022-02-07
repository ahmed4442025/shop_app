import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_states.dart';
import 'package:shop_app/models_scr/categories/categories_scr.dart';
import 'package:shop_app/models_scr/favorits/favorits_scr.dart';
import 'package:shop_app/models_scr/products/products_scr.dart';
import 'package:shop_app/models_scr/settings/settengs_scr.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        myContext = context;
        cubit = AppCubit.get(context);
        return myScaffold();
      },
    );
  }

  //vars
  late BuildContext myContext;
  late AppCubit cubit;
  List<Widget> scrs = [
    ProductsScr(),
    CategoriesScr(),
    FavoritesScr(),
    SettingsScr()
  ];

  Scaffold myScaffold() => Scaffold(
        body: scrs[cubit.homeNavIndex],
        bottomNavigationBar: bottomBar(),
        floatingActionButton: fltb(),
      );

  Widget mainContainer() => Container(
        child: const Center(
          child: Text('home !'),
        ),
      );

  BottomNavigationBar bottomBar() => BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'settings'),
        ],
        onTap: (i) {
          cubit.changeNavIndex(i);
        },
        currentIndex: cubit.homeNavIndex,
      );

  // methods
  FloatingActionButton fltb() => FloatingActionButton(
        onPressed: () => cubit.getHomeHttp(),
      );
}

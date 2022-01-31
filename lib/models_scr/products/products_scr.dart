import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_states.dart';
import 'package:shop_app/shared/other/components.dart';

class ProductsScr extends StatelessWidget {
  ProductsScr({Key? key}) : super(key: key);

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

  Scaffold myScaffold() => Scaffold(
        appBar: AppBar(
          title: const Text('ProductsScr'),
        ),
        body: mainContainer(),
      );

  Widget mainContainer() => Container(
        child: Center(
          child: cubit.homeModel == null
              ? loading()
              : productBuilder(cubit.homeModel),
        ),
      );

  Widget loading() => Components.simpleText(txt: 'loading', size: 50);

  Widget productBuilder(HomeModel? model) => Column(
        children: [
          CarouselSlider(
            items: model!.data!.banners!
                .map((e) => Text(e.id.toString()))
                .toList(),
            options: CarouselOptions(height: 200),
          )
        ],
      );
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categorries/categories.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/models_scr/compon_priv.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_states.dart';
import 'package:shop_app/shared/other/components.dart';

class ProductsScr extends StatelessWidget {
  ProductsScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppErrorHttpFavChangeState) {
          Components.showToast(state.error);
        }
      },
      builder: (BuildContext context, state) {
        myContext = context;
        cubit = AppCubit.get(context);
        compPriv = ComponPrivt(cubit);
        return myScaffold();
      },
    );
  }

  //vars
  late BuildContext myContext;
  late AppCubit cubit;
  late ComponPrivt compPriv;

  Scaffold myScaffold() => Scaffold(
        appBar: AppBar(
          title: const Text('ProductsScr'),
        ),
        body: mainContainer(),
      );

  Widget mainContainer() => Container(
        child: Center(
          child: cubit.homeModel == null
              ? Components.loading()
              : productBuilder(cubit.homeModel),
        ),
      );

  Widget productBuilder(HomeModel? model) => SingleChildScrollView(
        child: Column(
          children: [
            sliderCarousel(model!.data!.banners),
            const SizedBox(
              height: 20,
            ),
            catBuilder(cubit.catModel),
            const SizedBox(
              height: 20,
            ),
            gridView(model.data!.products),
          ],
        ),
      );

  Widget sliderCarousel(List<Banners>? banners) => CarouselSlider(
        items: banners!.map((e) => compPriv.img(e.image)).toList(),
        options: CarouselOptions(
          height: 250,
          initialPage: 0,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          autoPlay: false,
          reverse: false,
          autoPlayInterval: const Duration(seconds: 2, milliseconds: 500),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.easeInOutCubicEmphasized,
          scrollDirection: Axis.vertical,
        ),
      );

  Widget gridView(List<Products>? products) => Container(
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              products!.length, (i) => compPriv.productItemColumn(products[i])),
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1 / 1.6,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      );

  Widget catBuilder(CategoriesModel? cats) => cats == null
      ? SizedBox(height: 100, child: Components.loading())
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, i) => Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          compPriv.img(cats.data!.data![i].image,
                              hight: 100, width: 100),
                          Container(
                            height: 20,
                            width: 100,
                            color: Colors.black.withOpacity(.8),
                            child: Center(
                              child: Text(
                                cats.data!.data![i].name ?? '',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                  separatorBuilder: (c, i) => const SizedBox(
                        width: 5,
                      ),
                  itemCount: cats.data!.data!.length),
            )
          ],
        );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favoriets_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/models_scr/compon_priv.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_states.dart';

class FavoritesScr extends StatelessWidget {
  FavoritesScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        myContext = context;
        cubit = AppCubit.get(context);
        compPriv = ComponPrivt(cubit);
        return myScaffold(state);
      },
    );
  }

  //vars
  late BuildContext myContext;

  late AppCubit cubit;
  late ComponPrivt compPriv;

  Scaffold myScaffold(AppStates state) => Scaffold(
        appBar: AppBar(
          title: const Text('title'),
        ),
        body: compPriv.showLoading(
            state != AppLoadingHttpFavGetState, mainContainer()),
      );

  Widget mainContainer() {
    print(cubit.favorites!.data!.favorites.runtimeType);
    return compPriv.showLoading(cubit.favorites != null,
        favorListBuilder(cubit.favorites!.data!.favorites));
  }

  Widget favorListBuilder(List<FavoritesData>? favorts) {
    print(favorts.runtimeType);
    return ListView.separated(
        itemBuilder: (c, i) => compPriv.productItemRow(favorts![i].product),
        separatorBuilder: (c, i) => compPriv.line(),
        itemCount: favorts!.length);
  }
}

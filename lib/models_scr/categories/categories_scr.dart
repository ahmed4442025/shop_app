import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categorries/categories.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_states.dart';
import 'package:shop_app/shared/other/components.dart';

class CategoriesScr extends StatelessWidget {
  CategoriesScr({Key? key}) : super(key: key);

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
          title: const Text('CategoriesScr'),
        ),
        body: mainContainer(),
      );

  Widget mainContainer() => Column(
        children: [Expanded(child: buildCats(cubit.catModel!.data!.data))],
      );

  Widget buildCats(List<CatDataData>? cats) => cats == null
      ? Components.loading()
      : ListView.separated(
          itemBuilder: (c, i) => buildCatItem(cats[i]),
          separatorBuilder: (c, i) => Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 2,
                  color: Colors.grey,
                ),
              ),
          itemCount: cats.length);

  Widget buildCatItem(CatDataData cat)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(cat.image ?? ''),
          height: 100,
          width: 100,
        ),
        Text(
          '    ' + (cat.name ?? ''),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios_outlined)
      ],
    ),
  );
}

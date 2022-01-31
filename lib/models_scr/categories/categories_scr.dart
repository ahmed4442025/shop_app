import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_states.dart';

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
  late BuildContext myContext ;
  late AppCubit cubit;

  Scaffold myScaffold( ) => Scaffold(
    appBar: AppBar(
      title: const Text('CategoriesScr'),
    ),
    body: mainContainer(),
  );

  Widget mainContainer()=>Container(
    child: const Center(
      child: Text('CategoriesScr !'),
    ),
  );


}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_states.dart';

class TempHome extends StatelessWidget {
  TempHome({Key? key}) : super(key: key);

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

  // vars
  late BuildContext myContext;
  late AppCubit cubit;

  Scaffold myScaffold() => Scaffold(
        appBar: AppBar(
          title: const Text('title'),
        ),
        body: const Center(
          child: Text('New App !'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: testVoid1(),
          child: const Icon(Icons.dark_mode),
        ),
      );

  VoidCallback testVoid() => () async {
        String data = await DefaultAssetBundle.of(myContext)
            .loadString("assets/test/home_model_json.txt");
        final jsonResult = jsonDecode(data);
        HomeModel home = HomeModel.fromJson(jsonResult);
        print(home.status);
      };

  VoidCallback testVoid1() => () {
        print('from test scr');
        cubit.getHomeLocalTest(myContext);
      };
}

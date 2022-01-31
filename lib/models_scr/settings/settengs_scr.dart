import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubits/cubit_login/login_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_states.dart';

class SettingsScr extends StatelessWidget {
  SettingsScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        myContext = context;
        cubit = AppCubit.get(context);
        cubitLogin = LoginCubit.get(context);
        return myScaffold();
      },
    );
  }

  //vars
  late BuildContext myContext;

  late AppCubit cubit;
  late LoginCubit cubitLogin;

  Scaffold myScaffold() => Scaffold(
        appBar: AppBar(
          title: const Text('SettingsScr'),
        ),
        body: mainContainer(),
      );

  Widget mainContainer() => Container(
        child: TextButton(
          onPressed: ()=>cubitLogin.logOut(myContext),
          child: const Text('LOG OUT'),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubits/cubit_login/login_cubit.dart';
import 'package:shop_app/shared/cubits/cubit_login/login_states.dart';

class RefisterScr extends StatelessWidget {
  RefisterScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        myContext = context;
        cubit = LoginCubit.get(context);
        return myScaffold();
      },
    );
  }

  //vars
  late BuildContext myContext ;
  late LoginCubit cubit;

  Scaffold myScaffold( ) => Scaffold(
    appBar: AppBar(
      title: const Text('RefisterScr'),
    ),
    body: mainContainer(),
  );

  Widget mainContainer()=>Container(
    child: const Center(
      child: Text('RefisterScr !'),
    ),
  );


}

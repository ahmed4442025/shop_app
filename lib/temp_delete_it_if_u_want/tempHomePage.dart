import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubits/app_cubit.dart';
import 'package:shop_app/shared/cubits/app_states.dart';

class TempHome extends StatelessWidget {
  TempHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        AppCubit cubit = AppCubit.get(context);
        return myScaffold(context, cubit);
      },
    );
  }

  Scaffold myScaffold(BuildContext context, AppCubit cubit) => Scaffold(
        appBar: AppBar(
          title: const Text('title'),
        ),
        body: const Center(
          child: Text('New App !'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            cubit.changeIsDark();
          },
          child: const Icon(Icons.dark_mode),
        ),
      );
}

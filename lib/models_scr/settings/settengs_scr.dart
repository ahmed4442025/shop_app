import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_fields.dart';
import 'package:shop_app/models_scr/compon_priv.dart';
import 'package:shop_app/shared/cubits/cubit_login/login_cubit.dart';
import 'package:shop_app/shared/cubits/cubit_login/login_states.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubits/main_cubit/app_states.dart';
import 'package:shop_app/shared/other/components.dart';

class SettingsScr extends StatelessWidget {
  SettingsScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        myContext = context;
        cubit = AppCubit.get(context);
        cubitLogin = LoginCubit.get(context);
        comp = ComponPrivt(cubit);
        states = state;
        fillFields();
        return myScaffold();
      },
    );
  }

  //vars
  late BuildContext myContext;
  late AppCubit cubit;
  late LoginCubit cubitLogin;
  late ComponPrivt comp;
  late LoginStates states;

  // Text field
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();

  Scaffold myScaffold() => Scaffold(
      appBar: AppBar(
        title: const Text('SettingsScr'),
      ),
      body: comp.showLoading(
        cubit.profile != null,
        Center(child: mainContainer()),
      ));

  Widget mainContainer() => Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (states is LoginLoadingUpdateUserState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                Components.simpleTextField(
                    controler: name,
                    lableTxt: 'name',
                    prefixIcon: Icons.person),
                const SizedBox(
                  height: 20,
                ),
                Components.simpleTextField(
                    controler: email,
                    lableTxt: 'email',
                    prefixIcon: Icons.email),
                const SizedBox(
                  height: 20,
                ),
                Components.simpleTextField(
                    controler: phone,
                    lableTxt: 'phone',
                    prefixIcon: Icons.phone),
                const SizedBox(
                  height: 20,
                ),
                Components.simpleTextField(
                    controler: pass,
                    lableTxt: 'password',
                    prefixIcon: Icons.lock,
                    password: true),
                const SizedBox(
                  height: 20,
                ),
                updateButtom(),
                logOut(),
              ],
            ),
          ),
        ),
      );

  Widget logOut() => TextButton(
        onPressed: () => cubitLogin.logOut(myContext),
        child: const Text('LOG OUT'),
      );

  Widget updateButtom() => Components.simpleButton(
      onpressed: () => cubitLogin.updateUser(RegisterFields(name.text,
          email.text, pass.text == '' ? null : pass.text, phone.text, null)),
      txt: 'update');

  void fillFields() {
    if (cubit.profile != null) {
      email.text = cubit.profile!.data!.email ?? '';
      name.text = cubit.profile!.data!.name ?? '';
      phone.text = cubit.profile!.data!.phone ?? '';
    }
  }
}

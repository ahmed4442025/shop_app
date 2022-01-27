import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models_scr/login/cubit/login_cubit.dart';
import 'package:shop_app/models_scr/login/cubit/login_states.dart';
import 'package:shop_app/shared/network/strings/test_values.dart';
import 'package:shop_app/shared/other/components.dart';

class LoginScr extends StatelessWidget {
  LoginScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          loginStates(state);
        },
        builder: (BuildContext context, state) {
          cont = context;
          LoginCubit cubit = LoginCubit.get(context);
          return myScaffold(context, cubit, state);
        },
      ),
    );
  }

  // vars
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool izPassdShow = false;
  IconData passIcon = Icons.star;
  var formKey = GlobalKey<FormState>();
  late BuildContext cont ;

  Scaffold myScaffold(BuildContext context, LoginCubit cubit, state) =>
      Scaffold(
          appBar: AppBar(
              // title: const Text('title'),
              ),
          body: Center(
            child: myBody(context, cubit, state),
          ));

  Widget myBody(BuildContext context, LoginCubit cubit, state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'login now to browse our hot offers',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Components.simpleTextField(
                    controler: email, prefixIcon: Icons.email_outlined),
                const SizedBox(
                  height: 20,
                ),
                Components.simpleTextField(
                    controler: password,
                    prefixIcon: Icons.lock,
                    password: cubit.izPass.izPass,
                    passwordIcon: cubit.izPass.icon,
                    onPasswordIconPressed: cubit.changePassShow(),
                    textInputAction: TextInputAction.done,
                    onsubmitted: (s) => login(cubit)),
                const SizedBox(
                  height: 20,
                ),
                buttonLogin(state is LoginLoadingState, cubit),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Don\'t have an account ?  '),
                    TextButton(onPressed: () {}, child: const Text('REGISTER'))
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget buttonLogin(bool izLoding, LoginCubit cubit) {
    return (izLoding)
        ? const Center(child: Text('Loading . . .'))
        : Components.simpleButton(
            onpressed: () => login(cubit), txt: 'login', hight: 50);
  }

  // method

  //login method
  void login(LoginCubit cubit) {
    if (formKey.currentState!.validate()) {
      // cubit.login(TestValues.loginEmail, TestValues.loginPass),
      cubit.login(email.text, password.text);
    }
  }

  void loginStates(LoginStates state) {
    if (state is LoginSuccessState) {
      if (state.loginmodel.status ?? false) {
        Components.showToast(state.loginmodel.message ?? '', clr: Colors.green);
      } else {
        Components.showToast(state.loginmodel.message ?? '', clr: Colors.red);
      }
    }
  }


}

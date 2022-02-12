import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_fields.dart';
import 'package:shop_app/shared/cubits/cubit_login/login_cubit.dart';
import 'package:shop_app/shared/cubits/cubit_login/login_states.dart';
import 'package:shop_app/shared/other/components.dart';

class RegisterScr extends StatelessWidget {
  RegisterScr({Key? key}) : super(key: key);

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
  late BuildContext myContext;
  late LoginCubit cubit;
  var formKey = GlobalKey<FormState>();

  // Text controllers
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();

  Scaffold myScaffold() => Scaffold(
        appBar: AppBar(
          title: const Text('RegisterScr'),
        ),
        body: Center(child: mainContainer()),
      );

  Widget mainContainer() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Components.simpleText('REGISTER', size: 30, bold: true),
                const SizedBox(height: 20),
                Components.simpleText('register now to browse our hot offers',
                    size: 13, color: Colors.grey[400]),
                const SizedBox(height: 20),
                Components.simpleTextField(
                    controler: name,
                    lableTxt: 'name',
                    prefixIcon: Icons.person),
                const SizedBox(height: 20),
                Components.simpleTextField(
                    controler: email,
                    lableTxt: 'email',
                    prefixIcon: Icons.email),
                const SizedBox(height: 20),
                Components.simpleTextField(
                    controler: pass,
                    lableTxt: 'password',
                    prefixIcon: Icons.lock,
                    password: cubit.izPassRegisterScr.izPass,
                    passwordIcon: cubit.izPassRegisterScr.icon,
                    onPasswordIconPressed: cubit.changePassRegisterShow()),
                const SizedBox(height: 20),
                Components.simpleTextField(
                    controler: phone,
                    lableTxt: 'phone',
                    prefixIcon: Icons.phone),
                const SizedBox(height: 20),
                Components.simpleButton(
                    onpressed: register, hight: 50, borderR: 5, txt: 'register')
              ],
            ),
          ),
        ),
      );

  void register() {
    if (formKey.currentState!.validate()) {
      var user =
          RegisterFields(name.text, email.text, pass.text, phone.text, null);
      cubit.registerNew(user, myContext, openScr:true);
    } else {}
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Components {
  // simpleTextField
  static Widget simpleTextField(
          {required TextEditingController controler,
          Function()? onPasswordIconPressed,
          Function()? ontap,
          Function(String value)? onsubmitted,
          bool password = false,
          IconData? passwordIcon,
          String lableTxt = 'text',
          TextInputType? keyBordType,
          String validatorMsg = "This field can't be empty",
          IconData? prefixIcon,
          TextInputAction textInputAction = TextInputAction.next,
          bool readOnly = false}) =>
      TextFormField(
        textInputAction: textInputAction,
        controller: controler,
        onTap: ontap,
        onFieldSubmitted: onsubmitted,
        readOnly: readOnly,
        obscureText: password,
        enableSuggestions: !password,
        autocorrect: !password,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: password ? 'password' : lableTxt,
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
          suffixIcon: IconButton(
            icon: Icon(passwordIcon),
            onPressed: onPasswordIconPressed,
          ),
        ),
        keyboardType: password ? TextInputType.visiblePassword : keyBordType,
        validator: (value) {
          if (value!.isEmpty) {
            return validatorMsg;
          }
        },
      );

  // simple Button
  static Widget simpleButton(
          {required Function() onpressed,
          String txt = 'Log in',
          bool upercase = true,
          double hight = 40,
          Color clr = Colors.blue,
          double borderR = 10,
          double w = double.infinity}) =>
      Container(
        width: w,
        height: hight,
        child: MaterialButton(
          onPressed: onpressed,
          child: Text(
            upercase ? txt.toUpperCase() : txt,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderR),
          color: clr,
        ),
      );

  // simple Text
  static simpleText(txt,{ double size = 20, bool bold = false, Color? color}) =>
      Text(
        txt,
        style: TextStyle(
            fontSize: size, fontWeight: bold ? FontWeight.bold : null, color: color),
      );

  static SizedBox box({double h = 20, double w = 20}) => SizedBox(
        height: h,
        width: w,
      );

  static void showToast(String txt,{Color clr = Colors.grey}){
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: clr,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static Widget loading() => Components.simpleText('loading', size: 50);
}

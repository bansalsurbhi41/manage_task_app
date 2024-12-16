import 'package:flutter/material.dart';

import '../../utilities/colors.dart';
import '../../utilities/text_style.dart';

class PasswordTextField extends StatelessWidget {
  PasswordTextField({super.key});

  late final passwordController = TextEditingController();
  // final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintStyle: MTTextStyle.HintText15,
          // border: InputBorder.,
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye, color: /*authController.shouldHidePassword.value? UIColors.coal :*/ UIColors.coal20),
            onPressed: () {
              // authController.changePassShowStatus();
            },

          )),
      controller: passwordController,
      // onChanged: cubit.onPasswordChanged,
      obscureText: true,
      obscuringCharacter: '*',
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      enabled: true,
      style: MTTextStyle.formFieldStyle,
    );
  }
}

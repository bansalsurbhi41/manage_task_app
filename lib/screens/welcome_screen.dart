import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_project/screens/widgets/common_button.dart';

import '../route_config.dart';
import '../utilities/colors.dart';
import '../utilities/string_const.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: screenHeight *0.15,),
          const Text(StringConst.kWelcomeTodo,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height:screenHeight * 0.02,),
          const Text(StringConst.kPleaseLoginOrCreateAccount,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonButton(
                  buttonText:StringConst.kLoginCaps,
                  buttonColor: UIColors.purple,
                  buttonOnTap: () {
                    context.push(MyAppRoute.loginScreen);
                  },
                ),
                const SizedBox(height: 20,),
                CommonButton(
                  buttonText:StringConst.kCreateAccount,
                  buttonColor: Colors.black,
                  buttonOnTap: () {
                    context.push(MyAppRoute.registerScreen);
                  },
                ),
                const SizedBox(height: 20,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

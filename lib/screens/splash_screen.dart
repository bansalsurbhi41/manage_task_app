import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../route_config.dart';
import '../utilities/colors.dart';
import '../utilities/string_const.dart';
import '../utilities/text_style.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    checkIsLogIn();
    super.initState();
  }

  checkIsLogIn()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogIn = await prefs.getBool(StringConst.kIsLogIn);
    Future.delayed(const Duration(seconds: 2), () async{
      if(isLogIn != null && isLogIn){
        context.go(MyAppRoute.homeScreen);
      }else{
        context.go(MyAppRoute.welcomeScreen);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: UIColors.coal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/splash_image.svg',
              width: 95,
              height: 80,
            ),
            const SizedBox(height: 20,),
            const Text(StringConst.kUpTodo,
              style: MTTextStyle.splashScreenStyle,)
          ],
        ),
      ),
    );
  }
}

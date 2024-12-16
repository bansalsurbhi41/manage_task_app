import 'package:flutter/material.dart';

import '../../utilities/string_const.dart';

class HomeEmptyScreen extends StatelessWidget {
  const HomeEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/Checklist-rafiki 1.png',
            height: 227,
            width: 227,
          ),
          const Text(
            StringConst.kWhatDoYouWant,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const Text(
            StringConst.kAddYourTask,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

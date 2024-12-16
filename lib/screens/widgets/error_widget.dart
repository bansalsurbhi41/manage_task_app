import 'package:flutter/material.dart';

import '../../utilities/string_const.dart';

class ShowErrorWidget extends StatelessWidget {
  const ShowErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        StringConst.kSomethingWentWrong,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}

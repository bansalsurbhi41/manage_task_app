import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utilities/colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({super.key, this.showLoader = false, required this.buttonText, required this.buttonOnTap, required this.buttonColor, this.buttonImage = ''});

  final bool showLoader;
  final String buttonText;
  final String? buttonImage;
  final Color buttonColor;
  final Function() buttonOnTap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: buttonOnTap,
      child: Container(
        height: 48,
        width: screenWidth,
        decoration: BoxDecoration(
          border: Border.all(width: 2,color: UIColors.purple,),
          color: buttonColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (buttonImage ?? '').isNotEmpty ? Row(
                children: [
                  Image.asset(buttonImage ?? ''),
                  const SizedBox(width: 10,)
                ],
              ) : const SizedBox(),
              showLoader ? const Center(
                child: CircularProgressIndicator(color: UIColors.neutralBlack,),
              ): Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

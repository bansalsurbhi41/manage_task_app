import 'package:flutter/material.dart';

import '../../utilities/colors.dart';
import '../../utilities/string_const.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key, required this.descriptionController});

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          StringConst.kDescription,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        /// Description TextField
        TextField(
          controller: descriptionController,
          decoration:  InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: UIColors.greyBorder, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: UIColors.greyBorder, width: 1),
            ),
            fillColor: UIColors.TextFieldColor,
            filled: true,
            hintText: StringConst.kTaskDescription,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: UIColors.hintColor,
            ),
            // fillColor: ,
          ),

          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          keyboardType: TextInputType.emailAddress,
          minLines: 1,
          maxLines: 3,
          maxLength: 5000,
          cursorColor: UIColors.purple,
        ),
      ],
    );
  }
}

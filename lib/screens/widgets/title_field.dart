import 'package:flutter/material.dart';

import '../../utilities/colors.dart';
import '../../utilities/string_const.dart';

class TitleField extends StatelessWidget {
  const TitleField({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          StringConst.kTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        /// Title TextField
        TextField(
          controller: titleController,
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
            hintText: StringConst.kTaskTitle,
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
          maxLines: 1,
          cursorColor: UIColors.purple,
        ),
      ],
    );
  }
}

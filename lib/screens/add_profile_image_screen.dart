import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_project/bloc/auth/auth_bloc.dart';

import '../utilities/colors.dart';
import '../utilities/image_const.dart';
import '../utilities/string_const.dart';

class AddProfileImageScreen extends StatefulWidget {
  const AddProfileImageScreen({super.key});

  @override
  State<AddProfileImageScreen> createState() => _AddProfileImageScreenState();
}

class _AddProfileImageScreenState extends State<AddProfileImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.coal,
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height:  200,
              width:  200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: UIColors.purple,
                  width: 4,
                ),
              ),
              child: CircleAvatar(
                  backgroundColor: UIColors.hintColor,
                  radius: 55,
                  child: Image.asset(ImageConst.iProfilePlaceholder184, fit: BoxFit.fitHeight,height: 60,)),
            ),
            Positioned(
              top: 150,
              child: PopupMenuButton(
                padding: const EdgeInsets.all(0),
                enabled: true,
                color: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                position: PopupMenuPosition.under,
                offset: const Offset(0, 10),
                constraints: const BoxConstraints(minWidth: 143),
                icon: Container(
                    padding: const EdgeInsets.all(3),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      ImageConst.iCamera,
                      width: 24,
                      height: 24,
                    )),
                onSelected: (value) => context.read<AuthBloc>().add(SelectUserAvatarEvent(source: value)),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    padding: const EdgeInsets.fromLTRB(12, 2, 8, 6),
                    height: 24,
                    value: ImageSource.camera,
                    child: Row(
                      children: [
                        Image.asset(
                          ImageConst.iCamera,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8,),
                        const Text(
                          StringConst.kCamera,
                          style: TextStyle(
                            fontSize: 12,
                            color: UIColors.neutralBlack,
                            height: 1.3,
                            fontVariations: [
                              FontVariation('wght', 600),
                              FontVariation('wdth', 100),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
                    height: 24,
                    value: ImageSource.gallery,
                    child: Row(
                      children: [
                        Image.asset(
                          ImageConst.iGallery,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8,),
                        const Text(
                          StringConst.kGallery,
                          style: TextStyle(
                            fontSize: 12,
                            color: UIColors.neutralBlack,
                            height: 1.3,
                            fontVariations: [
                              FontVariation('wght', 600),
                              FontVariation('wdth', 100),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

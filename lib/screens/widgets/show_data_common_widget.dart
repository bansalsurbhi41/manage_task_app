
import 'package:flutter/material.dart';
import 'package:learning_project/utilities/colors.dart';



class ShowDataWidget extends StatelessWidget {
  const ShowDataWidget({super.key,this.icon, this.dataIcon, this.image, required this.type, required this.data});

  final Icon? icon;
  final Widget? image;
  final Icon? dataIcon;
  final String type;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
             mainAxisSize: MainAxisSize.min,
              children: [
                if(icon != null)
                  icon as Widget,
                if(image != null)
                  image as Widget,
                const SizedBox(width: 8,),
                Text(
                  type,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: UIColors.tileColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              child: Row(
                children: [
                  if(dataIcon != null)
                    dataIcon as Widget,
                  if(dataIcon != null)
                    const SizedBox(width: 5,),
                  Text(
                    data,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

          ],
        )
      ],
    );
  }
}

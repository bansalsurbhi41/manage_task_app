import 'package:flutter/material.dart';

import '../../src/model/category_model.dart';
import '../../utilities/colors.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({super.key, required this.onSelect});

  final Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Choose Category',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width,
            color: UIColors.greyBorder,
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 350,
            width: 600,
            child: GridView.builder(
              itemCount: category.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 22,
                // crossAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onSelect(category[index].id);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: category[index].color,
                        ),

                        child: Center(
                          child: category[index].icon,
                        ),
                      ),
                      Text( category[index].name,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                );
              },),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                  ),),
              ),

            ],
          )
        ],
      ),
    );
  }
}

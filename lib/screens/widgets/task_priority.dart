import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utilities/colors.dart';

class TaskPriority extends StatelessWidget {
  TaskPriority({super.key, required this.onSelect});
  final Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Edit Task Priority',
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
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 22,
                // crossAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onSelect((index +1));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: UIColors.tileColor,
                        ),

                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.flag_outlined,color: Colors.white,),
                            Text( (index +1).toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                );
              },),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: const Text('Cancel',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                  ),),
              ),
              /*Container(
                decoration: const BoxDecoration(
                    color: UIColors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(2.0))
                ),

                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: const Text('Edit',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                  ),),
              )*/

            ],
          )
        ],
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/colors.dart';

List<CategoryModel> category = [
  CategoryModel(
    id: 1,
    color: UIColors.lacttus,
    icon: const Icon(Icons.local_grocery_store_outlined, color: Colors.green,),
    name: 'Grocery',
  ),
  CategoryModel(
    id: 2,
    color: UIColors.workRed,
    icon: const Icon(Icons.work_outline_outlined, color: UIColors.darkRed,),
    name: 'Work',
  ),
  CategoryModel(
    id: 3,
    color: UIColors.cleaning,
    icon:  const Icon(Icons.cleaning_services_outlined, color: Colors.blueAccent,),
    name: 'Cleaning',
  ),
  CategoryModel(
    id: 4,
    color: UIColors.sportLightBlue,
    icon:  const Icon(Icons.sports_baseball_outlined, color: Colors.blueAccent,),
    name: 'Sport',
  ),
  CategoryModel(
    id: 5,
    color: UIColors.purple,
    icon:  Icon(Icons.school_outlined, color: Colors.indigo.shade900,),
    name: 'University',
  ),
  CategoryModel(
    id: 6,
    color: UIColors.social,
    icon:  Icon(Icons.functions_outlined, color: Colors.purple.shade900,),
    name: 'Social',
  ),
  CategoryModel(
    id: 7,
    color: UIColors.social,
    icon:  Icon(Icons.music_note_outlined, color: Colors.purple.shade900,),
    name: 'Music',
  ),
  CategoryModel(
    id: 8,
    color:UIColors.lightRed,
    icon:  const Icon(Icons.home_outlined, color: UIColors.darkRed,),
    name: 'Home',
  ),
  CategoryModel(
    id: 9,
    color: Colors.lightGreen,
    icon:  Icon(Icons.favorite_border, color: Colors.teal.shade900,),
    name: 'Health',
  ),
  CategoryModel(
    id: 10,
    color: Colors.lightBlueAccent,
    icon:  Icon(Icons.video_call_outlined, color: Colors.cyan.shade900,),
    name: 'Movie',
  ),
];

class CategoryModel{
  CategoryModel({required this.id, required this.color, required this.icon, required this.name });

  final int id;
  final Color color;
  final Icon icon;
  final String name;
}



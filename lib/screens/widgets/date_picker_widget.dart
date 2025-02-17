
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task_manage/task_manage_bloc.dart';



class DatePickerWidget extends StatelessWidget {
  DatePickerWidget({super.key,});




  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          displayDatePicker(context);
        },
        child: const Icon(
          Icons.calendar_month,
          color: Colors.white,
        ));
  }

  static Future<void>  displayDatePicker(BuildContext context) async {
    DateTime selected = DateTime.now();
    DateTime initial = DateTime.now();
    DateTime last = DateTime(2027);

    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
    );

    if (date != null) {
      print("----Date======${date.toLocal().toString().split(" ")[0]}");
      context.read<TaskManageBloc>().add(SetDateEvent(date: date.toLocal().toString().split(" ")[0]));
    }
  }
}

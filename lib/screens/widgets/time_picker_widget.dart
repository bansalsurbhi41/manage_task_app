
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task_manage/task_manage_bloc.dart';



class TimePickerWidget extends StatelessWidget {
  TimePickerWidget({super.key, /*required this.controller*/});

  // final TaskManagement controller;


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          displayTimePicker(context);
        },
        child: const Icon(
          Icons.timer_outlined,
          color: Colors.white,
        ));
  }

  static Future<void> displayTimePicker(BuildContext context) async {
    TimeOfDay timeOfDay = TimeOfDay.now();

    var time = await showTimePicker(
        context: context,
        initialTime: timeOfDay);

    if (time != null) {
      print("----======${time.hourOfPeriod}:${time.hourOfPeriod} ${time.period.name}");
      context.read<TaskManageBloc>().add(SetTimeEvent(time: '${time.hourOfPeriod}:${time.hourOfPeriod} ${time.period.name}'));
    }
  }
}

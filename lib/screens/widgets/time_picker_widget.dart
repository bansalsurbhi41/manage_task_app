
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task_manage/task_manage_bloc.dart';



class TimePickerWidget extends StatelessWidget {
  const TimePickerWidget({super.key, });



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
      debugPrint("----======${time.hourOfPeriod}:${time.hourOfPeriod} ${time.period.name}");
      context.read<TaskManageBloc>().add(SetTimeEvent(time: '${time.hourOfPeriod}:${time.hourOfPeriod} ${time.period.name}'));
    }
  }
}

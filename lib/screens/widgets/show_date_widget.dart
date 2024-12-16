import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_project/screens/widgets/show_data_common_widget.dart';
import 'package:learning_project/utilities/utils.dart';

import '../../bloc/task_manage/task_manage_bloc.dart';
import '../../utilities/string_const.dart';

Widget showDateWidget() {
  return BlocBuilder<TaskManageBloc, TaskManageState>(
    builder: (context, state) {
      return state.task?.date != null ? ShowDataWidget(
          icon: const Icon(Icons.calendar_month, color: Colors.white,),
          type: StringConst.kTaskDate,
          data: Utils.getDayText(state.task?.date ?? '')
      ) : const SizedBox();
    },
  );
}
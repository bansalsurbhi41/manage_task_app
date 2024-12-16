import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_project/screens/widgets/show_data_common_widget.dart';

import '../../bloc/task_manage/task_manage_bloc.dart';

import '../../utilities/string_const.dart';

Widget showPriorityWidget() {
  return BlocBuilder<TaskManageBloc, TaskManageState>(
    builder: (context, state) {
      return state.task?.priority != null ? ShowDataWidget(
          icon:  const Icon(
            Icons.low_priority_outlined,
            color: Colors.white,
          ),
          type: StringConst.kTaskPriority,
          data: state.task!.priority.toString()
      )
          : const SizedBox();
    },
  );
}
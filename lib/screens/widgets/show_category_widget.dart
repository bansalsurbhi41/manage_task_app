import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_project/screens/widgets/show_data_common_widget.dart';
import 'package:learning_project/utilities/utils.dart';

import '../../bloc/task_manage/task_manage_bloc.dart';
import '../../src/model/category_model.dart';
import '../../utilities/image_const.dart';
import '../../utilities/string_const.dart';

Widget showCategoryWidget() {
  return BlocBuilder<TaskManageBloc, TaskManageState>(
    builder: (context, state) {
      return state.task?.categoryId != null ? ShowDataWidget(
         image: SvgPicture.asset(
           ImageConst.iTag,
         ),
          type: StringConst.kTaskCategory,
          data: category.where((element) => element.id == state.task?.categoryId,).first.name,
      )
          : const SizedBox();
    },
  );
}
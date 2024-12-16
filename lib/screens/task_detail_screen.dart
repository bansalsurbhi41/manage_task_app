import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_project/screens/widgets/common_button.dart';
import 'package:learning_project/screens/widgets/error_widget.dart';
import 'package:learning_project/screens/widgets/loading_widget.dart';
import 'package:learning_project/screens/widgets/show_data_common_widget.dart';
import 'package:learning_project/src/model/task_model.dart';
import 'package:learning_project/utilities/colors.dart';
import 'package:learning_project/utilities/state_status.dart';

import '../bloc/task_manage/task_manage_bloc.dart';
import '../navigation_args.dart';
import '../route_config.dart';
import '../src/model/category_model.dart';
import '../utilities/image_const.dart';
import '../utilities/string_const.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final int taskId;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: SvgPicture.asset(
            ImageConst.iClose,
            width: 15,
            height: 15,
          ),
        ),
        actions: [
          BlocBuilder<TaskManageBloc, TaskManageState>(
            builder: (context, state) {
              return GestureDetector(
                  onTap: () async {
                    if (state.fetchTaskWithIdStatus is StateLoaded) {
                      bool? result = await context.push<bool>(MyAppRoute.editTaskScreen,
                          extra: TaskDetailScreenArgs(task: state.taskData ?? Task()));
                      if (result ?? false) {
                        context
                            .read<TaskManageBloc>()
                            .add(FetchTaskWithIdEvent(taskId: widget.taskId));
                      }
                    }
                  },
                  child: const Icon(
                    Icons.mode_edit_rounded,
                    color: Colors.white,
                    size: 24,
                  ));
            },
          ),
          const SizedBox(
            width: 25,
          )
        ],
      ),
      body: BlocListener<TaskManageBloc, TaskManageState>(
        listener: (context, state) {
          if (state.deleteTaskStatus is StateLoaded) {
            context.pop(true);
            state.deleteTaskStatus = const StateNotLoaded();
          }
          if (state.deleteTaskStatus is StateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(StringConst.kSomethingWentWrong),
              duration: Duration(seconds: 1),
            ));
            state.deleteTaskStatus = const StateNotLoaded();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocBuilder<TaskManageBloc, TaskManageState>(
            builder: (context, state) {
              final taskData = state.taskData;
              return state.fetchTaskWithIdStatus is StateLoading
                  ? const LoadingWidget()
                  : state.fetchTaskWithIdStatus is StateFailed
                      ? const ShowErrorWidget()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                taskData?.title ?? '',
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              taskData?.description ?? '',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 38,
                            ),

                            /// Date
                            ShowDataWidget(
                                icon: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                type: StringConst.kTaskDate,
                                data: taskData?.date ?? ''),
                            const SizedBox(
                              height: 33,
                            ),

                            /// time
                            ShowDataWidget(
                                icon: const Icon(
                                  Icons.timer_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                type: StringConst.kTaskTime,
                                data: 'At ${taskData?.time ?? ''}'),
                            const SizedBox(
                              height: 33,
                            ),

                            ///Category
                            ShowDataWidget(
                              image: SvgPicture.asset(
                                ImageConst.iTag,
                                height: 24,
                                width: 24,
                              ),
                              type: StringConst.kTaskCategory,
                              dataIcon: taskData?.categoryId == null ? Icon(Icons.note_alt_outlined): category
                                  .singleWhere(
                                    (element) => element.id == taskData?.categoryId,
                                  )
                                  .icon,
                              data: taskData?.categoryId == null ? '': category
                                  .singleWhere(
                                    (element) => element.id == taskData?.categoryId,
                                  )
                                  .name,
                            ),
                            const SizedBox(
                              height: 33,
                            ),

                            /// Priority
                            ShowDataWidget(
                                icon: const Icon(
                                  Icons.low_priority_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                type: StringConst.kTaskPriority,
                                dataIcon: const Icon(
                                  Icons.flag_outlined,
                                  color: Colors.white,
                                ),
                                data: (taskData?.priority).toString()),
                            const SizedBox(
                              height: 38,
                            ),

                            /// Delete
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<TaskManageBloc>()
                                    .add(DeleteTaskEvent(taskId: taskData?.id ?? 0));
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.delete_sweep,
                                    size: 24,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    StringConst.kDeleteTask,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
            },
          ),
        ),
      ),
    );
  }
}

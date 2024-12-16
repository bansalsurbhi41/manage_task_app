import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_project/screens/widgets/choose_category.dart';
import 'package:learning_project/screens/widgets/common_button.dart';
import 'package:learning_project/screens/widgets/date_picker_widget.dart';
import 'package:learning_project/screens/widgets/description_field.dart';
import 'package:learning_project/screens/widgets/show_data_common_widget.dart';
import 'package:learning_project/screens/widgets/task_priority.dart';
import 'package:learning_project/screens/widgets/time_picker_widget.dart';
import 'package:learning_project/screens/widgets/title_field.dart';
import 'package:learning_project/src/model/task_model.dart';
import 'package:learning_project/utilities/state_status.dart';

import '../bloc/task_manage/task_manage_bloc.dart';
import '../src/model/category_model.dart';
import '../utilities/colors.dart';
import '../utilities/image_const.dart';
import '../utilities/string_const.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.task});

  final Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.task.title ?? '';
    descriptionController.text = widget.task.description ?? '';
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: SvgPicture.asset(
            ImageConst.iClose,
            width: 15,
            height: 15,
          ),
        ),
        centerTitle: true,
        title: const Text(
          StringConst.kEditTask,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<TaskManageBloc, TaskManageState>(
        listener: (context, state) {
          if (state.editTaskStatus is StateLoaded) {
            context.pop(true);
            state.editTaskStatus = const StateNotLoaded();
          }
          if (state.editTaskStatus is StateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(StringConst.kSomethingWentWrong),
              duration: Duration(seconds: 1),
            ));
            state.editTaskStatus = const StateNotLoaded();
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),

                      /// Title String
                      TitleField(titleController: titleController),
                      const SizedBox(
                        height: 20,
                      ),

                      /// Description String
                      DescriptionField(descriptionController: descriptionController),

                      /// Date
                      InkWell(
                        onTap: () {
                          DatePickerWidget.displayDatePicker(context);
                        },
                        child: BlocBuilder<TaskManageBloc, TaskManageState>(
                          builder: (context, state) {
                            return ShowDataWidget(
                                icon: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                type: StringConst.kTaskDate,
                                data: state.task?.date == null
                                    ? widget.task.date ?? ''
                                    : state.task?.date ?? '');
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 33,
                      ),

                      /// time
                      InkWell(
                        onTap: () {
                          TimePickerWidget.displayTimePicker(context);
                        },
                        child: BlocBuilder<TaskManageBloc, TaskManageState>(
                          builder: (context, state) {
                            return ShowDataWidget(
                                icon: const Icon(
                                  Icons.timer_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                type: StringConst.kTaskTime,
                                data:
                                'At ${state.task?.time == null ? widget.task.time ?? '' : state.task
                                    ?.time ?? ''}');
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 33,
                      ),

                      ///Category
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: UIColors.hintColor,
                                child: ChooseCategory(
                                  onSelect: (value) {
                                    editCategory(id: value);
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: BlocBuilder<TaskManageBloc, TaskManageState>(
                          builder: (context, state) {
                            return ShowDataWidget(
                              image: SvgPicture.asset(
                                ImageConst.iTag,
                                height: 24,
                                width: 24,
                              ),
                              type: StringConst.kTaskCategory,
                              dataIcon: category
                                  .where(
                                    (element) =>
                                element.id ==
                                    (state.task?.categoryId ?? widget.task.categoryId),
                              )
                                  .first
                                  .icon,
                              data: category
                                  .where(
                                    (element) =>
                                element.id ==
                                    (state.task?.categoryId ?? widget.task.categoryId),
                              )
                                  .first
                                  .name,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 33,
                      ),

                      /// Priority
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: UIColors.hintColor,
                                child: TaskPriority(
                                  onSelect: (value) {
                                    editPriority(priority: value);
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: BlocBuilder<TaskManageBloc, TaskManageState>(
                          builder: (context, state) {
                            return ShowDataWidget(
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
                                data: (state.task?.priority ?? widget.task.priority).toString());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30),
                  child: BlocBuilder<TaskManageBloc, TaskManageState>(
                    builder: (context, state) {
                      return CommonButton(
                          buttonText: StringConst.kEditTask,
                          showLoader: state.editTaskStatus is StateLoading,
                          buttonOnTap: () {
                            context.read<TaskManageBloc>().add(EditTaskEvent(
                                taskId: widget.task.id ?? 0,
                                title: widget.task.title != titleController.text.trim()
                                    ? titleController.text.trim()
                                    : null,
                                description:
                                widget.task.description != descriptionController.text.trim()
                                    ? descriptionController.text.trim()
                                    : null));
                          },
                          buttonColor: UIColors.purple);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: ,
    );
  }

  void editCategory({required int id}) {
    context.read<TaskManageBloc>().add(SetCategoryEvent(categoryId: id));
    context.pop();
  }

  void editPriority({required int priority}) {
    context.read<TaskManageBloc>().add(SetPriorityEvent(priority: priority));
    context.pop();
  }
}

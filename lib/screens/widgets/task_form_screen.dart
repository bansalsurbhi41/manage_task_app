

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_project/bloc/task_manage/task_manage_bloc.dart';
import 'package:learning_project/screens/widgets/show_category_widget.dart';
import 'package:learning_project/screens/widgets/show_date_widget.dart';
import 'package:learning_project/screens/widgets/show_task_priority_widget.dart';
import 'package:learning_project/screens/widgets/show_time_widget.dart';

import 'package:learning_project/screens/widgets/task_priority.dart';
import 'package:learning_project/screens/widgets/time_picker_widget.dart';
import 'package:learning_project/screens/widgets/title_field.dart';
import 'package:learning_project/utilities/state_status.dart';

import '../../utilities/colors.dart';
import 'package:flutter_svg/svg.dart';

import '../../utilities/image_const.dart';
import '../../utilities/string_const.dart';
import 'choose_category.dart';
import 'date_picker_widget.dart';
import 'description_field.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key, required this.ctx});

  final BuildContext ctx;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {


  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final TaskManageBloc taskManageBloc = TaskManageBloc();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  BlocProvider<TaskManageBloc>(
  create: (context) => taskManageBloc,
  child: GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Padding(
        padding:  EdgeInsets.only(left: 15, top: 0, right: 15, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  StringConst.kAddTask,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              /// Title String
              TitleField(titleController: titleController),
              const SizedBox(height: 20,),
              /// Description String
              DescriptionField(descriptionController: descriptionController),
              /// Date
              showDateWidget(),
              /// time
              showTimeWidget(),
              ///Category
              showCategoryWidget(),
              /// Priority
              showPriorityWidget(),
              const SizedBox(height: 30,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Date picker
                      DatePickerWidget(),
                      const SizedBox(width: 20,),
                      /// time picker
                      TimePickerWidget(),
                      const SizedBox(width: 20,),
                      /// ChooseCategory
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
                                child:  ChooseCategory(onSelect: (value) {
                                  taskManageBloc.add(SetCategoryEvent(categoryId: value));
                                  Navigator.of(context).pop();
                                },),
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          ImageConst.iTag,
                        ),
                      ),
                      const SizedBox(width: 20,),
                      /// TaskPriority
                      InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: UIColors.hintColor, // Customize the dialog background color
                                  child:  TaskPriority(
                                    onSelect: (value) {
                                      taskManageBloc.add(SetPriorityEvent(priority: value));
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.low_priority_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                    BlocConsumer<TaskManageBloc, TaskManageState>(
                      listener: (context, state) {
                        if(state.addTaskStatus is StateLoaded){
                          context.pop();
                          state.addTaskStatus = const StateNotLoaded();
                        }

                        if(state.addTaskStatus is StateFailed){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(StringConst.kSomethingWentWrong),
                            duration: Duration(seconds: 1),
                          ));
                          state.addTaskStatus = const StateNotLoaded();
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                            onTap: () async {
                              if (state.task?.date != null &&
                                  state.task?.time != null &&
                                  state.task?.categoryId != null &&
                                  state.task?.priority != null &&
                                  titleController.text.isNotEmpty &&
                                  descriptionController.text.isNotEmpty) {
                                context.read<TaskManageBloc>().add(
                                    AddTaskEvent(
                                      title: titleController.text.trim(),
                                        description:  descriptionController.text.trim(),
                                        ));
                                titleController.clear();
                                descriptionController.clear();
                              }
                            },
                            child: state.addTaskStatus is StateLoading
                            ? const CircularProgressIndicator(
                              color: UIColors.purple,
                            )
                              :const Icon(
                              Icons.send_outlined,
                              color: UIColors.purple,
                            ));
                      },
                    ),

                ],
              ),
              const SizedBox(height: 50,),

            ],
          ),
        ),
      ),
  ),
);
  }






}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_project/main.dart';
import 'package:learning_project/route_config.dart';
import 'package:learning_project/screens/task_detail_screen.dart';
import 'package:learning_project/screens/welcome_screen.dart';
import 'package:learning_project/screens/widgets/error_widget.dart';
import 'package:learning_project/screens/widgets/home_empty_screen.dart';
import 'package:learning_project/screens/widgets/loading_widget.dart';
import 'package:learning_project/screens/widgets/task_form_screen.dart';
import 'package:learning_project/utilities/state_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:learning_project/utilities/utils.dart';

import '../bloc/task_manage/task_manage_bloc.dart';
import '../navigation_args.dart';
import '../src/model/category_model.dart';
import '../utilities/colors.dart';
import '../utilities/string_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void initState() {
    context.read<TaskManageBloc>().add(const FetchTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await supabase.auth.signOut().whenComplete(() async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool(StringConst.kIsLogIn, false);
              await prefs.setString(StringConst.kAuthId, '');
              context.go(MyAppRoute.welcomeScreen);
            });
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        title: const Text(
          StringConst.kTaskTracker,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<TaskManageBloc, TaskManageState>(
        builder: (context, state) {
          return state.fetchTaskStatus is StateLoading
          ? const LoadingWidget()
          : state.fetchTaskStatus is StateFailed
          ? const ShowErrorWidget()
          :  state.taskList.isEmpty
              ? const HomeEmptyScreen()
              : ListView.builder(
            itemCount: state.taskList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final task = state.taskList[index];
              final CategoryModel categoryModel = category.where((element) => element.id == task.categoryId,).first;
              final date = Utils.getDayText(task.date ?? '');
              final time = Utils.formatTime(task.time ?? '');
              return GestureDetector(
                onTap: () async{
                  bool? result = await context.push<bool>(MyAppRoute.taskDetailScreen, extra: TaskDetailScreenArgs(task: state.taskList[index]));
                  if(result ?? false){
                    context.read<TaskManageBloc>().add(const FetchTaskEvent());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                        child: Container(
                          color: UIColors.tileColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: UIColors.purple,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  child:  Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.flag_outlined,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        // SizedBox(width: ,),
                                        Text(
                                          task.priority.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 130,
                                            child: Text(
                                              task.title ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                           SizedBox(
                                            width: 155,
                                            child: Text(
                                              '$date At $time',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(Radius.circular(4.0)),
                                            child: Container(
                                              color: categoryModel.color,
                                              child:  Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 2),
                                                child: Row(
                                                  children: [
                                                    categoryModel.icon,
                                                    Text(
                                                      categoryModel.name,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.black,
            useSafeArea: true,
            showDragHandle: true,
            barrierColor: UIColors.tileColor.withOpacity(0.5),
            enableDrag: true,
            builder: (ctx) {
              return TaskFormScreen(
                ctx: context,
              );
            },
          );
        },
        tooltip: 'Increment',
        backgroundColor: UIColors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

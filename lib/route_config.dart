import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_project/screens/add_profile_image_screen.dart';
import 'package:learning_project/screens/edit_task_screen.dart';
import 'package:learning_project/screens/home_screen.dart';
import 'package:learning_project/screens/login_screen.dart';
import 'package:learning_project/screens/register_screen.dart';
import 'package:learning_project/screens/splash_screen.dart';
import 'package:learning_project/screens/task_detail_screen.dart';
import 'package:learning_project/screens/welcome_screen.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/task_manage/task_manage_bloc.dart';
import 'navigation_args.dart';

class MyAppRoute {
  MyAppRoute();

  static const initialRoute = '/';
  static const homeScreen = '/homeScreen';
  static const welcomeScreen = '/welcomeScreen';
  static const loginScreen = '/loginScreen';
  static const registerScreen = '/registerScreen';
  static const taskDetailScreen = '/taskDetailScreen';
  static const editTaskScreen = '/editTaskScreen';
  static const addProfileImageScreen = '/addProfileImageScreen';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> navigatorShellKey = GlobalKey<NavigatorState>();

  GoRouter goRoute = GoRouter(
      initialLocation: initialRoute,
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: initialRoute,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: homeScreen,
          builder: (context, state) => BlocProvider<TaskManageBloc>(
            create: (context) => TaskManageBloc(),
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: welcomeScreen,
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: addProfileImageScreen,
          builder: (context, state) => BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
            child: const AddProfileImageScreen(),
          ),
        ),
        GoRoute(
          path: loginScreen,
          builder: (context, state) => BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: registerScreen,
          builder: (context, state) => BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
            child: const RegisterScreen(),
          ),
        ),
        GoRoute(
          path: taskDetailScreen,
          builder: (context, state) {
            final TaskDetailScreenArgs args = state.extra as TaskDetailScreenArgs;
            return MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(
                  create: (context) => AuthBloc(),
                ),
                BlocProvider<TaskManageBloc>(
                  create: (context) =>
                      TaskManageBloc()..add(FetchTaskWithIdEvent(taskId: args.task.id ?? 0)),
                ),
              ],
              child: TaskDetailScreen(
                taskId: args.task.id ?? 0,
              ),
            );
          },
        ),
        GoRoute(
          path: editTaskScreen,
          builder: (context, state) {
            final TaskDetailScreenArgs args = state.extra as TaskDetailScreenArgs;
            return BlocProvider<TaskManageBloc>(
              create: (context) => TaskManageBloc(),
              child: EditTaskScreen(
                task: args.task,
              ),
            );
          },
        ),
      ]);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_project/screens/widgets/common_button.dart';
import 'package:learning_project/utilities/state_status.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../bloc/auth/auth_bloc.dart' as auth;
import '../bloc/auth/auth_bloc.dart';
import '../route_config.dart';
import '../utilities/colors.dart';
import '../utilities/string_const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SupabaseClient supabase = Supabase.instance.client;

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<auth.AuthBloc, auth.AuthState>(
        listener: (context, state) {
          if (state.signInStatus is StateLoaded || state.googleSignInStatus is StateLoaded) {
            context.go(MyAppRoute.homeScreen);
            state.signInStatus = const StateNotLoaded();
            state.googleSignInStatus = const StateNotLoaded();
          }

          if (state.signInStatus is StateFailed || state.googleSignInStatus is StateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(StringConst.kSomethingWentWrong),
              duration: Duration(seconds: 1),
            ));
            state.signInStatus = const StateNotLoaded();
            state.googleSignInStatus = const StateNotLoaded();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.08,
                  ),
                  const Text(
                    StringConst.kLogin,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.07,
                  ),
                  const Text(
                    StringConst.kEmail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  //
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(color: UIColors.greyBorder, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(color: UIColors.greyBorder, width: 1),
                      ),
                      fillColor: UIColors.TextFieldColor,
                      filled: true,
                      hintText: StringConst.kEnterYourEmail,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: UIColors.hintColor,
                      ),
                      // fillColor: ,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please enter an email address';
                      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value ?? '')) {
                        return 'Please enter a valid email address';
                      }
                      return null; // Return null if the input is valid
                    },
                    cursorColor: UIColors.purple,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    StringConst.kPassword,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(color: UIColors.greyBorder, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(color: UIColors.greyBorder, width: 1),
                      ),
                      fillColor: UIColors.TextFieldColor,
                      filled: true,
                      hintText: StringConst.kPassword,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: UIColors.hintColor,
                      ),
                      // fillColor: ,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: (value) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!,@,#,\$,%,&,*]).{8,}$');
                      if ((value ?? '').isEmpty) {
                        return 'Please enter password';
                      } else if ((value ?? '').length <= 8) {
                        return 'Password length should be 8 or more';
                      } else if (!regex.hasMatch(value ?? '')) {
                        return 'Special character + capital latter + numbers required';
                      }
                      return null;
                    },
                    cursorColor: UIColors.purple,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  BlocBuilder<auth.AuthBloc, auth.AuthState>(
                    builder: (context, state) {
                      return CommonButton(
                        showLoader: state.signInStatus is StateLoading,
                        buttonText: StringConst.kLogin,
                        buttonColor: UIColors.purple,
                        buttonOnTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<auth.AuthBloc>().add(SignWithEmailPasswordEvent(email: nameController.text.trim(),password: passwordController.text.trim()));
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 2,
                        width: screenWidth / 2 - 20,
                        color: UIColors.greyBorder,
                      ),
                      const Text(
                        StringConst.kOr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: screenWidth / 2 - 20,
                        color: UIColors.greyBorder,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  BlocBuilder<auth.AuthBloc, auth.AuthState>(
                    builder: (context, state) {
                      return CommonButton(
                        showLoader: state.googleSignInStatus is StateLoading,
                        buttonText: StringConst.kLoginGoogle,
                        buttonImage: 'assets/images/google.png',
                        buttonColor: Colors.black,
                        buttonOnTap: () {
                          context.read<auth.AuthBloc>().add(const auth.SignInWithGoogleEvent());

                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              StringConst.kNoAccountRegister,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.87),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}

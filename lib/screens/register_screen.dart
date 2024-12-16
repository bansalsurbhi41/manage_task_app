import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_project/screens/widgets/common_button.dart';
import 'package:learning_project/utilities/state_status.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../bloc/auth/auth_bloc.dart' as authBloc;
import '../bloc/auth/auth_bloc.dart';
import '../route_config.dart';
import '../utilities/colors.dart';
import '../utilities/string_const.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<authBloc.AuthBloc, authBloc.AuthState>(
        listener: (context, state) {
          if (state.signUpStatus is StateLoaded) {
            context.pushReplacement(MyAppRoute.loginScreen);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
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
                    StringConst.kRegister,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        StringConst.kFirstName,
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
                        controller: firstNameController,
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
                          hintText: StringConst.kEnterYourFirstName,
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
                          }
                          return null; // Return null if the input is valid
                        },
                        cursorColor: UIColors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        StringConst.kLastName,
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
                        controller: lastNameController,
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
                          hintText: StringConst.kEnterYourLastName,
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
                          }
                          return null; // Return null if the input is valid
                        },
                        cursorColor: UIColors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
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
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    StringConst.kConfirmPassword,
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
                    controller: confirmPassController,
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
                      hintText: StringConst.kConfirmPassword,
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
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<authBloc.AuthBloc, authBloc.AuthState>(
                    builder: (context, state) {
                      return CommonButton(
                        showLoader: state.signUpStatus is StateLoading,
                        buttonText: StringConst.kRegister,
                        buttonColor: UIColors.purple,
                        buttonOnTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (passwordController.text.trim() ==
                                confirmPassController.text.trim()) {
                              context.read<authBloc.AuthBloc>().add(SignUpWithPasswordEvent(
                                  email: nameController.text.trim(),
                                  password: passwordController.text.trim(),
                                firstName: firstNameController.text.trim(),
                                lastName:  lastNameController.text.trim()
                              ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Passwords are not matched'),
                                duration: Duration(seconds: 1),
                              ));
                            }
                          }
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
              StringConst.kAlreadyAccount,
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

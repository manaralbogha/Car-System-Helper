import 'package:car/layout/home_layout_car_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_car_owner/home_layout_car_owner.dart';
import 'package:car/layout/home_layout_workshop_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_workshop_owner/home_layout_workshop_owner.dart';
import 'package:car/modules/login/cubit/cubit.dart';
import 'package:car/modules/login/cubit/states.dart';
import 'package:car/modules/rigister/register_screen.dart';

import 'package:car/shared/components/components.dart';
import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          bool isCarOwner(type1) {
            if (type1 == 'car owner') {
              return true;
            }
            return false;
          }

          //Fluttertoast.showToast(msg: "mmmmmmm1");
          if (state is LoginSuccessState) {
            // Fluttertoast.showToast(msg: "mmmmmmm0");

            if (state.loginModel.status) {
              if (isCarOwner(state.loginModel.data.type) == true) {
                // print(state.loginModel.data.type);
                CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data.token);

                print(CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data.token));

                CacheHelper.saveData(
                        key: 'type', value: state.loginModel.data.type)
                    .then((value) {
                  CarOwnerCubit.get(context)
                      .getCarInformation(token: state.loginModel.data.token);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeLayoutCarOwner(),
                      ),
                      (Route<dynamic> rout) => false);
                });
              } else {
                CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data.token);

                print(CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data.token));
                CacheHelper.saveData(
                        key: 'type', value: state.loginModel.data.type)
                    .then((value) {
                  WorkshopOwnerCubit.get(context)
                      .getData(token: state.loginModel.data.token);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeLayoutWorkshopOwner(),
                      ),
                      (Route<dynamic> rout) => false);
                });
              }
              print(state.loginModel.data.message);
            } else {
              print(state.loginModel.data.message);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            //backgroundColor: Colors.lightBlueAccent.shade100,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          defaultFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "email must not be empty";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return 'Please a valid Email';
                              }
                              return null;
                            },
                            prefixIcon: Icons.email_outlined,
                            labelText: "Email Address",
                            controller: emailController,
                            type: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password must not be empty";
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: isPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            labelText: "Password",
                            controller: passwordController,
                            type: TextInputType.emailAddress,
                            obscureText: isPassword,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  // print(emailController.text);
                                  //print(passwordController.text);
                                }
                              },
                              text: "login",
                            ),
                            fallback: (context) => CircularProgressIndicator(
                              color: Colors.indigo,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don\'t have an account?"),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Register_screen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Register Now",
                                    style: TextStyle(color: Colors.indigo),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

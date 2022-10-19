import 'dart:async';

import 'package:car/layout/home_layout_without_login/cubit/cubit.dart';
import 'package:car/layout/home_layout_without_login/cubit/states.dart';
import 'package:car/modules/login/loginscreen.dart';

import 'package:car/modules/rigister/register_screen.dart';
import 'package:car/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class home_layout_without_login extends StatelessWidget {
  const home_layout_without_login({Key? key}) : super(key: key);
//Cubit=CarCubit().get(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarCubit()..getData(),
      child: BlocConsumer<CarCubit, CarStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CarCubit.get(context);
          var list = cubit.home;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Home",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Register_screen()),
                    );
                  },
                  child: Text(
                    "SIGNUP",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogInScreen()),
                    );
                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! GetDataLoadingState,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      defaultContainer(list[index]),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5.0,
                      ),
                  itemCount: list.length),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}

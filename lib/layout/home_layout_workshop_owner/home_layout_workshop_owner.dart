import 'dart:async';

import 'package:car/layout/home_layout_without_login/home_layout_without_login.dart';
import 'package:car/layout/home_layout_workshop_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_workshop_owner/cubit/states.dart';
import 'package:car/modules/rigister/cubit/cubit.dart';
import 'package:car/shared/components/components.dart';
import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayoutWorkshopOwner extends StatefulWidget {
  @override
  _HomeLayoutWorkshopOwnerState createState() =>
      _HomeLayoutWorkshopOwnerState();
}

class _HomeLayoutWorkshopOwnerState extends State<HomeLayoutWorkshopOwner> {
  String token = CacheHelper.getData(key: 'token');

  @override
  Widget build(BuildContext context) {
    Timer? timer;
    timer = Timer.periodic(
      Duration(seconds: 5),
      (Timer t) =>
          WorkshopOwnerCubit.get(context).newRequestWorkshop(token: token),
    );

    return BlocConsumer<WorkshopOwnerCubit, WorkshopOwnerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        WorkshopOwnerCubit cubit = WorkshopOwnerCubit.get(context);

        return Scaffold(
          key: cubit.scaffoldKey,
          appBar: AppBar(
            title: Center(child: Text("WorkShop")),
            actions: [
              TextButton(
                onPressed: () {
                  CacheHelper.deletData(key: 'token');
                  CacheHelper.deletData(key: 'type');
                  print(CacheHelper.getData(key: 'token'));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => home_layout_without_login(),
                      ),
                      (Route<dynamic> rout) => false);
                  timer?.cancel();
                },
                child: Text(
                  "LOGOUT",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
              cubit.getNotification(index);
              /* cubit.getCar(index);*/
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
/* floatingActionButton: FloatingActionButton(
            onPressed: () {
              cubit.scaffoldKey.currentState!
                  .showBottomSheet((context) => Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.indigo,
                      ));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.indigo,
          ),*/

import 'dart:async';

import 'package:car/layout/home_layout_car_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_car_owner/cubit/states.dart';
import 'package:car/layout/home_layout_without_login/home_layout_without_login.dart';
import 'package:car/shared/components/components.dart';
import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeLayoutCarOwner extends StatefulWidget {
  const HomeLayoutCarOwner({Key? key}) : super(key: key);

  @override
  _HomeLayoutCarOwnerState createState() => _HomeLayoutCarOwnerState();
}

class _HomeLayoutCarOwnerState extends State<HomeLayoutCarOwner> {
  @override
  Widget build(BuildContext context) {
    Timer? timer;
    String? token = CacheHelper.getData(key: 'token');
    timer = Timer.periodic(
      Duration(seconds: 5),
      (Timer t) => CarOwnerCubit.get(context).newRequestCar(token: token),
    );
    return BlocConsumer<CarOwnerCubit, CarOwnerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final String? token = CacheHelper.getData(key: 'token');

        CarOwnerCubit cubit = CarOwnerCubit.get(context);
        var list = cubit.carInformationGet;

        return Scaffold(
          key: cubit.scaffoldKey,
          appBar: AppBar(
            //leading: ,
            title: Center(
              child: Container(
                child: Text(
                  "CARS",
                ),
              ),
            ),
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
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isShowBottomSheet) {
                if (cubit.formKey.currentState!.validate()) {
                  cubit.postCrInformation(
                      carType: cubit.typeCar.toString(),
                      carColor: cubit.colorCar.toString(),
                      carNumber: cubit.carNumberController.text,
                      year: cubit.carYearController.text,
                      mileage: cubit.carKMController.text,
                      token: token.toString());

                  Navigator.pop(context);
                  cubit.isShowBottomSheet = false;
                  cubit.changedIconEdit();
                  //await cubit.getCarFl();
                  /* setState(() async {
                    await
                  });*/
                }
              } else {
                cubit.changedIconAdd();
                cubit.isShowBottomSheet = true;
                cubit.scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => BlocConsumer<CarOwnerCubit, CarOwnerStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              //height: 200,
                              color: Colors.grey.withOpacity(.2),
                              child: Form(
                                key: cubit.formKey,
                                child: Column(
                                  children: [
                                    Text(
                                      "ADD YOUR CAR",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),
                                    ),
                                    Divider(
                                      height: 25,
                                      thickness: 2,
                                      color: Colors.indigo,
                                      endIndent: 100,
                                      indent: 100,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: cubit.typeCar,
                                          isExpanded: true,
                                          iconSize: 30,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.indigo,
                                          ),
                                          items: cubit.items
                                              .map(buildMenuItemCarName)
                                              .toList(),
                                          onChanged: (value) => cubit
                                              .onChangedDropdownButtonCarType(
                                                  value),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: cubit.colorCar,
                                          isExpanded: true,
                                          iconSize: 30,
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.indigo,
                                          ),
                                          items: cubit.colorItems
                                              .map(buildMenuItemCarColor)
                                              .toList(),
                                          onChanged: (value) => cubit
                                              .onChangedDropdownButtonColor(
                                                  value),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultFormField(
                                      controller: cubit.carNumberController,
                                      type: TextInputType.number,
                                      labelText: "Car Number",
                                      prefixIcon: Icons.car_rental,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your car number";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultFormField(
                                      controller: cubit.carYearController,
                                      type: TextInputType.datetime,
                                      labelText: "Manufacturing Year",
                                      prefixIcon: Icons.calendar_today,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDatePickerMode:
                                              DatePickerMode.year,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.utc(1970),
                                          lastDate: DateTime.utc(2025),
                                        ).then((value) {
                                          print(DateFormat.y().format(value!));
                                          cubit.carYearController.text =
                                              DateFormat.y().format(value);
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your manufacturing year";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultFormField(
                                      controller: cubit.carKMController,
                                      type: TextInputType.number,
                                      labelText: "Mileage",
                                      prefixIcon: Icons.edit_road,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter the mileage of the car";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .closed
                    .then(
                  (value) {
                    cubit.isShowBottomSheet = false;
                    cubit.changedIconEdit();
                  },
                );
              }
            },
            child: Icon(cubit.fabIcon),
            backgroundColor: Colors.indigo,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

//000000000000000000000000000000000000000000000000000000000000000000000000000000000000
DropdownMenuItem<String> buildMenuItemCarName(dynamic item) => DropdownMenuItem(
      value: item,
      child: Center(
        child: Text(
          item,
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );

//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

DropdownMenuItem<String> buildMenuItemCarColor(dynamic item) =>
    DropdownMenuItem(
      value: item,
      child: Center(
        child: Text(
          item,
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );

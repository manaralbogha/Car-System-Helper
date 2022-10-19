import 'package:bloc/bloc.dart';
import 'package:car/layout/home_layout_without_login/cubit/states.dart';
import 'package:car/models/home_without_login_model.dart';
import 'package:car/models/home_without_login_model.dart';
import 'package:car/models/home_without_login_model.dart';
import 'package:car/models/home_without_login_model.dart';
import 'package:car/models/home_without_login_model.dart';
import 'package:car/modules/german/german_screen.dart';
import 'package:car/modules/japanese/japanese_screen.dart';
import 'package:car/modules/korean/korean_screen.dart';
import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarCubit extends Cubit<CarStates> {
  CarCubit() : super(CarInitalState());

  static CarCubit get(context) => BlocProvider.of(context);

  /*int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.flag),
      label: "German",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.flag),
      label: "Japanese",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.flag),
      label: "Korean",
    ),
  ];
  List<Widget> screens = [
    GermanScreen(),
    JapaneseScreen(),
    KoreanScreen(),
  ];*/
/*  void changeBottomNavBat(int index) {
    currentIndex = index;
    emit(CarBottomNavState());
  }*/

  List<dynamic> home = [];
  void getData() {
    emit(GetDataLoadingState());
    DioHelper.getData(
      url: '${url}home_page',
    ).then((value) {
      print(value.data);
      home = value.data['data'];
      print(home);

      emit(GetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataErrorState(error.toString()));
    });
  }
}

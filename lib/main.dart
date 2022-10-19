import 'dart:async';

import 'package:car/modules/rigister/cubit/cubit.dart';
import 'package:car/shared/network/local/notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/home_layout_car_owner/cubit/cubit.dart';
import 'layout/home_layout_car_owner/home_layout_car_owner.dart';
import 'layout/home_layout_without_login/home_layout_without_login.dart';
import 'package:car/modules/login/loginscreen.dart';
import 'package:car/modules/login/start_screen.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:car/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'layout/home_layout_workshop_owner/cubit/cubit.dart';
import 'layout/home_layout_workshop_owner/home_layout_workshop_owner.dart';
import 'modules/notifications_workshop_screen/information_notification_workshop_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/components/constants.dart';

void main() async {
  /* WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.initializer();*/
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  if (CacheHelper.getData(key: 'onBoarding') == null) {
    CacheHelper.saveData(key: 'onBoarding', value: false);
  }
  Widget widget;
  bool onBoarding = await CacheHelper.getData(key: 'onBoarding');
  final String? token = await CacheHelper.getData(key: 'token');
  print(token);

  String? type = await CacheHelper.getData(key: 'type');
  print(type);
  print(token);
  if (onBoarding == true) {
    if (token != null) {
      if (type == 'car owner') {
        widget = HomeLayoutCarOwner();
      } else {
        widget = HomeLayoutWorkshopOwner();
      }
    } else {
      widget = home_layout_without_login();
    }
  } else {
    widget = OnBoardingScreen();
  }

  //print(onBoarding);
  runApp(MyApp(
    startWidget: widget,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  final String? token;
  MyApp({this.startWidget, this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              CarOwnerCubit() /*..ifGetCarInformation()*/,
        ),
        BlocProvider(
          create: (BuildContext context) =>
              WorkshopOwnerCubit() /*..getData(token: token)*/,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          // primaryColor: Colors.indigo,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.indigo),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.indigo,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.indigo,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.indigo,
            elevation: 20.0,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
// HomeLayoutWorkshopOwner(),
//onBoarding! ? home_layout_without_login() : OnBoardingScreen(),HomeLayoutCarOwner(),
// startWidget,

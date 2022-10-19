import 'package:bloc/bloc.dart';
import 'package:car/layout/home_layout_workshop_owner/cubit/states.dart';
import 'package:car/models/workshop_model.dart';
import 'package:car/modules/home_workshop_screen/home_workshop_screen.dart';
import 'package:car/modules/notifications_workshop_screen/notifications_workshop_screen.dart';
import 'package:car/modules/rigister/cubit/cubit.dart';
import 'package:car/modules/rigister/cubit/cubit.dart';
import 'package:car/modules/rigister/cubit/cubit.dart';
import 'package:car/modules/rigister/cubit/cubit.dart';
import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:car/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkshopOwnerCubit extends Cubit<WorkshopOwnerStates> {
  WorkshopOwnerCubit() : super(WorkshopOwnerInitialState());
  static WorkshopOwnerCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var scaffoldKeyForWorkshopNotification = GlobalKey<ScaffoldState>();
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_work_outlined),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.notifications_none_rounded,
        /* color: Colors
            .red,*/ /*color: hasNotifications['hasNotifications]==true?Colors.red:Colors.indigo,*/
      ),
      label: "Notification",
    ),
    /* BottomNavigationBarItem(
      icon: Icon(Icons.flag),
      label: "Korean",
    ),*/
  ];
  List<Widget> screens = [
    HomeWorkshopScreen(),
    NotificationsWorkshopScreen(),
    //KoreanScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getData(token: token);
    }
    emit(WorkshopOwnerBottomNavState());
  }

  final String? token = CacheHelper.getData(key: 'token');
  void getNotification(int index) {
    if (index == 1) {
      getNotificationForWorkshop(token: token);
    }
  }

  /* void getCar(int index) {
    if (index == 0) {
      getData(token: token);
    }
  }
*/
  // WorkshopModel? workshopModel;
  Map<String, dynamic> workshopModel = {};
  List<dynamic> carInfo = [];
  void getData({
    required String? token,
  }) {
    emit(GetWorkshopDataLoadingState());
    DioHelper.postData(
      url: '${url}getProfile',
      data: {
        'token': token,
      },
    ).then((value) {
      print(value.data);
      //workshopModel = WorkshopModel.fromJson(value.data);
      // print(workshopModel!.workShopInfo.toString());
      workshopModel = value.data['workShopInfo'];
      carInfo = value.data['carInWS'];

      print(workshopModel);
      print(carInfo);
      emit(GetWorkshopDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetWorkshopDataErrorState(error.toString()));
    });
  }

  // String token = CacheHelper.getData(key: 'token');

  //000000000000000000000000000000notificationWorkshop
  bool ifOk = false;

  void onPressedOnOk() {
    ifOk = true;
    CacheHelper.saveData(key: 'ok', value: ifOk);
    emit(WorkshopOnPressedOnOkSuccessState());
  }

  List<dynamic> notificationForWorkshop = [];
  void getNotificationForWorkshop({
    required String? token,
  }) {
    emit(GetNotificationForWorkshopLoadingState());
    DioHelper.postData(url: '${url}getNotifApi', data: {
      'token': token,
    }).then((value) {
      print(value.data);
      notificationForWorkshop = value.data['data'];
      print(notificationForWorkshop.toString());

      emit(GetNotificationForWorkshopSuccessState());
    }).catchError((error) {
      emit(GetNotificationForWorkshopErrorState(error.toString()));
    });
  }

  Map<String, dynamic> informationNotificationForWorkshopData = {};
  Map<String, dynamic> informationNotificationForWorkshop = {};
  void getInformationNotificationForWorkshop({
    required String token,
    required int id,
  }) {
    emit(GetInformationNotificationForWorkshopLoadingState());
    DioHelper.postData(url: '${url}getDetailsNotifApi', data: {
      'token': token,
      'id': id,
    }).then((value) {
      print(value.data);
      informationNotificationForWorkshop = value.data;
      print(informationNotificationForWorkshop);
      informationNotificationForWorkshopData = value.data['data'];
      print(informationNotificationForWorkshopData);
      emit(GetInformationNotificationForWorkshopSuccessState());
    }).catchError((error) {
      emit(GetInformationNotificationForWorkshopErrorState(error.toString()));
    });
  }

  Map<String, dynamic> okNoForCheck = {};
  void okOrNoForCheckWorkshop({
    required String token,
    String? time,
    required bool check,
    required int id,
  }) {
    emit(OkOrNoForCheckWorkshopLoadingState());
    DioHelper.postData(url: '${url}return_WS_For_Request', data: {
      'token': token,
      'time': time,
      'check': check,
      'id': id,
    }).then((value) {
      print(value.data);
      okNoForCheck = value.data;
      informationNotificationForWorkshop = value.data;
      informationNotificationForWorkshopData = value.data['data'];
      emit(OkOrNoForCheckWorkshopSuccessState());
    }).catchError((error) {
      emit(OkOrNoForCheckWorkshopErrorState(error.toString()));
    });
  }

  var timeToStartController = TextEditingController();
  var timeToEndController = TextEditingController();
  var costController = TextEditingController();

  void evaluationWorkshop({
    required String token,
    required String timeStart,
    required String timeEnd,
    required String cost,
    required int id,
    required bool isEvaluation,
  }) {
    emit(EvaluationWorkshopLoadingState());
    DioHelper.postData(url: '${url}return_WS_for_eval', data: {
      'token': token,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
      'cost': cost,
      'id': id,
      'isEvaluation': isEvaluation,
    }).then((value) {
      print(value.data);
      informationNotificationForWorkshop = value.data;

      emit(EvaluationWorkshopSuccessState());
    }).catchError((error) {
      emit(EvaluationWorkshopErrorState(error.toString()));
    });
  }

  bool? hasNotifications;
  Map<String, dynamic> newRequestData = {};
  List<dynamic> newRequest = [];
  List<dynamic> requestUpdata = [];
  List<dynamic> requestUpdataF = [];
  void newRequestWorkshop({
    required String? token,
  }) {
    emit(NewRequestWorkshopLoadingState());
    DioHelper.postData(url: '${url}update_notif', data: {
      'token': token,
    }).then((value) {
      print(value.data);
      newRequestData = value.data;

      requestUpdata = value.data['data']['requestUpdata'];
      //  print(requestUpdata);

      requestUpdataF = requestUpdata;

      // print(requestUpdataF);
      newRequest = value.data['data']['newRequest'];
      // print(newRequest);
      if (newRequest.length > 0) {
        notificationForWorkshop.addAll(newRequest);
      }

      // print(notificationForWorkshop.toList());
      hasNotifications = value.data['data']['hasNotifications'];

      emit(NewRequestWorkshopSuccessState());
    }).catchError((error) {
      emit(NewRequestWorkshopErrorState(error.toString()));
    });
  }

  void endingCarInWorkshop({
    required String token,
    required String platNumber,
  }) {
    emit(EndingCarInWorkshopLoadingState());
    DioHelper.postData(url: '${url}exit_car', data: {
      'token': token,
      'platNumber': platNumber,
    }).then((value) {
      print(value.data);

      emit(EndingCarInWorkshopSuccessState());
    }).catchError((error) {
      emit(EndingCarInWorkshopErrorState(error.toString()));
    });
  }
}

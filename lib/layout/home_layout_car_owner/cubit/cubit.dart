import 'package:bloc/bloc.dart';
import 'package:car/layout/home_layout_car_owner/cubit/states.dart';
import 'package:car/modules/home_car_screen/home_car_screen.dart';
import 'package:car/modules/notifications_car_screen/notification_car_screen.dart';

import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:car/shared/network/remote/dio_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarOwnerCubit extends Cubit<CarOwnerStates> {
  CarOwnerCubit() : super(CarOwnerInitialState());

  static CarOwnerCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    /* BottomNavigationBarItem(
      icon: Icon(Icons.home_work),
      label: "Workshops",
    ),*/
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: "Notifications",
    ),
  ];
  List<Widget> screens = [
    HomeCarScreen(),
    // ShowWorkshopForCarOwnerScreen(),
    NotificationCarScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getCarInformation(token: token);
    }
    emit(CarOwnerBottomNavState());
  }

  final String? token = CacheHelper.getData(key: 'token');
  void getNotification(int index) {
    if (index == 1) {
      getNotificationForCarOwner(token: token);
    }
  }

/*  void getCar(int index) {
    if (index == 0) {
      getCarInformation(token: token);
    }
  }*/

  final items = [
    "Audi",
    "BMW",
    "Bugatti",
    "Chery",
    "Daewoo",
    "Datsun",
    "Dodge",
    "Ferrari",
    "Fiat",
    "Ford",
    "Great Wall",
    "Jeep",
    "Kia",
    "Mercedes-Benz",
    "Nissan",
    "Porsche",
    "Renault",
    "Subaru",
    "Suzuki",
    "Volkswagen"
  ];
  String typeCar = 'Audi';

  void onChangedDropdownButtonCarType(value) {
    this.typeCar = value;
    emit(CarOwnerOnChangedDropdownButtonCarType());
  }

  bool isShowBottomSheet = false;

  IconData fabIcon = Icons.edit;

  void changedIconEdit() {
    fabIcon = Icons.edit;
    emit(CarOwnerOnChangedIconEdit());
  }

  void changedIconAdd() {
    fabIcon = Icons.add;
    emit(CarOwnerOnChangedIconAdd());
  }

  final colorItems = [
    'Red',
    'Blue',
    'Green',
    'Orange',
    'White',
    'Black',
    'Yellow',
    'Purple',
    'Silver',
    'Brown',
    'Gray',
    'Pink',
    'Olive',
    'Maroon',
    'Violet',
    'Charcoal',
    'Magenta',
    'Bronze',
    'Cream',
    'Gold',
    'Tan',
    'Teal',
    'Mustard',
    'NavyBlue',
    'Coral',
    'Burgundy',
    'Lavender',
    'Mauve',
    'Peach',
    'Rust',
    'Indigo',
    'Ruby',
    'Clay',
    'Cyan',
    'Azure',
    'Beige',
    'OffWhite',
    'Turquoise',
    'Amber',
    'Mint'
  ];
  String colorCar = 'Red';

  void onChangedDropdownButtonColor(value) {
    this.colorCar = value;
    emit(CarOwnerOnChangedDropdownButtonColor());
  }

  var carNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var carYearController = TextEditingController();
  List<dynamic> informationCarPost = [];

  void postCrInformation({
    required String carType,
    required String carColor,
    required String carNumber,
    required String year,
    required String mileage,
    required String? token,
  }) {
    emit(CarOwnerLoadingState());
    DioHelper.postData(url: '${url}add_user_car', data: {
      'carType': carType,
      'carColor': carColor,
      'carNumber': carNumber,
      'year': year,
      'token': token,
      'mileage': mileage,
    }).then((value) {
      print(value.data);
      informationCarPost = value.data['cars'];
      carInformationGet = informationCarPost;
      print(informationCarPost);

      emit(CarOwnerSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CarOwnerErrorState(error));
    });
  }

  var carKMController = TextEditingController();

  List<dynamic> carInformationGet = [];

  Future getCarInformation({
    required String? token,
  }) async {
    emit(CarOwnerGetCarInformationLoadingState());
    DioHelper.postData(url: '${url}getProfile', data: {
      'token': token,
    }).then((value) {
      print(value.data);
      carInformationGet = value.data['cars'];
      print(carInformationGet);
      emit(CarOwnerGetCarInformationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CarOwnerGetCarInformationErrorState(error));
    });
  }

  List<dynamic> workshopForCarOwner = [];
  void getWorkshopForCar({
    required String? token,
    required String? carName,
    required String? carNumber,
  }) {
    emit(CarOwnerGetWorkshopForCarLoadingState());
    DioHelper.postData(
            url: '${url}getWSForCar',
            data: {'token': token, 'carName': carName, 'carNumber': carNumber})
        .then((value) {
      print(value.data);
      workshopForCarOwner = value.data['data'];
      print(workshopForCarOwner.toList());

      emit(CarOwnerGetWorkshopForCarSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CarOwnerGetWorkshopForCarErrorState(error));
    });
  }

/*
  Widget listView(list) {
    //listViewUpdate(list);

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          carInformation(context, list[index], token),
      separatorBuilder: (context, index) => SizedBox(
        height: 0.0,
      ),
      itemCount: list.length,
    );
  }
*/

  /*void listViewUpdate(list) {
    listView(list);
    emit(CarOwnerUpdateCarListViewScreenSuccessState());
  }

  String token = CacheHelper.getData(key: 'token');
  Future<void> updateCarScreen(list) async {
    listViewUpdate(list);
    emit(CarOwnerUpdateCarScreenSuccessState());
  }*/
  List<dynamic> requestChek = [];
  void requestForChek({
    required String? token,
    required String? carNumber,
    required String? carName,
    required int? workshopId,
  }) {
    emit(CarOwnerRequestForChekLoadingState());
    DioHelper.postData(url: '${url}requestForCheck', data: {
      'token': token,
      'carNumber': carNumber,
      'workshopId': workshopId,
      'carName': carName
    }).then((value) {
      print(value.data);
      // requestChek = value.data;
      workshopForCarOwner = value.data['data'];
      print(requestChek.toString());

      emit(CarOwnerRequestForChekSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CarOwnerRequestForChekErrorState(error));
    });
  }

  List<dynamic> getNotificationForCar = [];
  void getNotificationForCarOwner({
    required String? token,
  }) {
    emit(GetNotificationForCarLoadingState());
    DioHelper.postData(url: '${url}getNotifApi', data: {
      'token': token,
    }).then((value) {
      print(value.data);
      getNotificationForCar = value.data['data'];
      print(getNotificationForCar);
      emit(GetNotificationForCarSuccessState());
    }).catchError((error) {
      emit(GetNotificationForCarErrorState(error.toString()));
    });
  }

  Map<String, dynamic> informationNotificationData = {};
  Map<String, dynamic> informationNotification = {};
  void getInformationNotificationForCar({
    required String token,
    required int id,
  }) {
    emit(GetInformationNotificationForCarLoadingState());
    DioHelper.postData(url: '${url}getDetailsNotifApi', data: {
      'token': token,
      'id': id,
    }).then((value) {
      print(value.data);
      informationNotificationData = value.data['data'];
      informationNotification = value.data;
      print(informationNotificationData);
      emit(GetInformationNotificationForCarSuccessState());
    }).catchError((error) {
      emit(GetInformationNotificationForCarErrorState(error.toString()));
    });
  }

  // var m =carInformationGet;
  /* void ifGetCarInformation() {
    if (carInformationGet.length <= 0) {
      getCarInformation(token: token);
    } else {
      print(carInformationGet.toList());
    }
  }*/
  Map<String, dynamic> okNoForCheck = {};
  void okOrNoForCheckCar({
    required String token,
    required bool check,
    required int id,
  }) {
    emit(OkOrNoForCheckCarLoadingState());
    DioHelper.postData(url: '${url}return_CO_For_Request', data: {
      'token': token,
      'check': check,
      'id': id,
    }).then((value) {
      print(value.data);
      okNoForCheck = value.data;
      informationNotification = value.data;
      informationNotificationData = value.data['data'];
      emit(OkOrNoForCheckCarSuccessState());
    }).catchError((error) {
      emit(OkOrNoForCheckCarErrorState(error.toString()));
    });
  }

  void okOrNoForEvaluate({
    required String token,
    required bool isEvaluate,
    required int id,
  }) {
    emit(OkOrNoForEvaluateLoadingState());
    DioHelper.postData(url: '${url}return_CO_for_eval', data: {
      'token': token,
      'isEvaluate': isEvaluate,
      'id': id,
    }).then((value) {
      print(value.data);
      informationNotification = value.data;
      emit(OkOrNoForEvaluateSuccessState());
    }).catchError((error) {
      emit(OkOrNoForEvaluateErrorState(error.toString()));
    });
  }

  List<dynamic> requestUpdata = [];
  List<dynamic> requestUpdataF = [];
  void newRequestCar({
    required String? token,
  }) {
    emit(NewRequestCarLoadingState());
    DioHelper.postData(url: '${url}update_notif', data: {
      'token': token,
    }).then((value) {
      print(value.data);
      requestUpdata = value.data['data']['requestUpdata'];
      requestUpdataF = requestUpdata;
      print(requestUpdataF);

      emit(NewRequestCarSuccessState());
    }).catchError((error) {
      emit(NewRequestCarErrorState(error.toString()));
    });
  }
}

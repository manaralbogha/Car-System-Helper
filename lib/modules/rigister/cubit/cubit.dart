import 'package:bloc/bloc.dart';
import 'package:car/models/register_model.dart';
import 'package:car/models/register_model.dart';

import 'package:car/modules/rigister/cubit/states.dart';
import 'package:car/modules/rigister/register_screen.dart';
import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  late RegisterModel registerModelCarOwner;
  void userCarOwnerRegister({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required String confirmationPassword,
    required String type,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: '${url}SignUpCO', data: {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'password': password,
      'confirmationPassword': confirmationPassword,
      'type': type,
    }).then((value) {
      print(value.data);
      registerModelCarOwner = RegisterModel.fromJson(value.data);
      print(registerModelCarOwner);
      emit(RegisterSuccessState(registerModelCarOwner));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  late RegisterModel registerModelWorkshop;
  void userWorkshopRegister({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required String type,
    required String workshopName,
    required String workshopAddress,
    required String workshopCapacity,
    required String workshopOrigin,
    required List<String?> workshopCarType,
    required List<String?> workshopService,
  }) {
    emit(RegisterWorkshopLoadingState());
    DioHelper.postData(url: '${url}SignUpWS', data: {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'password': password,
      'type': type,
      'workshopName': workshopName,
      'workshopAddress': workshopAddress,
      'workshopCapacity': workshopCapacity,
      'workshopOrigin': workshopOrigin,
      'workshopCarType': workshopCarType,
      'workshopService': workshopService,
    }).then((value) {
      print(value.data);
      registerModelWorkshop = value.data;
      print(registerModelWorkshop);
      emit(RegisterWorkshopSuccessState(registerModelWorkshop));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterWorkshopErrorState());
    });
  }

  List<dynamic> origin = [];
  void getDataOrigin() {
    DioHelper.getData(url: '${url}getSpecialist').then((value) {
      print(value.data);
      origin = value.data;
      emit(GetDataOriginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataOriginErrorState(error.toString()));
    });
  }

  /* late Car car;
  void getDataTypeCar({required query}) {
    DioHelper.postData(
        url: 'http://192.168.43.205:8000/getPrandsByOrigin',
        data: {'specialistID': query}).then((value) {
      print(value.data);
      car = Car.fromJson(value.data);
      emit(GetDataTypeCarSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataTypeCarErrorState(error.toString()));
    });
  }*/
}

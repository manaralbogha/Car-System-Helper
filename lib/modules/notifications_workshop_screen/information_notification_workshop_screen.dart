//information_notification_workshop_screen
import 'package:car/layout/home_layout_workshop_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_workshop_owner/cubit/states.dart';
import 'package:car/shared/components/components.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InformationNotificationWorkshopScreen extends StatefulWidget {
  @override
  _InformationNotificationWorkshopScreenState createState() =>
      _InformationNotificationWorkshopScreenState();
}

class _InformationNotificationWorkshopScreenState
    extends State<InformationNotificationWorkshopScreen> {
  var timeForChekController = TextEditingController();
  bool isCheck = false;
  bool isEvaluation = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkshopOwnerCubit, WorkshopOwnerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        WorkshopOwnerCubit cubit = WorkshopOwnerCubit.get(context);
        final String? token = CacheHelper.getData(key: 'token');
        var informationNotificationData =
            cubit.informationNotificationForWorkshopData;
        var informationNotification = cubit.informationNotificationForWorkshop;

        return Scaffold(
          key: cubit.scaffoldKeyForWorkshopNotification,
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: informationNotification['rejected'] == true,
            builder: (context) => rejectCheck(context, token,
                informationNotificationData, informationNotification),
            fallback: (context) => ConditionalBuilder(
              condition: informationNotification['pending'] == true &&
                  informationNotification['CO_Accept'] == false,
              builder: (context) => notCheck(context, timeForChekController,
                  token, isCheck, informationNotificationData),
              fallback: (context) => ConditionalBuilder(
                condition: informationNotification['pending'] == false &&
                    informationNotification['CO_Accept'] == true,
                builder: (context) => check(informationNotificationData,
                    informationNotification, isEvaluation, context, token),
                fallback: (context) => waitingForAccept(
                    informationNotificationData, informationNotification),
              ), //waitingForAccept(),
            ),
          ),
        );
      },
    );
  }
}

Widget notCheck(context, timeForChekController, token, isCheck,
        informationNotificationData) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromARGB(150, 100, 228, 221),
              Color.fromARGB(50, 150, 201, 197),
              Color.fromARGB(150, 217, 228, 221),
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: WorkshopOwnerCubit.get(context).formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '${informationNotificationData['carsID__prand_C__name']}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: Colors.black54,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kilometers :',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      '${informationNotificationData['carsID__mileage']} KM',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              defaultFormField(
                controller: timeForChekController,
                type: TextInputType.datetime,
                labelText: "Car check time",
                prefixIcon: Icons.access_time_rounded,
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) {
                    timeForChekController.text = value!.format(context);
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the for check the car";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultButton(
                    text: 'NO',
                    // fontSize: 20,
                    onPressed: () {
                      isCheck = false;
                      WorkshopOwnerCubit.get(context).okOrNoForCheckWorkshop(
                          token: token,
                          check: isCheck,
                          id: informationNotificationData['pk']);
                    },

                    height: 40,
                    width: 100,
                    background: Colors.red.shade700,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  defaultButton(
                    text: 'OK',
                    //fontSize: 15,
                    onPressed: () {
                      isCheck = true;
                      if (WorkshopOwnerCubit.get(context)
                          .formKey
                          .currentState!
                          .validate()) {
                        WorkshopOwnerCubit.get(context).okOrNoForCheckWorkshop(
                            token: token,
                            id: informationNotificationData['pk'],
                            time: timeForChekController.text,
                            check: isCheck);
                        //  WorkshopOwnerCubit.get(context).onPressedOnOk();
                      }
                    },
                    height: 40,
                    width: 100,
                    background: Colors.green.shade700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
//00000000000000000000000000000000000000000000000000000000000000000000000000000
Widget check(informationNotificationData, informationNotification, isEvaluation,
        context, token) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromARGB(150, 100, 228, 221),
            Color.fromARGB(50, 150, 201, 197),
            Color.fromARGB(150, 217, 228, 221),
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: WorkshopOwnerCubit.get(context).formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '${informationNotificationData['carsID__prand_C__name']}',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(
              height: 10,
              thickness: 1,
              color: Colors.black54,
            ),
            SizedBox(
              height: 20,
            ),
            ConditionalBuilder(
                condition: informationNotification['evaluate'] == true,
                builder: (context) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time to start repairing the car :',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${informationNotificationData['timeStart']}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Estimated time to finish :',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${informationNotificationData['timeEnd']} ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Estimated cost :',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${informationNotificationData['cost']} ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            '${informationNotification['title']} ',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: informationNotification['Accept_eval'] ==
                                      false
                                  ? Colors.red
                                  : Colors.green,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                fallback: (context) => Column(
                      children: [
                        defaultFormField(
                          controller: WorkshopOwnerCubit.get(context)
                              .timeToStartController,
                          type: TextInputType.datetime,
                          labelText: "Work Start time",
                          prefixIcon: Icons.calendar_today,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDatePickerMode: DatePickerMode.year,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.utc(1970),
                              lastDate: DateTime.utc(2025),
                            ).then((value) {
                              print(DateFormat.y().format(value!));
                              WorkshopOwnerCubit.get(context)
                                  .timeToStartController
                                  .text = DateFormat.yMMMMEEEEd().format(value);
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please select a start time work";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: WorkshopOwnerCubit.get(context)
                              .timeToEndController,
                          type: TextInputType.datetime,
                          labelText: "Approximate time to finish work",
                          prefixIcon: Icons.calendar_today,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDatePickerMode: DatePickerMode.year,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.utc(1970),
                              lastDate: DateTime.utc(2025),
                            ).then((value) {
                              print(DateFormat.y().format(value!));
                              WorkshopOwnerCubit.get(context)
                                  .timeToEndController
                                  .text = DateFormat.yMMMMEEEEd().format(value);
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please select an end time work";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the approximate cost";
                            }
                            return null;
                          },
                          prefixIcon: Icons.format_size_outlined,
                          labelText: "Approximate cost",
                          controller:
                              WorkshopOwnerCubit.get(context).costController,
                          type: TextInputType.number,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: defaultButton(
                            text: 'send evaluation',
                            //fontSize: 15,
                            onPressed: () {
                              isEvaluation = true;
                              if (WorkshopOwnerCubit.get(context)
                                  .formKey
                                  .currentState!
                                  .validate()) {
                                WorkshopOwnerCubit.get(context)
                                    .evaluationWorkshop(
                                        token: token,
                                        timeStart:
                                            WorkshopOwnerCubit.get(context)
                                                .timeToStartController
                                                .text,
                                        timeEnd: WorkshopOwnerCubit.get(context)
                                            .timeToEndController
                                            .text,
                                        cost: WorkshopOwnerCubit.get(context)
                                            .costController
                                            .text,
                                        id: informationNotificationData['pk'],
                                        isEvaluation: isEvaluation);
                              }
                              // evaluation = true;
                            },
                            height: 40,
                            width: double.infinity,
                            background: Colors.indigo,
                          ),
                        ),
                      ],
                    )),
          ],
        ),
      ),
    );
//00000000000000000000000000000000000000000000000000000000000000000000000000000
Widget waitingForAccept(informationNotificationData, informationNotification) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromARGB(150, 100, 228, 221),
            Color.fromARGB(50, 150, 201, 197),
            Color.fromARGB(150, 217, 228, 221),
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '${informationNotificationData['carsID__prand_C__name']}',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              '${informationNotification['title']}',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
//00000000000000000000000000000000000000000000000000000000000000000000000000000
Widget rejectCheck(
        context, token, informationNotificationData, informationNotification) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromARGB(150, 100, 228, 221),
              Color.fromARGB(50, 150, 201, 197),
              Color.fromARGB(150, 217, 228, 221),
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: WorkshopOwnerCubit.get(context).formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '${informationNotificationData['carsID__prand_C__name']}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: Colors.black54,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kilometers :',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      '${informationNotificationData['carsID__mileage']} KM',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  '${informationNotification['title']}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );

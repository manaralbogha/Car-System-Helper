import 'package:car/layout/home_layout_car_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_car_owner/cubit/states.dart';
import 'package:car/shared/components/components.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationNotificationCarScreen extends StatelessWidget {
  const InformationNotificationCarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarOwnerCubit, CarOwnerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CarOwnerCubit.get(context);
          var list = cubit.informationNotificationData;
          var list1 = cubit.informationNotification;
          final String? token = CacheHelper.getData(key: 'token');
          bool isCheck = false;
          bool isEvaluate = false;
          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: list1['rejected'] == true,
              builder: (context) => rejectCheck(context, token, list, list1),
              fallback: (context) => ConditionalBuilder(
                condition: true,
                builder: (context) => defaultNotification(
                    list, isCheck, token, list1, isEvaluate),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        });
  }
}

Widget defaultNotification(
        listData, isCheck, token, informationNotification, isEvaluate) =>
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '${listData['workShopID__name']}',
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
                  'Car name :',
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
                    '${listData['carsID__prand_C__name']}',
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
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Car number :',
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
                    '${listData['carsID__platNumber']}',
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
              height: 10,
            ),
            /* Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'State :',
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
                    '${list['pending']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),*/
            //000000000000000000000000000000000000000000000000000000000
            ConditionalBuilder(
              condition: informationNotification['pending'] != true,
              builder: (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: Colors.black54,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Workshop phone :',
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
                          '${listData['phone']}',
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
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Workshop address :',
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
                          '${listData['address']}',
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
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time for chek :',
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
                          ' Today at ${listData['time']}',
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
                    height: 10,
                  ),
                  ConditionalBuilder(
                    condition: informationNotification['CO_Accept'] != true,
                    builder: (context) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultButton(
                          text: 'NO',
                          // fontSize: 20,
                          onPressed: () {
                            isCheck = false;
                            CarOwnerCubit.get(context).okOrNoForCheckCar(
                                token: token,
                                check: isCheck,
                                id: listData['pk']);
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
                            CarOwnerCubit.get(context).okOrNoForCheckCar(
                                token: token,
                                check: isCheck,
                                id: listData['pk']);
                          },
                          height: 40,
                          width: 100,
                          background: Colors.green.shade700,
                        ),
                      ],
                    ),
                    fallback: (context) => Center(
                      child: Text(
                        informationNotification['CO_Accept'] == true
                            ? 'Request approved'
                            : 'no',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: informationNotification['CO_Accept']
                                ? Colors.green
                                : Colors.red),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              fallback: (context) => SizedBox(
                height: 5,
              ),
            ),

            //000000000000000000000000000000000000000000000000000000000
            ConditionalBuilder(
              condition: informationNotification['evaluate'] == true,
              builder: (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    height: 15,
                    thickness: 1,
                    color: Colors.black54,
                  ),
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
                    '${listData['timeStart']} ',
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
                    '${listData['timeEnd']}  ',
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
                    '${listData['cost']} ',
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
                  ConditionalBuilder(
                    condition: informationNotification['Accept_eval'] != true,
                    builder: (context) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultButton(
                          text: 'NO',
                          // fontSize: 20,
                          onPressed: () {
                            isEvaluate = false;
                            CarOwnerCubit.get(context).okOrNoForEvaluate(
                                token: token,
                                isEvaluate: isEvaluate,
                                id: listData['pk']);
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
                            isEvaluate = true;
                            CarOwnerCubit.get(context).okOrNoForEvaluate(
                                token: token,
                                isEvaluate: isEvaluate,
                                id: listData['pk']);
                          },
                          height: 40,
                          width: 100,
                          background: Colors.green.shade700,
                        ),
                      ],
                    ),
                    fallback: (context) => Center(
                      child: Text(
                        informationNotification['Accept_eval'] == true
                            ? 'Request approved'
                            : 'no',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: informationNotification['Accept_eval']
                                ? Colors.green
                                : Colors.red),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Divider(
                    height: 15,
                    thickness: 1,
                    color: Colors.black54,
                  ),
                ],
              ),
              fallback: (context) => SizedBox(
                height: 5,
              ),
            ),

            Center(
              child: Text(
                '${informationNotification['title']}',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: informationNotification['pending'] == true
                        ? Colors.red
                        : Colors.green),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
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
          key: CarOwnerCubit.get(context).formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '${informationNotificationData['workShopID__name']}',
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
                    'Car name :',
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
                      '${informationNotificationData['carsID__prand_C__name']}',
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
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Car number :',
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
                      '${informationNotificationData['carsID__platNumber']}',
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
                height: 10,
              ),
              Center(
                child: Text(
                  '${informationNotification['title']}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: informationNotification['pending'] == true
                          ? Colors.red
                          : Colors.green),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );

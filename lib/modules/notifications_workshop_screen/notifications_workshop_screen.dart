import 'dart:async';

import 'package:car/layout/home_layout_workshop_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_workshop_owner/cubit/states.dart';
import 'package:car/shared/components/components.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'information_notification_workshop_screen.dart';

class NotificationsWorkshopScreen extends StatefulWidget {
  @override
  _NotificationsWorkshopScreenState createState() =>
      _NotificationsWorkshopScreenState();
}

//Timer? timer;

/*@override
void initState() {
  super.initState();
  timer = Timer.periodic(Duration(seconds: 15), (Timer t) => checkForNewSharedLists());
}

@override
void dispose() {
  timer?.cancel();
  super.dispose();
}*/
class _NotificationsWorkshopScreenState
    extends State<NotificationsWorkshopScreen> {
  var timeForChekController = TextEditingController();

  String token = CacheHelper.getData(key: 'token');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkshopOwnerCubit, WorkshopOwnerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        WorkshopOwnerCubit cubit = WorkshopOwnerCubit.get(context);
        var list = cubit.notificationForWorkshop;
        List listId = cubit.requestUpdataF;
        var x;
        final String? token = CacheHelper.getData(key: 'token');

        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! GetNotificationForWorkshopLoadingState,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    defaultNotification(context, list[index], token, listId, x),
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
    );
  }
}

Widget defaultNotification(context, list, token, listId, x) => Padding(
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
            Row(
              children: [
                Text(
                  '${list['carsID__prand_C__name']}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                ConditionalBuilder(
                  condition: listId.contains(list['pk']),
                  builder: (context) => Icon(
                    Icons.notifications,
                    color: Colors.red[700],
                  ),
                  fallback: (context) => SizedBox(
                    width: 30,
                  ),
                ),
              ],
            ),
            Divider(
              height: 10,
              thickness: 1,
              color: Colors.black54,
            ),
            Row(
              children: [
                Text(
                  'Car owner name :',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${list['carsID__userID__fisrName']} ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Car number :',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${list['carsID__platNumber']} ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: defaultButton(
                text: 'information display',
                //fontSize: 15,
                onPressed: () {
                  WorkshopOwnerCubit.get(context)
                      .getInformationNotificationForWorkshop(
                          token: token, id: list['pk']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InformationNotificationWorkshopScreen(),
                    ),
                  );
                },
                height: 40,
                width: double.infinity,
                background: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );

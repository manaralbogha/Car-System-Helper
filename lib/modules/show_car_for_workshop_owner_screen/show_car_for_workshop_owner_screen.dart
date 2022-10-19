import 'package:car/layout/home_layout_workshop_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_workshop_owner/cubit/states.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class show_car_for_workshop_owner_screen extends StatelessWidget {
  const show_car_for_workshop_owner_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkshopOwnerCubit, WorkshopOwnerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final String token = CacheHelper.getData(key: 'token');
        WorkshopOwnerCubit cubit = WorkshopOwnerCubit.get(context);
        var carInfo = cubit.carInfo;
        return Scaffold(
          appBar: AppBar(
            title: Text('Cars in this worksop'),
          ),
          body: ListView.separated(
              itemBuilder: (context, index) =>
                  carInfoD(carInfo[index], token, context),
              separatorBuilder: (
                context,
                index,
              ) =>
                  SizedBox(
                    height: 10,
                  ),
              itemCount: carInfo.length),
        );
      },
    );
  }
}

Widget carInfoD(carInfo, token, context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
// height: 230,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromARGB(150, 100, 228, 221),
              Color.fromARGB(50, 150, 201, 197),
              Color.fromARGB(150, 217, 228, 221),
            ],
          ),

// color: Colors.grey[100],

          borderRadius: BorderRadius.circular(10.0),
        ),

        padding: EdgeInsets.all(20.0),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${carInfo['carInfo']['prand_C']}',

// "/*${workshopModel!.workShopInfo.name}",

                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      '${carInfo['carInfo']['platNumber']}',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Spacer(),
                TextButton.icon(
                  onPressed: () {
                    WorkshopOwnerCubit.get(context).endingCarInWorkshop(
                        token: token,
                        platNumber: carInfo['carInfo']['platNumber']);
                    WorkshopOwnerCubit.get(context).getData(token: token);
                  },
                  icon: Icon(
                    Icons.car_rental,
                    size: 30,
                    color: Colors.green[700],
                  ),
                  label: Text(
                    'ENDING',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700]),
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
                  '${carInfo['carInfo']['UserInfo']['fisrName']}',
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
                  'Car owner number :',
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
                  '${carInfo['carInfo']['UserInfo']['phone']}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Icon(
                  Icons.phone_android,
                  color: Colors.indigo,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
              '${carInfo['start']}',
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
            Row(
              children: [
                Text(
                  '${carInfo['end']} ',
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
          ],
        ),
      ),
    );

import 'package:car/layout/home_layout_car_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_car_owner/cubit/states.dart';
import 'package:car/shared/components/components.dart';
import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkshopForCarScreen extends StatefulWidget {
  const WorkshopForCarScreen({Key? key}) : super(key: key);

  @override
  _WorkshopForCarScreenState createState() => _WorkshopForCarScreenState();
}

class _WorkshopForCarScreenState extends State<WorkshopForCarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarOwnerCubit, CarOwnerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = CarOwnerCubit.get(context);
        var list = cubit.workshopForCarOwner;

        //  var list1 = cubit.carInformationGet;
        //  print(list1);
        String? token = CacheHelper.getData(key: 'token');
        // var chek = cubit.requestChek;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "WORKSHOP FOR THE CAR",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! CarOwnerGetWorkshopForCarLoadingState,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => workshopInformation(
                      context,
                      list[index],
                      token,
                      /*list1[index] */ /*list1.length > 1 ? list1[index] : list1*/
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 0.0,
                    ),
                itemCount: cubit.workshopForCarOwner.length),
            fallback: (context) => Center(child: Text('No WorkShop')),
          ),
        );
      },
    );
  }
}

Widget workshopInformation(
  context,
  workshopForCarOwner,
  token,
) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 400.0,
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
            Center(
              child: Text(
                "${workshopForCarOwner['WS']['name']}",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            Divider(
              height: 20,
              thickness: 2,
              color: Colors.black54,
              endIndent: 50,
              indent: 50,
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                "Origin ",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            Divider(
              height: 10,
              thickness: 1,
              color: Colors.black54,
              endIndent: 100,
              indent: 100,
            ),
            Text(
              "${workshopForCarOwner['WS']['specialistID']} ",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            Center(
              child: Text(
                "Type ",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            Divider(
              height: 10,
              thickness: 1,
              color: Colors.black54,
              endIndent: 100,
              indent: 100,
            ),
            Text(
              '${workshopForCarOwner['WS']['prands']}',
              style: TextStyle(
                fontSize: 25.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Center(
              child: Text(
                "Services ",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            Divider(
              height: 10,
              thickness: 1,
              color: Colors.black54,
              endIndent: 100,
              indent: 100,
            ),
            Text(
              '${workshopForCarOwner['WS']['services']}',
              style: TextStyle(
                fontSize: 25.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Center(
              child: Text(
                "Address ",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            Divider(
              height: 10,
              thickness: 1,
              color: Colors.black54,
              endIndent: 100,
              indent: 100,
            ),
            Text(
              '${workshopForCarOwner['WS']['address_WS']}',
              style: TextStyle(
                fontSize: 25.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 20,
              thickness: 1,
              color: Colors.black54,
            ),
            ConditionalBuilder(
              condition: workshopForCarOwner['NOTavailable'] != true,
              builder: (context) => Center(
                child: defaultButton(
                  onPressed: () {
                    CarOwnerCubit.get(context).requestForChek(
                        token: token,
                        carNumber: plantNm,
                        carName: carName,
                        workshopId: workshopForCarOwner['WS']['id']);
                  },
                  text: 'request for checkup',
                  width: 250,
                  height: 40,
                  fontSize: 14,
                ),
              ),
              fallback: (context) => Center(
                child: Text(
                  "The request has been sent successfully  ",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
            ),
          ],
        ),
      ),
    );

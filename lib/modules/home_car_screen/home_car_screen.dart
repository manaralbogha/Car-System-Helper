import 'package:car/layout/home_layout_car_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_car_owner/cubit/states.dart';
import 'package:car/modules/workshop_for_car_screen/workshop_for_car_screen.dart';
import 'package:car/shared/components/components.dart';
import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCarScreen extends StatefulWidget {
  HomeCarScreen({Key? key}) : super(key: key);

  @override
  _HomeCarScreenState createState() => _HomeCarScreenState();
}

class _HomeCarScreenState extends State<HomeCarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarOwnerCubit, CarOwnerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final String? token = CacheHelper.getData(key: 'token');
        final cubit = CarOwnerCubit.get(context);
        var list = cubit.carInformationGet;
        // print(list.toString());
        return Scaffold(
          body: ConditionalBuilder(
            condition: list.length >
                0, //state is! CarOwnerGetCarInformationLoadingState,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  carInformation(context, list[index], token),
              separatorBuilder: (context, index) => SizedBox(
                height: 0.0,
              ),
              itemCount: list.length,
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

Widget carInformation(context, carInformation, token) => Padding(
      padding: EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Container(
        //height: 283,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "${carInformation['prand_C']}",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
                color: Colors.black54,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Year :",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${carInformation['manufacturer_year']}",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Car number :",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${carInformation['platNumber']} ",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Kilometer :",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${carInformation['mileage']} ",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Color :",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ' ${carInformation['color']}',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
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
                child: defaultButton(
                  onPressed: () {
                    CarOwnerCubit.get(context).getWorkshopForCar(
                        token: token,
                        carName: carInformation['prand_C'],
                        carNumber: carInformation['platNumber']);
                    //print(carInformation['platNumber']);
                    plantNm = carInformation['platNumber'];
                    carName = carInformation['prand_C'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkshopForCarScreen(),
                      ),
                    );
                  },
                  text: "Workshop for this car",
                  width: 250,
                  height: 40,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );

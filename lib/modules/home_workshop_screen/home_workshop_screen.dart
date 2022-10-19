import 'package:car/layout/home_layout_workshop_owner/cubit/cubit.dart';
import 'package:car/layout/home_layout_workshop_owner/cubit/states.dart';
import 'package:car/models/workshop_model.dart';
import 'package:car/modules/show_car_for_workshop_owner_screen/show_car_for_workshop_owner_screen.dart';
import 'package:car/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWorkshopScreen extends StatelessWidget {
  const HomeWorkshopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkshopOwnerCubit, WorkshopOwnerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        WorkshopOwnerCubit cubit = WorkshopOwnerCubit.get(context);
        var list = cubit.workshopModel;

        /*var length = carInfo.length;*/
        return Scaffold(
            body: ConditionalBuilder(
          condition: list.length > 0,
          builder: (context) => defaultWorkShopContainer(list, context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        ));
      },
    );
  }
}

Widget defaultWorkShopContainer(workshopModel, context) =>
    SingleChildScrollView(
      child: Column(
        children: [
          Padding(
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
                  Center(
                    child: Text(
                      '${workshopModel['name']}',

                      // "/*${workshopModel!.workShopInfo.name}",

                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: Text(
                      "( ${workshopModel['specialistID']} )",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 2,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: 10.0,
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
                    '${workshopModel['prands']}',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8.0,
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
                    "${workshopModel['services']} ",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Show Cars',

                        // "/*${workshopModel!.workShopInfo.name}",

                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      ),
                      Spacer(),
                      Icon(
                        Icons.car_repair,
                        size: 50,
                        color: workshopModel['isFull'] == true
                            ? Colors.red[600]
                            : Colors.green[600],
                      ),
                      Text(
                        '${workshopModel['capacity']}',

                        // "/*${workshopModel!.workShopInfo.name}",

                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: workshopModel['isFull'] == true
                                ? Colors.red[600]
                                : Colors.green[600]),
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    endIndent: 110,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                show_car_for_workshop_owner_screen(),
                          ),
                        );
                      },
                      text: ('View details'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );

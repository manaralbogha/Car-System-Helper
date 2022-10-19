import 'package:car/models/home_without_login_model.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = 50.0,
  double fontSize = 20.0,
  Color background = Colors.indigo,
  required VoidCallback onPressed,
  required String text,
  Color textColor = Colors.white,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: background,
      ),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: fontSize,
            letterSpacing: 2,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

//00000000000000000000000000000000000000000000000000000

Widget defaultFormField({
  Color color = Colors.black,
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator validator,
  required String labelText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  bool obscureText = false,
  VoidCallback? onTap,
  VoidCallback? onPressed,
  VoidCallback? onSubmit,
}) =>
    TextFormField(
      onFieldSubmitted: (value) => onSubmit,
      cursorColor: Colors.indigo,
      obscureText: obscureText,
      style: TextStyle(color: color),
      controller: controller,
      keyboardType: type,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.indigo),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(
                  suffixIcon,
                  color: Colors.indigo,
                ),
              )
            : null,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.indigo,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
//0000000000000000000000000000000000000000000000000000000
/*
cubit.screens[cubit.currentIndex],
bottomNavigationBar: BottomNavigationBar(
//type: BottomNavigationBarType.fixed,
currentIndex: cubit.currentIndex,
onTap: (index) {
cubit.changeBottomNavBat(index);
},
items: cubit.bottomItems,
),*/
//00000000000000000000000000000000000000000000000000000000
Widget defaultContainer(home) => Padding(
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
                '${home['name']}',
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
              "${home['specialistID']}",
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
              '${home['prands']}',
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
              '${home['services']} ',
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
              '${home['address_WS']} ',
              style: TextStyle(
                fontSize: 25.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

/*  Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromARGB(150, 217, 228, 221),
              Color.fromARGB(50, 205, 201, 197),
              Color.fromARGB(150, 217, 228, 221),
            ],
          ),
          // color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${shop['name']}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 150, 37),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
// height: 20,
                thickness: 2,
//indent: 25,
                endIndent: 150,
                color: Colors.black54,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${shop['address_WS']}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(150, 68, 68, 68),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Text(
                    '${shop['specialistID']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(150, 68, 68, 68),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    '${shop['type']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(150, 68, 68, 68),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                '${shop['service']}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(150, 68, 68, 68),
                ),
              ),
            ],
          ),
        ),
      ),
    );*/
//0000000000000000000000000000000000000000000000000000000
/* Container(
                  padding: EdgeInsets.only(
                    top: 4,
                    right: 4,
                    bottom: 4,
                  ),
                  width: 80,
                  child: MaterialButton(
                    color: Colors.grey.shade800,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    //minWidth: double.infinity,
                    onPressed: () {},
                    child: Text(
                      "SING UP",
                      style: TextStyle(
                          letterSpacing: 0,
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: ,
                  width: 80,
                  padding: EdgeInsets.only(top: 4, right: 4, bottom: 4),
                  child: MaterialButton(
                    color: Colors.green.shade700,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    //minWidth: double.infinity,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInScreen()),
                      );
                    },
                    child: Text(
                      "LOG IN",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),*/

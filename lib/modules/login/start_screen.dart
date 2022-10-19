import 'package:car/modules/login/loginscreen.dart';
import 'package:car/modules/rigister/register_screen.dart';

import 'package:car/shared/components/components.dart';
import 'package:flutter/material.dart';

class start_screen extends StatelessWidget {
  const start_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //color: Colors.cyanAccent[100],
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defaultButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                  );
                },
                text: ("login"),
                // background: Colors.white,
                //textColor: Colors.cyanAccent,
              ),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register_screen(),
                    ),
                  );
                },
                text: ("register"),
                //background: Colors.cyanAccent.shade100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

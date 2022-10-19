import 'package:car/modules/login/loginscreen.dart';
import 'package:car/modules/rigister/cubit/cubit.dart';
import 'package:car/modules/rigister/cubit/states.dart';
import 'package:car/shared/components/components.dart';
import 'package:car/shared/components/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class Register_screen extends StatefulWidget {
  const Register_screen({Key? key}) : super(key: key);

  @override
  State<Register_screen> createState() => _Register_screenState();
}

class _Register_screenState extends State<Register_screen> {
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Center(
          child: Text(
            item,
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );
  final items = ['Car owner', 'Workshop owner'];
  String? value = 'Car owner';
  DropdownMenuItem<String> buildMenuItemOrigin(dynamic item) =>
      DropdownMenuItem(
        value: item,
        child: Center(
          child: Text(
            item,
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      );

  String? originValue = 'Britain';

  bool isPassword = true;
  bool confirmationPassword = true;
  //List<String> selected = [];

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var numberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmationPasswordController = TextEditingController();
  var nameWorkshopController = TextEditingController();
  var addressWorkshopController = TextEditingController();
  var capacityWorkshopController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  //00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
  static List<Car> car = [
    Car(id: 1, nameCar: 'Audi'),
    Car(id: 2, nameCar: "BMW"),
    Car(id: 3, nameCar: "Bugatti"),
    Car(id: 4, nameCar: "Chery"),
    Car(id: 5, nameCar: "Daewoo"),
    Car(id: 6, nameCar: 'Datsun'),
    Car(id: 7, nameCar: "Dodge"),
    Car(id: 8, nameCar: "Ferrari"),
    Car(id: 9, nameCar: "Fiat"),
    Car(id: 10, nameCar: "Ford"),
    Car(id: 11, nameCar: 'Great Wall'),
    Car(id: 12, nameCar: "Jeep"),
    Car(id: 13, nameCar: "Kia"),
    Car(id: 14, nameCar: "Mercedes-Benz"),
    Car(id: 15, nameCar: "Nissan"),
    Car(id: 16, nameCar: 'Porsche'),
    Car(id: 17, nameCar: "Renault"),
    Car(id: 18, nameCar: "Subaru"),
    Car(id: 19, nameCar: "Suzuki"),
    Car(id: 20, nameCar: "Volkswagen"),
  ];
  final _items =
      car.map((car) => MultiSelectItem<Car>(car, car.nameCar)).toList();
  List<Car?> selectedCarType = [];

  late final List<String> carName;

  //00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
  static List<Service> service1 = [
    Service(id: 1, service: 'Electricity'),
    Service(id: 2, service: "Mechanical"),
    Service(id: 3, service: "paint"),
    Service(id: 4, service: 'Upholstery'),
    Service(id: 5, service: "Tire Repair"),
  ];
  final _serviceItems = service1
      .map((service) => MultiSelectItem<Service>(service, service.service))
      .toList();
  List<Service?> selectedService = [];
  late final List<String> serviceName;
  //***********************************************************************************************

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit()..getDataOrigin(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModelCarOwner.status) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInScreen(),
                  ),
                  (Route<dynamic> rout) => false);
            } else {
              print(state.registerModelCarOwner.data.message.toString());
            }
          }
          if (state is RegisterWorkshopSuccessState) {
            if (state.registerModelWorkshop.status) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInScreen(),
                  ),
                  (Route<dynamic> rout) => false);
            } else {
              print(state.registerModelWorkshop.data.message.toString());
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          var list = cubit.origin;
          // listW = cubit.workShop;
          /* var car1 = cubit.car;
          List<Car> car = []car1 as List<Car>;
          final _items =
              car.map((car) => MultiSelectItem<Car>(car, car.nameCar)).toList();*/

          return Scaffold(
            //backgroundColor: Colors.lightBlueAccent.shade100,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          "SIGN UP",
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        defaultFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                          prefixIcon: Icons.person,
                          labelText: "First Name",
                          controller: firstNameController,
                          type: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your last name";
                            }
                            return null;
                          },
                          prefixIcon: Icons.person,
                          labelText: "Last Name",
                          controller: lastNameController,
                          type: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your phone number";
                            }
                            return null;
                          },
                          prefixIcon: Icons.phone_android,
                          labelText: " Phone number",
                          controller: numberController,
                          type: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "email must not be empty";
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          prefixIcon: Icons.email_outlined,
                          labelText: " Email",
                          controller: emailController,
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password must not be empty";
                            }
                            return null;
                          },
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: isPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          labelText: "Password",
                          controller: passwordController,
                          type: TextInputType.emailAddress,
                          obscureText: isPassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your confirmation password";
                            }
                            print(passwordController.text);
                            print(confirmationPasswordController.text);
                            if (passwordController.text !=
                                confirmationPasswordController.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                          suffixIcon: confirmationPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          onPressed: () {
                            setState(() {
                              confirmationPassword = !confirmationPassword;
                            });
                          },
                          prefixIcon: Icons.lock_outline,
                          labelText: " Confirmation Password",
                          controller: confirmationPasswordController,
                          type: TextInputType.visiblePassword,
                          obscureText: confirmationPassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: value,
                              isExpanded: true,
                              iconSize: 30,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.indigo,
                              ),
                              items: items.map(buildMenuItem).toList(),
                              onChanged: (value) => setState(
                                () {
                                  this.value = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: value == 'Workshop owner',
                          builder: (context) => Column(
                            // key: _multiSelectKey,
                            children: [
                              defaultFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your workshop name";
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.home_work_outlined,
                                labelText: "Workshop Name",
                                controller: nameWorkshopController,
                                type: TextInputType.name,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              defaultFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your address";
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.home_outlined,
                                labelText: "Workshop address",
                                controller: addressWorkshopController,
                                type: TextInputType.streetAddress,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              defaultFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your workShop capacity";
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.format_size_outlined,
                                labelText: "Workshop capacity",
                                controller: capacityWorkshopController,
                                type: TextInputType.number,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: originValue,
                                    isExpanded: true,
                                    iconSize: 30,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.indigo,
                                    ),
                                    items:
                                        list.map(buildMenuItemOrigin).toList(),
                                    onChanged: (value) => setState(
                                      () {
                                        this.originValue = value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.indigo,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    MultiSelectBottomSheetField(
                                      initialChildSize: 0.4,
                                      listType: MultiSelectListType.CHIP,
                                      searchable: true,
                                      buttonText: Text(
                                        "Select car type",
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      title: Text(
                                        "Car type",
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      items: _items,
                                      onConfirm: (values) {
                                        var lll = values.cast<Car>();
                                        selectedCarType = lll;
                                        carName = selectedCarType
                                            .map((e) => e!.nameCar)
                                            .toList();
                                      },
                                      chipDisplay: MultiSelectChipDisplay(
                                        onTap: (value) {
                                          setState(() {
                                            selectedCarType.remove(value);
                                          });
                                        },
                                      ),
                                    ),
                                    selectedCarType == null ||
                                            selectedCarType.isEmpty
                                        ? Container(
                                            padding: EdgeInsets.all(10),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "None selected",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ))
                                        : Container(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.indigo,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    MultiSelectBottomSheetField(
                                      initialChildSize: 0.4,
                                      listType: MultiSelectListType.CHIP,
                                      searchable: true,
                                      buttonText: Text(
                                        "Select service",
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      title: Text(
                                        "Service",
                                        style: TextStyle(
                                            fontSize: 19,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      items: _serviceItems,
                                      onConfirm: (values) {
                                        var ooo = values.cast<Service>();
                                        selectedService = ooo;
                                        serviceName = selectedService
                                            .map((e) => e!.service)
                                            .toList();

                                        // as List<Service>
                                      },
                                      chipDisplay: MultiSelectChipDisplay(
                                        onTap: (value) {
                                          setState(() {
                                            selectedService.remove(value);
                                          });
                                        },
                                      ),
                                    ),
                                    selectedService == null ||
                                            selectedService.isEmpty
                                        ? Container(
                                            padding: EdgeInsets.all(10),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "None selected",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ))
                                        : Container(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          fallback: (context) => SizedBox(
                            height: 10,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (value == 'Car owner') {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context)
                                      .userCarOwnerRegister(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    phone: numberController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmationPassword:
                                        confirmationPasswordController.text,
                                    type: value.toString(),
                                  );
                                }
                              } else if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userWorkshopRegister(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  phone: numberController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  type: value.toString(),
                                  workshopName: nameWorkshopController.text,
                                  workshopAddress:
                                      addressWorkshopController.text,
                                  workshopCapacity:
                                      capacityWorkshopController.text,
                                  workshopOrigin: originValue.toString(),
                                  workshopCarType: carName.toList(),
                                  workshopService: serviceName.toList(),
                                );

                                print(carName);

                                print(serviceName);
                              }
                            }, // print(nameController.text);

                            text: ("sign up"),
                            //background: Colors.cyanAccent.shade100,
                          ),
                          fallback: (context) => CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Car {
  late int id;
  late String nameCar;

  Car({
    required this.id,
    required this.nameCar,
  });
  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameCar = json['name'];
  }
}

class Service {
  final int id;
  final String service;

  Service({
    required this.id,
    required this.service,
  });
}

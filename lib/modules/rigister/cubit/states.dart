import 'package:car/models/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  late final RegisterModel registerModelCarOwner;
  RegisterSuccessState(this.registerModelCarOwner);
}

class RegisterErrorState extends RegisterStates {}

class RegisterWorkshopLoadingState extends RegisterStates {}

class RegisterWorkshopSuccessState extends RegisterStates {
  late final RegisterModel registerModelWorkshop;
  RegisterWorkshopSuccessState(this.registerModelWorkshop);
}

class RegisterWorkshopErrorState extends RegisterStates {}

class GetDataOriginSuccessState extends RegisterStates {}

class GetDataOriginErrorState extends RegisterStates {
  final String error;
  GetDataOriginErrorState(this.error);
}

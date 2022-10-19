abstract class CarStates {}

class CarInitalState extends CarStates {}

class CarBottomNavState extends CarStates {}

class GetDataLoadingState extends CarStates {}

class GetDataSuccessState extends CarStates {}

class GetDataErrorState extends CarStates {
  final String error;
  GetDataErrorState(this.error);
}

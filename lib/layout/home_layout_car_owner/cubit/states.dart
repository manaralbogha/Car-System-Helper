abstract class CarOwnerStates {}

class CarOwnerInitialState extends CarOwnerStates {}

class CarOwnerBottomNavState extends CarOwnerStates {}

class CarOwnerOnChangedDropdownButtonCarType extends CarOwnerStates {}

class CarOwnerOnChangedIconEdit extends CarOwnerStates {}

class CarOwnerOnChangedIconAdd extends CarOwnerStates {}

class CarOwnerOnChangedDropdownButtonColor extends CarOwnerStates {}

class CarOwnerLoadingState extends CarOwnerStates {}

class CarOwnerSuccessState extends CarOwnerStates {}

class CarOwnerErrorState extends CarOwnerStates {
  final String error;
  CarOwnerErrorState(this.error);
}

class CarOwnerGetCarInformationLoadingState extends CarOwnerStates {}

class CarOwnerGetCarInformationSuccessState extends CarOwnerStates {}

class CarOwnerGetCarInformationErrorState extends CarOwnerStates {
  final String error;
  CarOwnerGetCarInformationErrorState(this.error);
}

class CarOwnerGetWorkshopForCarLoadingState extends CarOwnerStates {}

class CarOwnerGetWorkshopForCarSuccessState extends CarOwnerStates {}

class CarOwnerGetWorkshopForCarErrorState extends CarOwnerStates {
  final String error;
  CarOwnerGetWorkshopForCarErrorState(this.error);
}

class CarOwnerUpdateCarScreenSuccessState extends CarOwnerStates {}

class CarOwnerUpdateCarListViewScreenSuccessState extends CarOwnerStates {}

class CarOwnerRequestForChekLoadingState extends CarOwnerStates {}

class CarOwnerRequestForChekSuccessState extends CarOwnerStates {}

class CarOwnerRequestForChekErrorState extends CarOwnerStates {
  final String error;
  CarOwnerRequestForChekErrorState(this.error);
}

class GetNotificationForCarLoadingState extends CarOwnerStates {}

class GetNotificationForCarSuccessState extends CarOwnerStates {}

class GetNotificationForCarErrorState extends CarOwnerStates {
  final String error;
  GetNotificationForCarErrorState(this.error);
}

class GetInformationNotificationForCarLoadingState extends CarOwnerStates {}

class GetInformationNotificationForCarSuccessState extends CarOwnerStates {}

class GetInformationNotificationForCarErrorState extends CarOwnerStates {
  final String error;
  GetInformationNotificationForCarErrorState(this.error);
}

class OkOrNoForCheckCarLoadingState extends CarOwnerStates {}

class OkOrNoForCheckCarSuccessState extends CarOwnerStates {}

class OkOrNoForCheckCarErrorState extends CarOwnerStates {
  final String error;
  OkOrNoForCheckCarErrorState(this.error);
}

class OkOrNoForEvaluateLoadingState extends CarOwnerStates {}

class OkOrNoForEvaluateSuccessState extends CarOwnerStates {}

class OkOrNoForEvaluateErrorState extends CarOwnerStates {
  final String error;
  OkOrNoForEvaluateErrorState(this.error);
}

class NewRequestCarLoadingState extends CarOwnerStates {}

class NewRequestCarSuccessState extends CarOwnerStates {}

class NewRequestCarErrorState extends CarOwnerStates {
  final String error;
  NewRequestCarErrorState(this.error);
}

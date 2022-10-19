abstract class WorkshopOwnerStates {}

class WorkshopOwnerInitialState extends WorkshopOwnerStates {}

class WorkshopOwnerBottomNavState extends WorkshopOwnerStates {}

class GetWorkshopDataLoadingState extends WorkshopOwnerStates {}

class GetWorkshopDataSuccessState extends WorkshopOwnerStates {}

class GetWorkshopDataErrorState extends WorkshopOwnerStates {
  final String error;
  GetWorkshopDataErrorState(this.error);
}

class WorkshopOnPressedOnOkSuccessState extends WorkshopOwnerStates {}

class GetNotificationForWorkshopLoadingState extends WorkshopOwnerStates {}

class GetNotificationForWorkshopSuccessState extends WorkshopOwnerStates {}

class GetNotificationForWorkshopErrorState extends WorkshopOwnerStates {
  final String error;
  GetNotificationForWorkshopErrorState(this.error);
}

class GetInformationNotificationForWorkshopLoadingState
    extends WorkshopOwnerStates {}

class GetInformationNotificationForWorkshopSuccessState
    extends WorkshopOwnerStates {}

class GetInformationNotificationForWorkshopErrorState
    extends WorkshopOwnerStates {
  final String error;
  GetInformationNotificationForWorkshopErrorState(this.error);
}

class OkOrNoForCheckWorkshopLoadingState extends WorkshopOwnerStates {}

class OkOrNoForCheckWorkshopSuccessState extends WorkshopOwnerStates {}

class OkOrNoForCheckWorkshopErrorState extends WorkshopOwnerStates {
  final String error;
  OkOrNoForCheckWorkshopErrorState(this.error);
}

class EvaluationWorkshopLoadingState extends WorkshopOwnerStates {}

class EvaluationWorkshopSuccessState extends WorkshopOwnerStates {}

class EvaluationWorkshopErrorState extends WorkshopOwnerStates {
  final String error;
  EvaluationWorkshopErrorState(this.error);
}

class NewRequestWorkshopLoadingState extends WorkshopOwnerStates {}

class NewRequestWorkshopSuccessState extends WorkshopOwnerStates {}

class NewRequestWorkshopErrorState extends WorkshopOwnerStates {
  final String error;
  NewRequestWorkshopErrorState(this.error);
}

class EndingCarInWorkshopLoadingState extends WorkshopOwnerStates {}

class EndingCarInWorkshopSuccessState extends WorkshopOwnerStates {}

class EndingCarInWorkshopErrorState extends WorkshopOwnerStates {
  final String error;
  EndingCarInWorkshopErrorState(this.error);
}

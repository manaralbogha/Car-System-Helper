import 'package:car/models/login_model.dart';
import 'package:car/modules/login/cubit/states.dart';
import 'package:car/shared/components/constants.dart';
import 'package:car/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: '${url}login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      print('manar');

      loginModel = LoginModel.fromJson(value.data);
      //loginModelForHomeCarOwner = loginModel;
      print(loginModel.data.type);
      print(loginModel.status);
      print(loginModel.data.message);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());

      emit(LoginErrorState(error.toString()));
    });
  }
}

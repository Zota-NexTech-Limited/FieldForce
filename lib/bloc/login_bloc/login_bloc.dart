import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldforce/dao/auth_dao.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/local_constant.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late AuthDao authDao;
  LoginBloc() : super(LoginInitial()) {
    authDao=AuthDao();
    on<LoginWithEmailEvent>((event, emit) async{
      await mapLoginWithEmailEvent(event, emit);
    });
  }

  Future<void> mapLoginWithEmailEvent(
      LoginWithEmailEvent event, Emitter<LoginState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const LoginWithEmailLoadingState());

      print("------------------2--------------------");
      var response = await authDao.login(userEmail: event.email,password: event.password);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        String message = jsonDecoded["message"];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String accessToken=jsonDecoded["data"]["token"];
        String userName=jsonDecoded["data"]["user_name"];
        //String userRole=jsonDecoded["data"]["user_role"];
        String userEmail=jsonDecoded["data"]["user_email"];
        String userPhoneNumber=jsonDecoded["data"]["user_phone_number"];
        //String userDepartment=jsonDecoded["data"]["user_department"];


        Config.accessToken=jsonDecoded["data"]["token"];
        Config.userName = userName;
        //Config.userRole =userRole;
        Config.userEmail = userEmail;
        Config.userPhoneNumber =userPhoneNumber;
        //Config.userDepartment =userDepartment;
        print("accessToken----------------------------------$accessToken");


        await prefs.setString(LocalConstant.accessToken, accessToken);
        await prefs.setString(LocalConstant.userName, userName);
        //await prefs.setString(LocalConstant.userRole, userRole);
        await prefs.setString(LocalConstant.userEmail, userEmail);
        await prefs.setString(LocalConstant.userPhoneNumber, userPhoneNumber);
        //await prefs.setString(LocalConstant.userDepartment, userDepartment);

        emit(LoginWithEmailSuccessState(message:message ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");

        emit(LoginWithEmailFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(LoginWithEmailFailedState(message: message));
      }

    }catch(error){
      print("The error of Login  : $error");
      emit(LoginWithEmailFailedState(message: "Something went wrong"));
    }
  }
}

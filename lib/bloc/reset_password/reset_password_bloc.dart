import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/dao/auth_dao.dart';
import 'package:meta/meta.dart';


part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  late AuthDao authDao;
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    authDao=AuthDao();
    on<TriggerResetPasswordEvent>((event, emit) async{
      await mapTriggerResetPasswordEvent(event, emit);
    });
  }


  Future<void> mapTriggerResetPasswordEvent(
      TriggerResetPasswordEvent event, Emitter<ResetPasswordState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const ResetPasswordLoadingState());

      print("------------------2--------------------");
      var response = await authDao.resetPassword(userEmail: event.email);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        String message = jsonDecoded["message"];
        emit(ResetPasswordSuccessState(message:message ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");

        emit(ResetPasswordFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(ResetPasswordFailedState(message: message));
      }

    }catch(error){
      print("The error in Reset Password Failed State  : $error");
      emit(ResetPasswordFailedState(message: "Something went wrong"));
    }
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/dao/leave_dao.dart';
import 'package:fieldsales/models/leave/leave_model.dart';
import 'package:meta/meta.dart';

part 'add_leave_event.dart';
part 'add_leave_state.dart';

class AddLeaveBloc extends Bloc<AddLeaveEvent, AddLeaveState>  {
  late LeaveDao leaveDao;
  AddLeaveBloc() : super(AddLeaveInitial()) {
    leaveDao=LeaveDao();
    on<AddNewLeaveEvent>((event, emit) async{
      await mapCreateNewLeaveEvent(event, emit);
    });
  }


  Future<void> mapCreateNewLeaveEvent(
      AddNewLeaveEvent event, Emitter<AddLeaveState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const AddLeaveLoadingState());

      print("------------------2--------------------");
      var response = await leaveDao.addLeave(leaveDetails: event.leaveDetails);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){

        String message = jsonDecoded["message"];
        emit(AddLeaveSuccessState(message:message));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(AddLeaveFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(AddLeaveFailedState(message: message));
      }

    }catch(error){
      print("The error of Create Add Leave Failed State  : $error");
      emit(const AddLeaveFailedState(message: "Something went wrong"));
    }
  }
}

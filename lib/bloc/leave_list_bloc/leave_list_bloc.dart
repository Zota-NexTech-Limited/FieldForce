import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/dao/leave_dao.dart';
import 'package:fieldsales/models/leave/leave_model.dart';
import 'package:meta/meta.dart';

part 'leave_list_event.dart';
part 'leave_list_state.dart';

class LeaveListBloc extends Bloc<LeaveListEvent, LeaveListState> {
  late LeaveDao leaveDao;
  LeaveListBloc() : super(LeaveListInitial()) {
    leaveDao=LeaveDao();
    on<FetchLeaveListEvent>((event, emit) async{
      await mapFetchLeaveListEvent(event, emit);
    });
  }

  Future<void> mapFetchLeaveListEvent(
      FetchLeaveListEvent event, Emitter<LeaveListState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const LeaveListLoadingState());

      print("------------------2--------------------");
      var response = await leaveDao.leaveList();

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        print("------------------5--------------------");
        List<LeaveModel> leaveList=[];
        for(var item in jsonDecoded['data'])
        {
          leaveList.add(LeaveModel.fromJson(item));
        }


        print("------------------6--------------------");

        emit(LeaveListSuccessState(leaveList: leaveList ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(LeaveListFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(LeaveListFailedState(message: message));
      }

    }catch(error){
      print("The error of Leave List Failed State : $error");
      emit(LeaveListFailedState(message: "Something went wrong"));
    }
  }
}

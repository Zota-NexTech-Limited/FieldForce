import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldforce/dao/my_activity_dao.dart';
import 'package:fieldforce/models/my_activity_models/activiti_list_model.dart';
import 'package:meta/meta.dart';

part 'activity_list_event.dart';
part 'activity_list_state.dart';

class ActivityListBloc extends Bloc<ActivityListEvent, ActivityListState> {
  late MyActivityDao myActivityDao;
  ActivityListBloc() : super(ActivityListInitial()) {
    myActivityDao=MyActivityDao();
    on<FetchActivityListEvent>((event, emit) async{
      await mapFetchActivityListEvent(event, emit);
    });
  }

  Future<void> mapFetchActivityListEvent(
      FetchActivityListEvent event, Emitter<ActivityListState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const ActivityListLoadingState());

      print("------------------2--------------------");
      var response = await myActivityDao.activityList();

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        print("------------------5--------------------");
        List<ActivityListModel> leadList=[];
        for(var item in jsonDecoded['data'])
        {
          leadList.add(ActivityListModel.fromJson(item));
        }


        print("------------------6--------------------");

        emit(ActivityListSuccessState(activityList: leadList ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(ActivityListFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(ActivityListFailedState(message: message));
      }

    }catch(error){
      print("The error of Activity List Failed State : $error");
      emit(ActivityListFailedState(message: "Something went wrong"));
    }
  }
}

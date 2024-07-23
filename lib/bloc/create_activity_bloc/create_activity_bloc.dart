import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldforce/dao/cmr_dao.dart';
import 'package:fieldforce/models/crm_models/create_activity_model.dart';
import 'package:meta/meta.dart';

part 'create_activity_event.dart';
part 'create_activity_state.dart';

class CreateActivityBloc extends Bloc<CreateActivityEvent, CreateActivityState> {
  late CmrDao cmrDao;
  CreateActivityBloc() : super(CreateActivityInitial()) {
    cmrDao=CmrDao();
    on<CreateNewActivityEvent>((event, emit) async{
      await mapCreateNewActivityEvent(event, emit);
    });
  }


  Future<void> mapCreateNewActivityEvent(
      CreateNewActivityEvent event, Emitter<CreateActivityState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const CreateActivityLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.createActivity(activityDetails: event.activityDetails);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){

        String message = jsonDecoded["message"];
        emit(CreateActivitySuccessState(message:message));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(CreateActivityFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(CreateActivityFailedState(message: message));
      }

    }catch(error){
      print("The error of Create Activity Failed State  : $error");
      emit(const CreateActivityFailedState(message: "Something went wrong"));
    }
  }
}

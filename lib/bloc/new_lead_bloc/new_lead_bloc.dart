import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/dao/cmr_dao.dart';
import 'package:fieldsales/models/crm_models/new_lead_model.dart';
import 'package:meta/meta.dart';

part 'new_lead_event.dart';
part 'new_lead_state.dart';

class NewLeadBloc extends Bloc<NewLeadEvent, NewLeadState> {
  late CmrDao cmrDao;
  NewLeadBloc() : super(NewLeadInitial()) {
    cmrDao=CmrDao();
    on<PostNewLeadEvent>((event, emit) async{
      await mapPostNewLeadEvent(event, emit);
    });
  }

  Future<void> mapPostNewLeadEvent(
      PostNewLeadEvent event, Emitter<NewLeadState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const NewLeadLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.newLead(leadDetails: event.leadDetails);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){

        String message = jsonDecoded["message"];
        emit(NewLeadSuccessState(message:message));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(NewLeadFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(NewLeadFailedState(message: message));
      }

    }catch(error){
      print("The error of new lead Failed State  : $error");
      emit(const NewLeadFailedState(message: "Something went wrong"));
    }
  }

}

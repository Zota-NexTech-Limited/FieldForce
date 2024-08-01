import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldforce/dao/cmr_dao.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:meta/meta.dart';

part 'edit_lead_event.dart';
part 'edit_lead_state.dart';

class EditLeadBloc extends Bloc<EditLeadEvent, EditLeadState> {
  late CmrDao cmrDao;
  EditLeadBloc() : super(EditLeadInitial()) {
    cmrDao=CmrDao();
    on<TriggerEditLeadEvent>((event, emit) async{
      await mapTriggerEditLeadEvent(event, emit);
    });
  }

  Future<void> mapTriggerEditLeadEvent(
      TriggerEditLeadEvent event, Emitter<EditLeadState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const EditLeadLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.editLead(leadDetails: event.leadDetails);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){

        NewLeadModel leadDetails=NewLeadModel();
        leadDetails=NewLeadModel.fromJson(jsonDecoded["data"]);
        String message = jsonDecoded["message"];
        emit(EditLeadSuccessState(message:message,leadDetails:leadDetails ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(EditLeadFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(EditLeadFailedState(message: message));
      }

    }catch(error){
      print("The error of Edit Lead Failed State : $error");
      emit(const EditLeadFailedState(message: "Something went wrong"));
    }
  }
}

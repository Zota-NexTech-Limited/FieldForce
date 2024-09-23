import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/dao/cmr_dao.dart';
import 'package:fieldsales/models/crm_models/opportinuty_model.dart';
import 'package:meta/meta.dart';

part 'edit_opportunity_event.dart';
part 'edit_opportunity_state.dart';

class EditOpportunityBloc extends Bloc<EditOpportunityEvent, EditOpportunityState> {
  late CmrDao cmrDao;
  EditOpportunityBloc() : super(EditOpportunityInitial()) {
    cmrDao=CmrDao();
    on<TriggerEditOpportunityEvent>((event, emit) async{
      await mapTriggerEditOpportunityEvent(event, emit);
    });
  }

  Future<void> mapTriggerEditOpportunityEvent(
      TriggerEditOpportunityEvent event, Emitter<EditOpportunityState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const EditOpportunityLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.editOpportunity(opportunityDetails: event.opportunityDetails);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){

        OpportunityDetailsModel opportunityDetails=OpportunityDetailsModel();
        opportunityDetails=OpportunityDetailsModel.fromJson(jsonDecoded["data"]);
        String message = jsonDecoded["message"];
        emit(EditOpportunitySuccessState(message:message,opportunityDetails:opportunityDetails ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(EditOpportunityFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(EditOpportunityFailedState(message: message));
      }

    }catch(error){
      print("The error of Edit Opportunity Failed State : $error");
      emit(const EditOpportunityFailedState(message: "Something went wrong"));
    }
  }
}

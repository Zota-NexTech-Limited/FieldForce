import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/dao/cmr_dao.dart';
import 'package:fieldsales/models/crm_models/opportinuty_model.dart';
import 'package:meta/meta.dart';

part 'get_opportunity_by_id_event.dart';
part 'get_opportunity_by_id_state.dart';

class GetOpportunityByIdBloc extends Bloc<GetOpportunityByIdEvent, GetOpportunityByIdState> {
  late  CmrDao cmrDao;
  GetOpportunityByIdBloc() : super(GetOpportunityByIdInitial()) {
    cmrDao=CmrDao();
    on<TriggerGetOpportunityByIdEvent>((event, emit) async{
      await mapTriggerGetOpportunityByIdEvent(event, emit);
    });
  }

  Future<void> mapTriggerGetOpportunityByIdEvent(
      TriggerGetOpportunityByIdEvent event, Emitter<GetOpportunityByIdState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const GetOpportunityByIdLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.getOpportunityById(id: event.id);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        print("------------------5--------------------");
        OpportunityDetailsModel opportunityDetails=OpportunityDetailsModel();
         opportunityDetails=OpportunityDetailsModel.fromJson(jsonDecoded['data']);
      


        print("------------------6--------------------");

        emit(GetOpportunityByIdSuccessState(opportunityDetails:opportunityDetails));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(GetOpportunityByIdFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(GetOpportunityByIdFailedState(message: message));
      }

    }catch(error){
      print("The error of Get Opportunity By Id Failed State : $error");
      emit(GetOpportunityByIdFailedState(message: "Something went wrong"));
    }
  }

  
}

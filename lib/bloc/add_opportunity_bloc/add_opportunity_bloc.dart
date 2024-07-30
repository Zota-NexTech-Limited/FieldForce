import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldforce/dao/cmr_dao.dart';
import 'package:fieldforce/models/crm_models/opportinuty_model.dart';
import 'package:meta/meta.dart';

part 'add_opportunity_event.dart';
part 'add_opportunity_state.dart';

class AddOpportunityBloc extends Bloc<AddOpportunityEvent, AddOpportunityState> {
  late CmrDao cmrDao;
  AddOpportunityBloc() : super(AddOpportunityInitial()) {
    cmrDao=CmrDao();
    on<AddNewOpportunityEvent>((event, emit) async{
      await mapAddNewOpportunityEvent(event, emit);
    });
  }

  Future<void> mapAddNewOpportunityEvent(
      AddNewOpportunityEvent event, Emitter<AddOpportunityState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const AddOpportunityLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.addOpportunity(opportunityDetails: event.opportunityDetails);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){

        String message = jsonDecoded["message"];
        emit(AddOpportunitySuccessState(message:message));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(AddOpportunityFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(AddOpportunityFailedState(message: message));
      }

    }catch(error){
      print("The error of Add Opportunity Failed State : $error");
      emit(const AddOpportunityFailedState(message: "Something went wrong"));
    }
  }
}

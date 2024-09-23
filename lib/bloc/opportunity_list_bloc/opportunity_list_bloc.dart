import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/dao/cmr_dao.dart';
import 'package:fieldsales/models/crm_models/opportinuty_model.dart';
import 'package:meta/meta.dart';

part 'opportunity_list_event.dart';
part 'opportunity_list_state.dart';

class OpportunityListBloc extends Bloc<OpportunityListEvent, OpportunityListState> {
  late CmrDao cmrDao;
  OpportunityListBloc() : super(OpportunityListInitial()) {
    cmrDao=CmrDao();
    on<GetOpportunityListEvent>((event, emit) async{
      await mapGetOpportunityListEvent(event, emit);
    });
  }

  Future<void> mapGetOpportunityListEvent(
      GetOpportunityListEvent event, Emitter<OpportunityListState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const OpportunityListLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.opportunityList();

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        print("------------------5--------------------");
        List<OpportunityDetailsModel> opportunityList=[];
        for(var item in jsonDecoded['data'])
        {
          opportunityList.add(OpportunityDetailsModel.fromJson(item));
        }


        print("------------------6--------------------");

        emit(OpportunityListSuccessState(opportunityList: opportunityList ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(OpportunityListFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(OpportunityListFailedState(message: message));
      }

    }catch(error){
      print("The error of Opportunity List Failed State : $error");
      emit(const OpportunityListFailedState(message: "Something went wrong"));
    }
  }
}

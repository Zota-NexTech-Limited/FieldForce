import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldforce/dao/cmr_dao.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:meta/meta.dart';

part 'lead_list_event.dart';
part 'lead_list_state.dart';

class LeadListBloc extends Bloc<LeadListEvent, LeadListState> {
  late CmrDao cmrDao;
  LeadListBloc() : super(LeadListInitial()) {
    cmrDao=CmrDao();
    on<FetchLeadListEvent>((event, emit) async{
      await mapFetchLeadListEvent(event, emit);
    });
  }


  Future<void> mapFetchLeadListEvent(
      FetchLeadListEvent event, Emitter<LeadListState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const LeadListLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.leadList(fromDate: event.fromDate, toDate: event.toDate, search: event.search);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        print("------------------5--------------------");
        List<NewLeadModel> leadList=[];
        for(var item in jsonDecoded['data'])
        {
          leadList.add(NewLeadModel.fromJson(item));
        }


        print("------------------6--------------------");

        emit(LeadListSuccessState(leadList: leadList ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(LeadListFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(LeadListFailedState(message: message));
      }

    }catch(error){
      print("The error of lead  List : $error");
      emit(LeadListFailedState(message: "Something went wrong"));
    }
  }
}

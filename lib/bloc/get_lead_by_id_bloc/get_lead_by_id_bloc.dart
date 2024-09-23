import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/dao/cmr_dao.dart';
import 'package:fieldsales/models/crm_models/new_lead_model.dart';
import 'package:meta/meta.dart';

part 'get_lead_by_id_event.dart';
part 'get_lead_by_id_state.dart';

class GetLeadByIdBloc extends Bloc<GetLeadByIdEvent, GetLeadByIdState> {
  late  CmrDao cmrDao;
  GetLeadByIdBloc() : super(GetLeadByIdInitial()) {
    cmrDao=CmrDao();
    on<TriggerGetLeadByIdEvent>((event, emit) async{
      await mapTriggerGetLeadByIdEvent(event, emit);
    });
  }

  Future<void> mapTriggerGetLeadByIdEvent(
      TriggerGetLeadByIdEvent event, Emitter<GetLeadByIdState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const GetLeadByIdLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.getLeadById(id: event.id);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        print("------------------5--------------------");
        NewLeadModel leadDetails=NewLeadModel();
        leadDetails=NewLeadModel.fromJson(jsonDecoded['data']);



        print("------------------6--------------------");

        emit(GetLeadByIdSuccessState(leadDetails:leadDetails));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(GetLeadByIdFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(GetLeadByIdFailedState(message: message));
      }

    }catch(error){
      print("The error of Get Lead By Id Failed State  : $error");
      emit(GetLeadByIdFailedState(message: "Something went wrong"));
    }
  }
}

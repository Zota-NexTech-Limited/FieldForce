import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/dao/cmr_dao.dart';
import 'package:meta/meta.dart';

part 'get_address_by_pin_code_event.dart';
part 'get_address_by_pin_code_state.dart';

class GetAddressByPinCodeBloc extends Bloc<GetAddressByPinCodeEvent, GetAddressByPinCodeState> {
  late  CmrDao cmrDao;
  GetAddressByPinCodeBloc() : super(GetAddressByPinCodeInitial()) {
    cmrDao=CmrDao();
    on<FetchAddressByPinCodeEvent>((event, emit) async{
      await mapFetchAddressByPinCodeEvent(event, emit);
    });
  }

  Future<void> mapFetchAddressByPinCodeEvent(
      FetchAddressByPinCodeEvent event, Emitter<GetAddressByPinCodeState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const FetchAddressByPinCodeLoadingState());

      print("------------------2--------------------");
      var response = await cmrDao.getAddressByPinCode(pinCode: event.pinCode);

      print("------------------3--------------------");
      List jsonDecoded = jsonDecode(response.body);
      print("in bloc ----------------------------$jsonDecoded");
      print("------------------4--------------------");

      if(jsonDecoded[0]["Status"] =="Success"){
        List<String> areaList=[];
        List<String> stateList=[];
        List<String> cityList=[];
        stateList.add(jsonDecoded[0]["PostOffice"][0]["State"]);
        cityList.add(jsonDecoded[0]["PostOffice"][0]["District"]);
        for(int i=0;i< jsonDecoded[0]["PostOffice"].length;i++)
        {
          areaList.add(jsonDecoded[0]["PostOffice"][i]["Name"]);
        }

        emit(FetchAddressByPinCodeSuccessState(areaList: areaList,cityList: cityList,stateList: stateList));

      }
      else{
        String message = jsonDecoded[0]["Message"];
        print("The failure reason: $message");
        emit(FetchAddressByPinCodeFailedState(message: message));
      }

    }catch(error){
      print("The error of Store List : $error");
      emit(FetchAddressByPinCodeFailedState(message: "Something went wrong"));
    }
  }
}

part of 'get_address_by_pin_code_bloc.dart';

@immutable
abstract class GetAddressByPinCodeState extends Equatable{
  const GetAddressByPinCodeState();
  @override
  List<Object> get props => [];
}

class GetAddressByPinCodeInitial extends GetAddressByPinCodeState {}

class FetchAddressByPinCodeLoadingState extends GetAddressByPinCodeState{
  const FetchAddressByPinCodeLoadingState();
  @override
  List<Object> get props => [];
}

class FetchAddressByPinCodeSuccessState extends GetAddressByPinCodeState{
  List<String> areaList=[];
  List<String> stateList=[];
  List<String> cityList=[];
   FetchAddressByPinCodeSuccessState({required this.areaList,required this.cityList,required this.stateList});
  @override
  List<Object> get props => [areaList,cityList,stateList];
}

class FetchAddressByPinCodeFailedState extends GetAddressByPinCodeState{
  final String message;
  const FetchAddressByPinCodeFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

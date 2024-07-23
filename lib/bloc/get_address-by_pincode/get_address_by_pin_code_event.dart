part of 'get_address_by_pin_code_bloc.dart';

@immutable
abstract class GetAddressByPinCodeEvent  extends Equatable{
  const GetAddressByPinCodeEvent();
  @override
  List<Object> get props => [];
}
class FetchAddressByPinCodeEvent  extends GetAddressByPinCodeEvent{
 final String pinCode;
 const FetchAddressByPinCodeEvent({required this.pinCode});
  @override
  List<Object> get props => [pinCode];
}

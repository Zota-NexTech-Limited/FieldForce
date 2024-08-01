part of 'get_lead_by_id_bloc.dart';

@immutable
sealed class GetLeadByIdState extends Equatable{
  const GetLeadByIdState();
  @override
  List<Object> get props => [];
}

final class GetLeadByIdInitial extends GetLeadByIdState {}

class GetLeadByIdLoadingState extends GetLeadByIdState{
  const GetLeadByIdLoadingState();
  @override
  List<Object> get props => [];
}

class GetLeadByIdSuccessState extends GetLeadByIdState{
  final NewLeadModel leadDetails;
  const GetLeadByIdSuccessState({required this.leadDetails});
  @override
  List<Object> get props => [leadDetails];
}

class GetLeadByIdFailedState extends GetLeadByIdState{
  final String message;
  const GetLeadByIdFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
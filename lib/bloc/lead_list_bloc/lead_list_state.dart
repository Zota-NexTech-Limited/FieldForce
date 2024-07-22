part of 'lead_list_bloc.dart';

@immutable
sealed class LeadListState extends Equatable{
  const LeadListState();
  @override
  List<Object> get props => [];}

final class LeadListInitial extends LeadListState {}

class LeadListLoadingState extends LeadListState{
  const LeadListLoadingState();
  @override
  List<Object> get props => [];
}

class LeadListSuccessState extends LeadListState{
  final List<NewLeadModel>leadList;
   const LeadListSuccessState({required this.leadList});
  @override
  List<Object> get props => [leadList];
}

class LeadListFailedState extends LeadListState{
  final String message;
  const LeadListFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

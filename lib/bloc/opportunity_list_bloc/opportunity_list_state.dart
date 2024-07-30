part of 'opportunity_list_bloc.dart';

@immutable
sealed class OpportunityListState extends Equatable{
  const OpportunityListState();
  @override
  List<Object> get props => [];
}

final class OpportunityListInitial extends OpportunityListState {}

class OpportunityListLoadingState extends OpportunityListState{
  const OpportunityListLoadingState();
  @override
  List<Object> get props => [];
}

class OpportunityListSuccessState extends OpportunityListState{
  final List<OpportunityDetailsModel>opportunityList;
  const OpportunityListSuccessState({required this.opportunityList});
  @override
  List<Object> get props => [opportunityList];
}

class OpportunityListFailedState extends OpportunityListState{
  final String message;
  const OpportunityListFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
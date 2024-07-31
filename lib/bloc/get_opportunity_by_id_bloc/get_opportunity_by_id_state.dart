part of 'get_opportunity_by_id_bloc.dart';

@immutable
sealed class GetOpportunityByIdState extends Equatable{
  const GetOpportunityByIdState();
  @override
  List<Object> get props => [];
}

final class GetOpportunityByIdInitial extends GetOpportunityByIdState {}


class GetOpportunityByIdLoadingState extends GetOpportunityByIdState{
  const GetOpportunityByIdLoadingState();
  @override
  List<Object> get props => [];
}

class GetOpportunityByIdSuccessState extends GetOpportunityByIdState{
  final OpportunityDetailsModel opportunityDetails;
  const GetOpportunityByIdSuccessState({required this.opportunityDetails});
  @override
  List<Object> get props => [opportunityDetails];
}

class GetOpportunityByIdFailedState extends GetOpportunityByIdState{
  final String message;
  const GetOpportunityByIdFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
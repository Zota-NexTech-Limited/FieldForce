part of 'add_opportunity_bloc.dart';

@immutable
sealed class AddOpportunityEvent extends Equatable{
  const AddOpportunityEvent();
  @override
  List<Object> get props => [];
}

class AddNewOpportunityEvent extends AddOpportunityEvent{
  final  OpportunityDetailsModel opportunityDetails;
  const AddNewOpportunityEvent({required this.opportunityDetails,});
  @override
  List<Object> get props => [opportunityDetails];
}
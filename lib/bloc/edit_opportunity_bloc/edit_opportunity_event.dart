part of 'edit_opportunity_bloc.dart';

@immutable
sealed class EditOpportunityEvent extends Equatable{
  const EditOpportunityEvent();
  @override
  List<Object> get props => [];
}

class TriggerEditOpportunityEvent extends EditOpportunityEvent{
  final  OpportunityDetailsModel opportunityDetails;
  const TriggerEditOpportunityEvent({required this.opportunityDetails,});
  @override
  List<Object> get props => [opportunityDetails];
}
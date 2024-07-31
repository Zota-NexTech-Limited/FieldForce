part of 'edit_opportunity_bloc.dart';

@immutable
sealed class EditOpportunityState extends Equatable{
  const EditOpportunityState();
  @override
  List<Object> get props => [];
}

final class EditOpportunityInitial extends EditOpportunityState {}

class EditOpportunityLoadingState extends EditOpportunityState{
  const EditOpportunityLoadingState();
  @override
  List<Object> get props => [];
}

class EditOpportunitySuccessState extends EditOpportunityState{
  final String message;
  final OpportunityDetailsModel opportunityDetails;
  const EditOpportunitySuccessState({required this.message,required this.opportunityDetails});
  @override
  List<Object> get props => [message,opportunityDetails];
}

class EditOpportunityFailedState extends EditOpportunityState{
  final String message;
  const EditOpportunityFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
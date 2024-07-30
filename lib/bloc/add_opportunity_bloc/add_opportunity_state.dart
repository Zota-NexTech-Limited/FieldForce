part of 'add_opportunity_bloc.dart';

@immutable
sealed class AddOpportunityState extends Equatable{
  const AddOpportunityState();
  @override
  List<Object> get props => [];
}

final class AddOpportunityInitial extends AddOpportunityState {}


class AddOpportunityLoadingState extends AddOpportunityState{
  const AddOpportunityLoadingState();
  @override
  List<Object> get props => [];
}

class AddOpportunitySuccessState extends AddOpportunityState{
  final String message;
  const AddOpportunitySuccessState({required this.message,});
  @override
  List<Object> get props => [message];
}

class AddOpportunityFailedState extends AddOpportunityState{
  final String message;
  const AddOpportunityFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
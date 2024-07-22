part of 'new_lead_bloc.dart';

@immutable
sealed class NewLeadState extends Equatable{
  const NewLeadState();
  @override
  List<Object> get props => [];
}

final class NewLeadInitial extends NewLeadState {}


class NewLeadLoadingState extends NewLeadState{
  const NewLeadLoadingState();
  @override
  List<Object> get props => [];
}

class NewLeadSuccessState extends NewLeadState{
  final String message;
  const NewLeadSuccessState({required this.message,});
  @override
  List<Object> get props => [message];
}

class NewLeadFailedState extends NewLeadState{
  final String message;
  const NewLeadFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
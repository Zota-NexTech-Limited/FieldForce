part of 'edit_lead_bloc.dart';

@immutable
sealed class EditLeadState extends Equatable{
  const EditLeadState();
  @override
  List<Object> get props => [];
}

final class EditLeadInitial extends EditLeadState {}

class EditLeadLoadingState extends EditLeadState{
  const EditLeadLoadingState();
  @override
  List<Object> get props => [];
}

class EditLeadSuccessState extends EditLeadState{
  final String message;
  final NewLeadModel leadDetails;
  const EditLeadSuccessState({required this.message,required this.leadDetails});
  @override
  List<Object> get props => [message,leadDetails];
}

class EditLeadFailedState extends EditLeadState{
  final String message;
  const EditLeadFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

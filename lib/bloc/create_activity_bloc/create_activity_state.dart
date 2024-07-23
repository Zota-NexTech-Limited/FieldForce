part of 'create_activity_bloc.dart';

@immutable
sealed class CreateActivityState extends Equatable{
  const CreateActivityState();
  @override
  List<Object> get props => [];
}

final class CreateActivityInitial extends CreateActivityState {}



class CreateActivityLoadingState extends CreateActivityState{
  const CreateActivityLoadingState();
  @override
  List<Object> get props => [];
}

class CreateActivitySuccessState extends CreateActivityState{
  final String message;
  const CreateActivitySuccessState({required this.message,});
  @override
  List<Object> get props => [message];
}

class CreateActivityFailedState extends CreateActivityState{
  final String message;
  const CreateActivityFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
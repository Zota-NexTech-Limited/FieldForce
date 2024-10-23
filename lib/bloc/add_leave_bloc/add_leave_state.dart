part of 'add_leave_bloc.dart';

@immutable
sealed class AddLeaveState extends Equatable{
  const AddLeaveState();
  @override
  List<Object> get props => [];
}

final class AddLeaveInitial extends AddLeaveState {}


class AddLeaveLoadingState extends AddLeaveState{
  const AddLeaveLoadingState();
  @override
  List<Object> get props => [];
}

class AddLeaveSuccessState extends AddLeaveState{
  final String message;
  const AddLeaveSuccessState({required this.message,});
  @override
  List<Object> get props => [message];
}

class AddLeaveFailedState extends AddLeaveState{
  final String message;
  const AddLeaveFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
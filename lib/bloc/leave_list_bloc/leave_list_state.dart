part of 'leave_list_bloc.dart';

@immutable
abstract class LeaveListState extends Equatable{
  const LeaveListState();
  @override
  List<Object> get props => [];
}

 class LeaveListInitial extends LeaveListState {}

class LeaveListLoadingState extends LeaveListState{
  const LeaveListLoadingState();
  @override
  List<Object> get props => [];
}

class LeaveListSuccessState extends LeaveListState{
  final List<LeaveModel> leaveList;
  const LeaveListSuccessState({required this.leaveList});
  @override
  List<Object> get props => [leaveList];
}

class LeaveListFailedState extends LeaveListState{
  final String message;
  const LeaveListFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
part of 'leave_list_bloc.dart';

@immutable
abstract class LeaveListEvent extends Equatable{
  const LeaveListEvent();
  @override
  List<Object> get props => [];
}

class FetchLeaveListEvent  extends LeaveListEvent{
  const FetchLeaveListEvent();
  @override
  List<Object> get props => [];
}
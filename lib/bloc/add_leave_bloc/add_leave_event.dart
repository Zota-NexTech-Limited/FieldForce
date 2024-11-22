part of 'add_leave_bloc.dart';

@immutable
sealed class AddLeaveEvent extends Equatable{
  const AddLeaveEvent();
  @override
  List<Object> get props => [];
}


class AddNewLeaveEvent extends AddLeaveEvent{
  final  Leave leaveDetails;
  const AddNewLeaveEvent({required this.leaveDetails,});
  @override
  List<Object> get props => [leaveDetails];
}

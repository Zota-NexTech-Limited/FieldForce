part of 'create_activity_bloc.dart';

@immutable
sealed class CreateActivityEvent extends Equatable{
  const CreateActivityEvent();
  @override
  List<Object> get props => [];
}


class CreateNewActivityEvent extends CreateActivityEvent{
  final  CreateActivityModel activityDetails;
  const CreateNewActivityEvent({required this.activityDetails,});
  @override
  List<Object> get props => [activityDetails];
}
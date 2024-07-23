part of 'activity_list_bloc.dart';

@immutable
sealed class ActivityListState extends Equatable{
  const ActivityListState();
  @override
  List<Object> get props => [];
}

final class ActivityListInitial extends ActivityListState {}

class ActivityListLoadingState extends ActivityListState{
  const ActivityListLoadingState();
  @override
  List<Object> get props => [];
}

class ActivityListSuccessState extends ActivityListState{
  final List<ActivityListModel>activityList;
  const ActivityListSuccessState({required this.activityList});
  @override
  List<Object> get props => [activityList];
}

class ActivityListFailedState extends ActivityListState{
  final String message;
  const ActivityListFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
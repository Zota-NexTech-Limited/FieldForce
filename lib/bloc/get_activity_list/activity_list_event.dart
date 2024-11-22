part of 'activity_list_bloc.dart';

@immutable
abstract class ActivityListEvent extends Equatable{
  const ActivityListEvent();
  @override
  List<Object> get props => [];
}

class FetchActivityListEvent  extends ActivityListEvent{
  const FetchActivityListEvent();
  @override
  List<Object> get props => [];
}

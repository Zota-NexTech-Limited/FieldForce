part of 'get_opportunity_by_id_bloc.dart';

@immutable
sealed class GetOpportunityByIdEvent extends Equatable{
  const GetOpportunityByIdEvent();
  @override
  List<Object> get props => [];
}

class TriggerGetOpportunityByIdEvent  extends GetOpportunityByIdEvent{
  final String id;
  const TriggerGetOpportunityByIdEvent({required this.id});
  @override
  List<Object> get props => [id];
}
part of 'get_lead_by_id_bloc.dart';

@immutable
sealed class GetLeadByIdEvent extends Equatable{
  const GetLeadByIdEvent();
  @override
  List<Object> get props => [];
}

class TriggerGetLeadByIdEvent  extends GetLeadByIdEvent{
  final String id;
  const TriggerGetLeadByIdEvent({required this.id});
  @override
  List<Object> get props => [id];
}
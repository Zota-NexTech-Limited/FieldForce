part of 'edit_lead_bloc.dart';

@immutable
sealed class EditLeadEvent extends Equatable{
  const EditLeadEvent();
  @override
  List<Object> get props => [];
}

class TriggerEditLeadEvent extends EditLeadEvent{
  final  NewLeadModel leadDetails;
  const TriggerEditLeadEvent({required this.leadDetails,});
  @override
  List<Object> get props => [leadDetails];
}
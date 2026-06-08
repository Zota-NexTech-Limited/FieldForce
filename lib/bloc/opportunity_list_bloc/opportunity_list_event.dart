part of 'opportunity_list_bloc.dart';

@immutable
sealed class OpportunityListEvent extends Equatable{
  const OpportunityListEvent();
 @override
  List<Object> get props => [];
}

class GetOpportunityListEvent extends OpportunityListEvent{
  final String leadId;
  final String search;
  const  GetOpportunityListEvent({required this.leadId,required this.search});
  @override
  List<Object> get props => [leadId,search];
}

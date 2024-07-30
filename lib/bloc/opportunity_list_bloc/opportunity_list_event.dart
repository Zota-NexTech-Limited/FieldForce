part of 'opportunity_list_bloc.dart';

@immutable
sealed class OpportunityListEvent extends Equatable{
  const OpportunityListEvent();
 @override
  List<Object> get props => [];
}

class GetOpportunityListEvent extends OpportunityListEvent{
  const  GetOpportunityListEvent();
  @override
  List<Object> get props => [];
}

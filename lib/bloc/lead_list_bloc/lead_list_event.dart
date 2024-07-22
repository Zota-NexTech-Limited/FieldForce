part of 'lead_list_bloc.dart';

@immutable
sealed class LeadListEvent extends Equatable{
  const LeadListEvent();
  @override
  List<Object> get props => [];}


class FetchLeadListEvent extends LeadListEvent{
  final String fromDate;
  final String toDate;
  final String search;
  const  FetchLeadListEvent(
      {required this.fromDate,
        required this.toDate,
        required this.search});
  @override
  List<Object> get props => [fromDate,toDate,search];
}
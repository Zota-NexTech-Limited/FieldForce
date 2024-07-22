part of 'new_lead_bloc.dart';

@immutable
sealed class NewLeadEvent extends Equatable{
  const NewLeadEvent();
  @override
  List<Object> get props => [];
}


class PostNewLeadEvent extends NewLeadEvent{
  final  NewLeadModel leadDetails;
  const PostNewLeadEvent({required this.leadDetails,});
  @override
  List<Object> get props => [leadDetails];
}
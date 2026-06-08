part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordEvent extends Equatable{
  const ResetPasswordEvent();
  @override
  List<Object> get props => [];
}


class TriggerResetPasswordEvent  extends ResetPasswordEvent{
  final String email;
  const TriggerResetPasswordEvent({required this.email,});
  @override
  List<Object> get props => [email];
}
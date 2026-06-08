part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordState extends Equatable{
  const ResetPasswordState();
  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState{
  const ResetPasswordLoadingState();
  @override
  List<Object> get props => [];
}

class ResetPasswordSuccessState extends ResetPasswordState{
  final String message;
  const ResetPasswordSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class ResetPasswordFailedState extends ResetPasswordState{
  final String message;
  const ResetPasswordFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
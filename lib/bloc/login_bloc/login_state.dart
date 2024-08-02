part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable{
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}


class LoginWithEmailLoadingState extends LoginState{
  const LoginWithEmailLoadingState();
  @override
  List<Object> get props => [];
}

class LoginWithEmailSuccessState extends LoginState{
  final String message;
  const LoginWithEmailSuccessState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoginWithEmailFailedState extends LoginState{
  final String message;
  const LoginWithEmailFailedState({required this.message});
  @override
  List<Object> get props => [message];
}
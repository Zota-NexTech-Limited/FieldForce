
import 'package:fieldforce/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fieldforce/bloc/login_bloc/login_bloc.dart';
import 'package:fieldforce/components/state_management_components/loading_screen.dart';
import 'package:fieldforce/helper/global_handler.dart';
import 'package:fieldforce/ui/auth_screens/sign_in_screeen.dart';
import 'package:fieldforce/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalBlocClass.authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    GlobalBlocClass.authenticationContext = context;
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: authenticationBloc,
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            print("Auth is Loading1");
            return const LoadingScreen();
          }

          if(state is AuthenticationLoginRequired)
            {
              return  BlocProvider(create: (context)=>LoginBloc(),child: SignInScreen(),);
            }

          if (state is AuthenticationHomeScreen) {
            print("Login Required3");
            return HomeScreen();
          }
          print("Login Required4");
          return  BlocProvider(create: (context)=>LoginBloc(),child: SignInScreen(),);
        });
  }
}
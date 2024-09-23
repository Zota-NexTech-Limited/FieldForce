import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/global_handler.dart';
import 'package:fieldsales/helper/local_constant.dart';
import 'package:fieldsales/ui/auth_screens/authentication_screen.dart';
import 'package:fieldsales/ui/auth_screens/host_url_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<InitializeApp>((event, emit) async {
      await mapInitializeAppEvent(event, emit);
    });

    on<AuthenticationLogoutEvent>((event, emit) async {
      await mapAuthenticationLogout(event, emit);
    });
    on<AuthenticationLoginEvent>((event, emit) async {
      await mapAuthenticationLogin(event, emit);
    });

    on<AuthenticationHomeScreenRedirectEvent>((event, emit) async {
      await mapAuthenticationHomeScreenRedirectEvent(event, emit);
    });
  }


  Future<void> mapInitializeAppEvent(
      InitializeApp event, Emitter<AuthenticationState> emit) async {
    try {
      emit(const AuthenticationLoading());
      print("auth loading 1");
     // sleep(const Duration(seconds: 5));
      //print("auth loading 2");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(LocalConstant.accessToken) ?? "";
      String userName = prefs.getString(LocalConstant.userName) ?? "";
      String userRole = prefs.getString(LocalConstant.userRole) ?? "";
      String userEmail = prefs.getString(LocalConstant.userEmail) ?? "";
      String userPhoneNumber = prefs.getString(LocalConstant.userPhoneNumber) ?? "";
      String userDepartment = prefs.getString(LocalConstant.userDepartment) ?? "";
      String hostUrl = prefs.getString(LocalConstant.hostUrl) ?? "";


      Config.accessToken = token;
      Config.userName = userName;
      Config.userRole =userRole;
      Config.userEmail = userEmail;
      Config.userPhoneNumber =userPhoneNumber;
      Config.userDepartment =userDepartment;
      Config.hostUrl =hostUrl;


      print("Access Token : ${Config.accessToken}");

      ///Redirect to different state
      if(hostUrl.isEmpty){
        Navigator.push(GlobalBlocClass.authenticationContext!, MaterialPageRoute(builder: (context)=>HostUrlScreen()));
        print("***********************Host Url screen***********************");
      }
       else  if (token.isNotEmpty) {
          emit(const AuthenticationHomeScreen());
          print("***********************Authentication 1***********************");
        } else {
          emit(const AuthenticationLoginRequired());
          print("***********************Authentication 2***********************");

        }

    } catch (error) {
      emit(const AuthenticationLoginRequired());
      print("***********************Authentication 4***********************");

    }
  }

  Future<void> mapAuthenticationLogout(AuthenticationLogoutEvent event,
      Emitter<AuthenticationState> emit) async {
    ///Get values from local storage and remove them
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(LocalConstant.accessToken);

    print("--------------------logout--------------------");

    emit(const AuthenticationLoginRequired());

    Navigator.pushAndRemoveUntil(
      GlobalBlocClass.authenticationContext!,
      MaterialPageRoute(
        builder: (context) => BlocProvider(create: (context) => AuthenticationBloc()..add(const InitializeApp()),
            child: const Authentication()),
      ),
          (Route<dynamic> route) => false,
    );

    ScaffoldMessenger.of(GlobalBlocClass.authenticationContext!).showSnackBar(SnackBar(content: Text("Logout Successfully")));

  }

  Future<void> mapAuthenticationLogin(
      AuthenticationLoginEvent event, Emitter<AuthenticationState> emit) async {
    ///Get values from local storage and remove them
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(LocalConstant.accessToken);
    prefs.remove(LocalConstant.userName);
    prefs.remove(LocalConstant.userRole);
    prefs.remove(LocalConstant.userEmail);
    prefs.remove(LocalConstant.userPhoneNumber);
    prefs.remove(LocalConstant.userDepartment);
  }

  Future<void> mapAuthenticationHomeScreenRedirectEvent(
      AuthenticationHomeScreenRedirectEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationHomeScreen());
  }

}

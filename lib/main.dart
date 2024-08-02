import 'package:fieldforce/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/ui/auth_screens/authentication_screen.dart';
import 'package:fieldforce/ui/crm/crm_screen.dart';
import 'package:fieldforce/ui/home_screen/home_screen.dart';
import 'package:fieldforce/ui/my_activity/my_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Field Force',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => AuthenticationBloc()..add(const InitializeApp()),
        child: const Authentication(),
      ),
    );
  }
}


import 'dart:async';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/auth_screens/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/authentication_bloc/authentication_bloc.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    if (context != null) {
      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => AuthenticationBloc()..add(const InitializeApp()),
            child: const Authentication(),
          ),
        ));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: COLORS.backgroundColor,
      body:  SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child:const Center(
          child: SvgImageHelper(image: "assets/image/common/nextech_logo.svg"),
        ),

      ),
    ));
  }
}

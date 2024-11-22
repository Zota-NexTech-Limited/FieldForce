import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.backgroundColor,
      body: SafeArea(

          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: COLORS.backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
            child: Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: COLORS.primaryColor,
                size: SizeConfig.blockHeight * 7,
              ),
            ),
          )
      ),
    );
  }
}

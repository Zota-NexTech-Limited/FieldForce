
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class EmptyScreen extends StatelessWidget {
  final String title;
  const EmptyScreen({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: COLORS.white,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: COLORS.black,
                    fontFamily:Config.fountFamilyPrimary,
                    fontSize: SizeConfig.blockWidth * 4.5,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
      ),
    );
  }
}

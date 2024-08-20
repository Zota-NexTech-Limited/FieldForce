
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/material.dart';


class ErrorScreen extends StatelessWidget {
  final VoidCallback onPressed;
  const ErrorScreen({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Oops!",
                style: TextStyle(
                    color: COLORS.black,
                    fontFamily: Config.fountFamilyPrimary,
                    fontSize: SizeConfig.blockWidth * 9.5,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: SizeConfig.blockHeight * 6),
              Text(
                "Something went wrong.\nDont't worry let's try again.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: COLORS.black,
                    fontFamily: Config.fountFamilyPrimary,
                    fontSize: SizeConfig.blockWidth * 4.5,
                    fontWeight: FontWeight.w500),
              ),

              Container(
                width: SizeConfig.blockWidth * 60,
                height: SizeConfig.blockHeight * 7.2,
                margin: EdgeInsets.only(top: SizeConfig.blockHeight * 4),
                child: ElevatedButton(
                  onPressed: (){
                    onPressed();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(COLORS.blue),
                      foregroundColor: MaterialStateProperty.all<Color>(COLORS.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 6)))),
                  child: Text(
                    "TRY AGAIN",
                    style: TextStyle(
                        color: COLORS.white,
                        fontWeight: FontWeight.w600,
                        fontFamily:Config.fountFamilyPrimary,
                        fontSize: SizeConfig.blockWidth * 4.5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

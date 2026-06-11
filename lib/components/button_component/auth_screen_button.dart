import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class AuthScreenButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoding;
  const AuthScreenButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.isLoding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockHeight * 6.4,
      child: ElevatedButton(
        onPressed: isLoding ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: COLORS.primaryColor,
          foregroundColor: COLORS.onPrimaryColor,
          disabledBackgroundColor: COLORS.primaryColor.withOpacity(0.7),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoding == false
              ? Text(
                  text,
                  key: const ValueKey('label'),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 15.5,
                    letterSpacing: 0.3,
                    color: COLORS.white,
                  ),
                )
              : SizedBox(
                  key: const ValueKey('loader'),
                  height: SizeConfig.blockHeight * 3,
                  width: SizeConfig.blockHeight * 3,
                  child: const CircularProgressIndicator(
                    color: COLORS.white,
                    strokeWidth: 2.6,
                  ),
                ),
        ),
      ),
    );
  }
}

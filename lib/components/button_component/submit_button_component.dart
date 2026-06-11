import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class SubmitButtonComponent extends StatelessWidget {
  final VoidCallback onTap;
  const SubmitButtonComponent({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockHeight * 7,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: COLORS.success,
          foregroundColor: COLORS.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
          ),
        ),
        child: const Text(
          "Submit",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 15.5,
            letterSpacing: 0.2,
            color: COLORS.white,
          ),
        ),
      ),
    );
  }
}

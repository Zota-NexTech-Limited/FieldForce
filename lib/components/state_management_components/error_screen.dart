import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onPressed;
  const ErrorScreen({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.scaffoldBg,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.blockWidth * 22,
                  height: SizeConfig.blockWidth * 22,
                  decoration: const BoxDecoration(
                    color: COLORS.dangerSoft,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: COLORS.danger,
                    size: SizeConfig.blockWidth * 11,
                  ),
                ),
                SizedBox(height: SizeConfig.blockHeight * 3),
                const Text(
                  "Oops! Something went wrong",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: COLORS.textPrimary,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: SizeConfig.blockHeight * 1.2),
                const Text(
                  "Don't worry — let's try that again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: COLORS.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: SizeConfig.blockHeight * 4),
                SizedBox(
                  width: SizeConfig.blockWidth * 55,
                  height: SizeConfig.blockHeight * 6.6,
                  child: ElevatedButton.icon(
                    onPressed: onPressed,
                    icon: const Icon(Icons.refresh_rounded, size: 20),
                    label: const Text(
                      "Try Again",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: COLORS.primaryColor,
                      foregroundColor: COLORS.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(SizeConfig.blockWidth * 3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.scaffoldBg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
                decoration: BoxDecoration(
                  color: COLORS.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: COLORS.shadow,
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: COLORS.primaryColor,
                  size: SizeConfig.blockHeight * 5.5,
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 2.4),
              const Text(
                "Loading…",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: COLORS.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

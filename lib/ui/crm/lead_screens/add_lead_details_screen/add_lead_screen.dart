import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLORS.scaffoldBg,
        appBar: appBarComponent(title: "Add Lead", context: context),
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockWidth * 6,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                padding: EdgeInsets.all(SizeConfig.blockWidth * 7),
                decoration: BoxDecoration(
                  color: COLORS.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: COLORS.cardBorder, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: COLORS.shadow,
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: SizeConfig.blockWidth * 18,
                      width: SizeConfig.blockWidth * 18,
                      decoration: BoxDecoration(
                        color: COLORS.primarySoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.person_add_alt_1_rounded,
                        color: COLORS.primaryColor,
                        size: SizeConfig.blockWidth * 9,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 3),
                    NormalText(
                      fontWeight: FontWeight.w700,
                      color: COLORS.textPrimary,
                      fontSize: 2.4,
                      text: "Add Lead",
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 1),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockWidth * 2,
                      ),
                      child: Text(
                        "Capture new lead details here to grow your pipeline.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: SizeConfig.blockHeight * 1.7,
                          height: 1.4,
                          color: COLORS.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String text;
  final double distanceFromTop;
  const EmptyScreen(
      {super.key, required this.text, required this.distanceFromTop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: SizeConfig.blockHeight * distanceFromTop),
        SizedBox(
          width: SizeConfig.blockWidth * 70,
          height: SizeConfig.blockHeight * 26,
          child: SvgImageHelper(
              image: "assets/image/svg_icons/empty_image.svg"),
        ),
        SizedBox(height: SizeConfig.blockHeight * 1.5),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: COLORS.textPrimary,
            fontSize: 16,
          ),
        ),
        SizedBox(height: SizeConfig.blockHeight * 0.8),
        const Text(
          "Nothing to show here yet.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            color: COLORS.textTertiary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

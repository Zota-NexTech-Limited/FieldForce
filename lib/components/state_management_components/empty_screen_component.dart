import 'package:fieldforce/components/svg_image_component.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/material.dart';
class EmptyScreen extends StatelessWidget {
  final String text;
  final double distanceFromTop;
  const EmptyScreen({super.key,required this.text,required this.distanceFromTop});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: SizeConfig.blockHeight*distanceFromTop,),
        SizedBox(
            width: SizeConfig.blockWidth*80,
            height: SizeConfig.blockHeight*30,
            child: SvgImageHelper(image: "assets/image/svg_icons/empty_image.svg")),
        NormalText(fontWeight: FontWeight.w500, color: COLORS.blue, fontSize: 3, text: text)

      ],
    );
  }
}

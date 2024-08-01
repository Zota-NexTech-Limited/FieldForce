import 'package:fieldforce/components/svg_image_component.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/material.dart';
class EmptyScreen extends StatelessWidget {
  final String text;
  const EmptyScreen({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight*0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.blockHeight*10,),
          SizedBox(
              width: SizeConfig.blockWidth*80,
              height: SizeConfig.blockHeight*30,
              child: SvgImageHelper(image: "assets/image/svg_icons/55024593_9264820 1.svg")),
          NormalText(fontWeight: FontWeight.w500, color: COLORS.blue, fontSize: 3, text: text)

        ],
      ),
    );
  }
}

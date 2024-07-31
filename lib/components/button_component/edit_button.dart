import 'package:fieldforce/components/svg_image_component.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/material.dart';
class EditButtonComponent extends StatelessWidget {
  final VoidCallback onTap;
  const EditButtonComponent({super.key,required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockWidth*20,
      height:SizeConfig.blockHeight*7,
      child:  ElevatedButton(
        child: Center(child: SvgImageHelper(image: "assets/image/svg_icons/edit-outline.svg",)),
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(COLORS.darkBlue),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3))))
        ),
        onPressed: onTap,
      ),
    );
  }
}
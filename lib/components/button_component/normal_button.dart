import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class NormalButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final double width;
  final double height;
  const NormalButton({super.key,required this.title,required this.onTap,required this.height,required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height:height,
      child:  ElevatedButton(
        child: NormalText(fontWeight: FontWeight.w500, color: COLORS.white, fontSize:2.3, text: title) ,
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(COLORS.darkBlue),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3))))
        ),
        onPressed: onTap,
      ),
    );
  }
}
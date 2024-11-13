import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class AuthScreenButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoding;
  const AuthScreenButton({super.key,required this.onPressed,required this.text,required this.isLoding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockHeight*6,
      child: ElevatedButton(
        onPressed:onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)))),
          backgroundColor: MaterialStatePropertyAll(COLORS.primaryColor)

        ),
        child:isLoding==false? NormalText(fontWeight: FontWeight.w500, color: COLORS.onPrimaryColor, fontSize: 2.3, text: text):
        CircularProgressIndicator(
          color: COLORS.onPrimaryColor,
          strokeWidth: SizeConfig.blockWidth*1,
          strokeAlign:SizeConfig.blockWidth*-1,
        ),
      ),
    );
  }
}

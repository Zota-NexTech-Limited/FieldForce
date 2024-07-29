import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/material.dart';
class SubmitButtonComponent extends StatelessWidget {
  final VoidCallback onTap;
  const SubmitButtonComponent({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return    SizedBox(
      width: SizeConfig.screenWidth,
      height:SizeConfig.blockHeight*7,
      child:  ElevatedButton(
        child: NormalText(fontWeight: FontWeight.w500, color: COLORS.white, fontSize:2.3, text: "Submit") ,
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(COLORS.green),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3))))
        ),
        onPressed: onTap,
      ),
    );
  }
}

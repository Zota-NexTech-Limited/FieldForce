import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class AddNewButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const AddNewButton({super.key,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     // width: SizeConfig.blockWidth*40,
      height: SizeConfig.blockHeight*6,
      child: ElevatedButton(
        child:Row(
          children: [
            Icon(Icons.add,color: COLORS.primaryChildColor,size: SizeConfig.blockHeight*2.7,),
            SizedBox(
              width: SizeConfig.blockWidth*2,
            ),
            NormalText(fontWeight: FontWeight.w500, color: COLORS.primaryChildColor, fontSize:2, text: title)
          ],
        ) ,
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(COLORS.primaryColor)
        ),
        onPressed: onTap,
      ),
    );
  }
}

import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class NotEditableSearchField extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const NotEditableSearchField({super.key,required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*1.5),
        decoration:BoxDecoration(
          color: COLORS.white,
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1)),
          border: Border.all(color: COLORS.cardBorder)
        ),
        child:Row(
          children: [
            Icon(Icons.search,size: SizeConfig.blockHeight*3,),
            SizedBox(width: SizeConfig.blockWidth*2,),
            Text(text,style:text=="Search"? TextStyle(fontSize: SizeConfig.blockHeight*2.3,color:COLORS.gray,fontWeight: FontWeight.w400,fontFamily: "Manrope") :  TextStyle(
                color:COLORS.black,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                fontSize: SizeConfig.blockWidth * 4),overflow:TextOverflow.clip ,),
            Spacer(),
            SvgImageHelper(image: "assets/image/svg_icons/Filter.svg",),
          ],
        ) ,
      ),
    );
  }
}

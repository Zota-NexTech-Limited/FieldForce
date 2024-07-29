import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar appBarComponent({required String title,required BuildContext context}){
  return AppBar(backgroundColor: COLORS.blue,
    titleSpacing: SizeConfig.blockWidth*1,
    leading: InkWell(
      onTap: (){
        Navigator.pop(context);
        },
        child:  Icon(Icons.arrow_back_sharp,size: SizeConfig.blockHeight*4,color: COLORS.white,)),
    centerTitle: false,
    leadingWidth: SizeConfig.blockWidth*15,
    title: NormalText(fontWeight: FontWeight.w400, color: COLORS.white, fontSize: 3, text: title) ,
  );
}

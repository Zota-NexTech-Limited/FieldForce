import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar appBarComponent({required String title,required BuildContext context}){
  return AppBar(backgroundColor: COLORS.backgroundColor,
    titleSpacing: SizeConfig.blockWidth*1,
    leading: InkWell(
      onTap: (){
        Navigator.pop(context);
        },
        child:  Icon(Icons.arrow_back_sharp,size: SizeConfig.blockHeight*4,color: COLORS.black,)),
    centerTitle: false,
    leadingWidth: SizeConfig.blockWidth*15,
    title: NormalText(fontWeight: FontWeight.w700, color: COLORS.black, fontSize: 2.7,  text: title) ,
  );
}

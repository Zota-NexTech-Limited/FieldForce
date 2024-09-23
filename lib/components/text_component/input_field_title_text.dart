import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class InputFieldTitleText extends StatelessWidget {
  final String text;
  const InputFieldTitleText({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*1,top: SizeConfig.blockHeight*3),
      child: Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: SizeConfig.blockHeight*2.2,color:Colors.black,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500),),
    );
  }
}
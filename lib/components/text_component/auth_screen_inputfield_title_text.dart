import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreenInputFieldTitleText extends StatelessWidget {
  final String text;
  const AuthScreenInputFieldTitleText({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: SizeConfig.blockHeight*2.2,color:COLORS.black,fontFamily: "Manrope",fontWeight:FontWeight.w600,),);
  }
}


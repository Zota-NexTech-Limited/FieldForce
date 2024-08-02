import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreenSubTitleText extends StatelessWidget {
  final String text;
  const AuthScreenSubTitleText({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: SizeConfig.blockHeight*2.1,color:COLORS.blackMedium,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w600,),textAlign:TextAlign.center ,);
  }
}


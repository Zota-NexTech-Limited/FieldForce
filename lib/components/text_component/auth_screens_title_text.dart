import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreenTitleText extends StatelessWidget {
  final String text;
  const AuthScreenTitleText({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: SizeConfig.blockHeight*4,color:COLORS.black,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w700,),);
  }
}


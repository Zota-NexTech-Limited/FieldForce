import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const NormalText({super.key,required this.fontWeight,required this.color,required this.fontSize,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: SizeConfig.blockHeight*fontSize,color:color,fontFamily: Config.fountFamilyPrimary,fontWeight:fontWeight),);
  }
}
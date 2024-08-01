import 'dart:ui';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/material.dart';
InputDecoration filterFieldDecoration({required String labelText,required VoidCallback suffixIconTap}) {
  return InputDecoration(
      filled: true, // Fill the TextFormField with color
      fillColor: COLORS.white,
      isDense: true,
      labelText:labelText ,
      labelStyle: TextStyle(fontSize: SizeConfig.blockHeight*2.4,color:COLORS.gray,fontWeight: FontWeight.w500,fontFamily:Config.fountFamilyPrimary),
      contentPadding: EdgeInsets.only(
        top: SizeConfig.blockHeight * 1.8,
        bottom: SizeConfig.blockHeight * 1.4,
        left: SizeConfig.blockWidth * 4,
        right: SizeConfig.blockWidth * 3,
      ),
      focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: COLORS.blue,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 7)),
      enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: COLORS.blue,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 7)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: COLORS.red,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 7)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: COLORS.red,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 7)),
      prefixIcon:  Icon(Icons.search,size: SizeConfig.blockHeight*3,color: COLORS.blue,),
      //suffixIconConstraints:BoxConstraints(minHeight: SizeConfig.blockHeight*5,minWidth: SizeConfig.blockWidth*10),
    suffixIcon: InkWell(
      onTap: suffixIconTap,
      child: Container(

        width: SizeConfig.blockWidth*17,
       decoration: BoxDecoration(
         color: COLORS.blue,
         borderRadius: BorderRadius.only(bottomRight:Radius.circular(SizeConfig.blockWidth*7),topRight: Radius.circular(SizeConfig.blockWidth*7))
       ),
        child: Center(child: NormalText(fontWeight: FontWeight.w500, color: COLORS.white, fontSize: 1.8, text: "Search")),

      ),
    )
  );
}
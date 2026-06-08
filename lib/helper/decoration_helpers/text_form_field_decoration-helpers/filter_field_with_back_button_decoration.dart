import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration filterFieldWithBackButtonDecoration({required String labelText,required VoidCallback iconTap,required TextEditingController  controller,required VoidCallback  backButtonTap,required VoidCallback  clearButtonTap}) {
  return InputDecoration(
      filled: true, // Fill the TextFormField with color
      fillColor: COLORS.white,
      isDense: true,
      hintText:labelText ,
      hintStyle: TextStyle(fontSize: SizeConfig.blockHeight*2,color:COLORS.hintColor,fontWeight: FontWeight.w400,fontFamily: "Manrope"),
      contentPadding: EdgeInsets.only(
        top: SizeConfig.blockHeight * 1.8,
        bottom: SizeConfig.blockHeight * 1.8,
        left: SizeConfig.blockWidth * 4,
        right: SizeConfig.blockWidth * 3,
      ),

      focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: COLORS.primaryColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
      enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: COLORS.cardBorder,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: COLORS.red,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: COLORS.red,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
      prefixIconConstraints: BoxConstraints(minWidth: SizeConfig.blockWidth*9),
      prefixIcon:  InkWell(
          onTap:backButtonTap,
          child: Icon(Icons.arrow_back,size: SizeConfig.blockHeight*3,color: COLORS.black,)),
      suffixIcon: InkWell(
          onTap:clearButtonTap,
          child: Icon(CupertinoIcons.multiply,size: SizeConfig.blockHeight*3,color: COLORS.black,)),
  );
}
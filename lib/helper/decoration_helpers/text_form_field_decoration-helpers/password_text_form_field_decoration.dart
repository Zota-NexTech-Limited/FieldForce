
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

passwordTextFieldDecoration(
    {
      required String hint,
      required Function(bool) isHideInputFunction,
      required bool isHideInput
    }) {
  return InputDecoration(

      isDense: true,
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
            color: COLORS.gray,
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
      hintText: hint,
      hintStyle: TextStyle(
          color: COLORS.hintTextColor,
          fontWeight: FontWeight.w400,
          fontFamily: Config.fountFamilyPrimary,
          fontSize: SizeConfig.blockWidth * 3.5),
      suffixIcon:isHideInput==true?InkWell(
          onTap: (){
            isHideInput=false;
            isHideInputFunction(false);
          },
          child: Icon(Icons.visibility_outlined)):InkWell(
          onTap: (){
            isHideInput=true;
            isHideInputFunction(true);
          },
          child: Icon(Icons.visibility_off_outlined))
  );

}
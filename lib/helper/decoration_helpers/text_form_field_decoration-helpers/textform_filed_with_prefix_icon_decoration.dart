import 'dart:ui';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


InputDecoration textFieldDecorationWithPrefixIcon({required String hint,required VoidCallback onTap,required String icon,}) {
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
            color: COLORS.gray,
            width: SizeConfig.blockWidth*0.2,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
      enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: COLORS.gray,
            width: SizeConfig.blockWidth*0.2,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
      errorBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: COLORS.red,
            width: SizeConfig.blockWidth*0.2,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: COLORS.red,
            width: SizeConfig.blockWidth*0.2,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
      hintText: hint,
      hintStyle: TextStyle(
          color: COLORS.iconColor,
          fontFamily: Config.fountFamilyPrimary,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
          fontSize: SizeConfig.blockWidth * 2.7),
      prefixIcon:icon.isEmpty?null: InkWell(
          onTap: onTap,
          child: Container(
              padding: EdgeInsets.all(SizeConfig.blockWidth*3),
              child:SvgPicture.asset(icon,fit: BoxFit.contain,color: COLORS.gray,)))
  );
}
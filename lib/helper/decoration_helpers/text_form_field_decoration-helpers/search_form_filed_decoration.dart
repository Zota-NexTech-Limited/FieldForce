
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration searchFormFieldDecoration({required String labelText,required VoidCallback clearIconTap,required String filterText,required TextEditingController  controller}) {
  return InputDecoration(
      filled: true, // Fill the TextFormField with color
      fillColor: COLORS.white,
      isDense: true,
      hintText:labelText ,
      hintStyle: TextStyle(fontSize: SizeConfig.blockHeight*2.3,color:COLORS.gray,fontWeight: FontWeight.w400,fontFamily: "Manrope"),
      contentPadding: EdgeInsets.only(
        top: SizeConfig.blockHeight * 1.8,
        bottom: SizeConfig.blockHeight * 1.8,
        left: SizeConfig.blockWidth * 4,
        right: SizeConfig.blockWidth * 3,
      ),

      focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: COLORS.cardBorder,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 5)),
      enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            color: COLORS.cardBorder,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth *5)),
      suffixIcon: Container(
          width: SizeConfig.blockWidth*10,
          padding: EdgeInsets.only(right: SizeConfig.blockWidth*2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controller.text.isNotEmpty? InkWell(
                  onTap: clearIconTap,
                  child: Icon(Icons.clear,size: SizeConfig.blockHeight*3,)):Container(width: SizeConfig.blockWidth*0,),
            ],
          )),
      prefixIconConstraints: BoxConstraints(minWidth: controller.text.isEmpty?SizeConfig.blockWidth*12:SizeConfig.blockWidth*5),
      prefixIcon: controller.text.isEmpty? Icon(Icons.search,size: SizeConfig.blockHeight*3,):Container(width: SizeConfig.blockWidth*0,)
  );
}
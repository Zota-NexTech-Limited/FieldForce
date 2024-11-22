
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration filterFieldDecoration({required String labelText,required VoidCallback iconTap,required VoidCallback clearIconTap,required String filterText,required TextEditingController  controller}) {
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
      suffixIcon: InkWell(onTap: iconTap,child:
      Container(
          width: SizeConfig.blockWidth*38,
          padding: EdgeInsets.all( SizeConfig.blockHeight*2,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              controller.text.isNotEmpty? InkWell(
                  onTap: clearIconTap,
                  child: Icon(Icons.clear,size: SizeConfig.blockHeight*3,)):Container(width: SizeConfig.blockWidth*0,),
              SizedBox(width: SizeConfig.blockWidth*2,),
              SvgImageHelper(image: "assets/image/svg_icons/Filter.svg",),
              SizedBox(width: SizeConfig.blockWidth*2,),
              if(filterText.isNotEmpty)...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*2,vertical: SizeConfig.blockHeight*0.5),
                  decoration: BoxDecoration(
                      border: Border.all(color:COLORS.gray),
                      borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1.5)
                      )),
                  child: NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: SizeConfig.blockHeight*2, text:filterText),
                ),
              ]
            ],
          )),),
      prefixIconConstraints: BoxConstraints(minWidth: controller.text.isEmpty?SizeConfig.blockWidth*12:SizeConfig.blockWidth*5),
      prefixIcon: controller.text.isEmpty? Icon(Icons.search,size: SizeConfig.blockHeight*3,):Container(width: SizeConfig.blockWidth*0,)
  );
}
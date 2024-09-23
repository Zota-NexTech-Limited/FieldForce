import 'dart:ui';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/decoration_helpers/text_form_field_decoration-helpers/text_field_decoration_with_suffixIcon.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class TextFormFieldWithSuffixIcon extends StatefulWidget {
  String hintText;
  String suffixIcon;
  TextEditingController controller;
  TextInputType inputType;
  ValueChanged onChanged;
  VoidCallback onTap;
  String? Function(String?)? validator;
  bool readOnly;
  TextFormFieldWithSuffixIcon({super.key,required this.onChanged,required this.controller,required this.hintText,required this.inputType,required this.validator,required this.onTap,required this.suffixIcon,required this.readOnly});

  @override
  State<TextFormFieldWithSuffixIcon> createState() => _TextFormFieldWithSuffixIconState();
}

class _TextFormFieldWithSuffixIconState extends State<TextFormFieldWithSuffixIcon> {
  String hintText="";
  TextEditingController? controller;
  TextInputType? inputType;
  ValueChanged? onChanged;
  VoidCallback onTap=(){};
  String? Function(String?)? validator;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hintText=widget.hintText;
    controller=widget.controller;
    inputType=widget.inputType;
    onChanged=widget.onChanged;
    validator=widget.validator;
    onTap=widget.onTap;

  }
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
  readOnly: widget.readOnly,
      style: TextStyle(
          color: COLORS.blackMedium,
          fontFamily: Config.fountFamilyPrimary,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
          fontSize: SizeConfig.blockWidth * 4),
      onChanged: onChanged,
      validator: validator,
      keyboardType: inputType,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      cursorColor: COLORS.blue,
      decoration: textFieldDecorationWithSuffixIcon(hint:hintText,onTap:onTap,icon: widget.suffixIcon),


    );
  }
}








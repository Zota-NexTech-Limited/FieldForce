import 'dart:ui';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/decoration_helpers/text_form_field_decoration-helpers/text_field_decoration_with_suffixIcon.dart';
import 'package:fieldsales/helper/decoration_helpers/text_form_field_decoration-helpers/textform_filed_with_prefix_icon_decoration.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class TextFormFieldWithPrefixIcon extends StatefulWidget {
  String hintText;
  String suffixIcon;
  TextEditingController controller;
  TextInputType inputType;
  ValueChanged onChanged;
  VoidCallback onTap;
  String? Function(String?)? validator;
  bool readOnly;
  TextFormFieldWithPrefixIcon({super.key,required this.onChanged,required this.controller,required this.hintText,required this.inputType,required this.validator,required this.onTap,required this.suffixIcon,required this.readOnly});

  @override
  State<TextFormFieldWithPrefixIcon> createState() => _TextFormFieldWithPrefixIconState();
}

class _TextFormFieldWithPrefixIconState extends State<TextFormFieldWithPrefixIcon> {
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
          color: COLORS.iconColor,
          fontFamily: Config.fountFamilyPrimary,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
          fontSize: SizeConfig.blockWidth * 2.7),
      onChanged: onChanged,
      validator: validator,
      keyboardType: inputType,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      cursorColor: COLORS.primaryColor,
      decoration: textFieldDecorationWithPrefixIcon(hint:widget.hintText,onTap:onTap,icon: widget.suffixIcon),
 );
  }
}








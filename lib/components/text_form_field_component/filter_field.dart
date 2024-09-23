import 'dart:ui';

import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/decoration_helpers/text_form_field_decoration-helpers/filter_field_decoration.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';


class FilterTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  TextInputType inputType;
  ValueChanged onChanged;
  bool isReadOnly;
  VoidCallback iconTap;
  String? Function(String?)? validator;
  FilterTextFormField({super.key,required this.onChanged,required this.controller,required this.hintText,required this.inputType,required this.validator,required this.isReadOnly,required this.iconTap});

  @override
  State<FilterTextFormField> createState() => _FilterTextFormFieldState();
}

class _FilterTextFormFieldState extends State<FilterTextFormField> {
  String hintText="";
  TextEditingController? controller;
  TextInputType? inputType;
  ValueChanged? onChanged;
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

  }
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockHeight*6,
      child: TextFormField(
        readOnly: widget.isReadOnly,
        controller: controller,
        style: TextStyle(
            color: COLORS.black,
            fontFamily: Config.fountFamilyPrimary,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
            fontSize: SizeConfig.blockWidth * 4),
        onChanged: onChanged,
        validator: validator,
        keyboardType: inputType,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        cursorColor: COLORS.gray,
        decoration: filterFieldDecoration(suffixIconTap: widget.iconTap,labelText: widget.hintText,),
      ),
    );
  }
}








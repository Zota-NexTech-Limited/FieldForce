import 'dart:ui';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/decoration_helpers/text_form_field_decoration-helpers/filter_field_decoration.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';


class FilterTextFormField extends StatefulWidget {
  String hintText;
  String filterText;
  TextEditingController controller;
  TextInputType inputType;
  ValueChanged onChanged;
  ValueChanged onSubmit;
  bool isReadOnly;
  VoidCallback iconTap;
  VoidCallback clearIconTap;
  String? Function(String?)? validator;
  FilterTextFormField({super.key,required this.onChanged,required this.controller,required this.hintText,required this.inputType,required this.validator,required this.isReadOnly,required this.iconTap,required this.clearIconTap,required this.filterText,required this.onSubmit});

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
    return TextFormField(
      textInputAction: TextInputAction.search,
      readOnly: widget.isReadOnly,
      controller: controller,
      style: TextStyle(
          color: COLORS.textColor,
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
          fontSize: SizeConfig.blockWidth * 4),
      onChanged:(value){
        widget.onChanged(value);
        setState(() {

        });
      },
      validator: validator,
      onFieldSubmitted: widget.onSubmit,
      keyboardType: inputType,
      textCapitalization: TextCapitalization.words,
      cursorColor: COLORS.gray,
      decoration: filterFieldDecoration(iconTap: widget.iconTap,labelText: widget.hintText,clearIconTap: widget.clearIconTap,filterText: widget.filterText,controller: widget.controller,),
    );
  }
}








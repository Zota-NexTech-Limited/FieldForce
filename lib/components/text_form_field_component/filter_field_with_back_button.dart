import 'dart:ui';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/decoration_helpers/text_form_field_decoration-helpers/filter_field_with_back_button_decoration.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';


class FilterFieldWithBackButton extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  TextInputType inputType;
  ValueChanged onChanged;
  ValueChanged onSubmit;
  bool isReadOnly;
  VoidCallback backButtonTap;
  String? Function(String?)? validator;
  FilterFieldWithBackButton({super.key,required this.onChanged,required this.controller,required this.hintText,required this.inputType,required this.validator,required this.isReadOnly,required this.backButtonTap,required this.onSubmit});

  @override
  State<FilterFieldWithBackButton> createState() => _FilterFieldWithBackButtonState();
}

class _FilterFieldWithBackButtonState extends State<FilterFieldWithBackButton> {
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
          color: COLORS.black,
          fontFamily: "Manrope",
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
      decoration: filterFieldWithBackButtonDecoration(iconTap: widget.backButtonTap,labelText: widget.hintText,controller: widget.controller,backButtonTap: widget.backButtonTap),
    );
  }
}








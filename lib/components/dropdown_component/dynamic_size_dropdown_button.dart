import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class DynamicSizeDropdownButton extends StatefulWidget {
  String? selectedValue;
  String? hint;
  List<String> list;
  ValueChanged<String?> onChanged;
  bool isError;
  DynamicSizeDropdownButton({super.key,required this.selectedValue,required this.list,required this.onChanged,required this.hint,required this.isError});

  @override
  State<DynamicSizeDropdownButton> createState() => _DynamicSizeDropdownButtonState();
}

class _DynamicSizeDropdownButtonState extends State<DynamicSizeDropdownButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = widget.list!.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
              BorderRadius.circular(SizeConfig.blockWidth * 1.5),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 2,
                  vertical: widget.selectedValue == value
                      ? SizeConfig.blockHeight * 1.4
                      : SizeConfig.blockHeight,
                ),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: widget.selectedValue == value
                      ? COLORS.primaryColor
                      : Colors.white,
                  border: Border(
                    bottom: BorderSide(
                        width: SizeConfig.blockWidth * 0.1,
                        color: COLORS.hintTextColor),
                  ),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                      color: widget.selectedValue == value
                          ? COLORS.onPrimaryColor
                          : COLORS.iconColor,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.blockWidth * 2.5,
                      fontFamily:  Config.fountFamilyPrimary
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
    return  DropdownButton2<String>(
      hint: Text(
        widget.hint!,
        style: TextStyle(
          color: COLORS.hintTextColor,
          fontFamily:  Config.fountFamilyPrimary,
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig.blockWidth * 3.5,
        ),
      ),
      iconStyleData: IconStyleData(icon: Icon(
        Icons.keyboard_arrow_down,
        color: COLORS.gray,
        size: SizeConfig.blockWidth * 6,
      ),),

      dropdownStyleData: DropdownStyleData(
        isOverButton: true,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
          color: COLORS.white,
        ),
        elevation: 2,
        maxHeight: SizeConfig.blockHeight * 35,
        offset: Offset(0, SizeConfig.blockHeight * -7.3),

      ),

      buttonStyleData: ButtonStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
          border: Border.all(color:widget.isError==true? COLORS.red:COLORS.gray, width: SizeConfig.blockWidth*0.2),
        ),
        width: SizeConfig.blockWidth * 100,
        height:  SizeConfig.blockHeight * 7.3,
        padding: EdgeInsets.only(
            left: SizeConfig.blockWidth * 3.5,
            right: SizeConfig.blockWidth * 2.5),

      ),
      menuItemStyleData: MenuItemStyleData(
        height: SizeConfig.blockHeight * 6.5,
      ),
      isDense: true,
      value: widget.selectedValue,
      underline: Container(),
      isExpanded: true,
      onChanged: (value){
        widget.onChanged!(value);
        setState(() {
          widget.selectedValue=value.toString();

        });
      },
      items: dropdownItems,
      selectedItemBuilder: (BuildContext context) {
        return widget.list!.map<Widget>((String value) {
          return Text(
            value,
            style: TextStyle(
                color: COLORS.iconColor,
                fontFamily: Config.fountFamilyPrimary,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                fontSize: SizeConfig.blockWidth * 2.7
            ),
          );
        }).toList();
      },
    );
  }
}






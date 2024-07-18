import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldforce/components/text_form_field_component/textformfield_with_suffix_icon.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/reuse_functions/date_picker.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:flutter/material.dart';
class ScheduleActivityScreen extends StatefulWidget {
  const ScheduleActivityScreen({super.key});

  @override
  State<ScheduleActivityScreen> createState() => _ScheduleActivityScreenState();
}

class _ScheduleActivityScreenState extends State<ScheduleActivityScreen> {
  String? selectedActivity;
  String? selectedAssignedTo;
  List<String> activityList=["example1"];
  List<String> assignedToList=["example1"];

  TextEditingController dueDateController=TextEditingController();
  TextEditingController summaryController=TextEditingController();
  TextEditingController noteController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: COLORS.white,
      appBar: appBarComponent(title: "Add My Activity", context: context),
          body: SingleChildScrollView(
            child: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth*2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const InputFieldTitleText(text: "Activity"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedActivity,
                      list: activityList,
                      onChanged: (value){
                        setState(() {
                          selectedActivity=value;
                        });
                      },
                      hint: "Select Activity"),
                  const InputFieldTitleText(text: "Due Date"),
                  TextFormFieldWithSuffixIcon(
                      onChanged:  (value){},
                      controller: dueDateController,
                      hintText: "due Date",
                      readOnly: true,
                      inputType: TextInputType.text,
                      validator: (value){
                        return null;
                      },
                      onTap: (){
                        setState(() {
                          showSingleDatePickerHelper(context: context,controller: dueDateController);
                        });
                        print("startDateController----------------${dueDateController.text}");
            
                      },
                      suffixIcon: "assets/image/svg_icons/calendar.svg"),
                  const InputFieldTitleText(text: "Assigned To"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedAssignedTo,
                      list: assignedToList,
                      onChanged: (value){
                        setState(() {
                          selectedAssignedTo=value;
                        });
                      },
                      hint: "Assigned To"),
                  const InputFieldTitleText(text: "Summary"),
                  MultiLineTextFormField(
                      onChanged: (value){},
                      controller: summaryController,
                      inputType: TextInputType.text,
                      validator:(value){return null;} ,
                      isReadOnly: false,
                      labelText: "Summary"
                  ),
                  const InputFieldTitleText(text: "Note"),
                  MultiLineTextFormField(
                      onChanged: (value){},
                      controller: noteController,
                      inputType: TextInputType.text,
                      validator:(value){return null;} ,
                      isReadOnly: false,
                      labelText: "Note"
                  ),
                  SizedBox(height: SizeConfig.blockHeight*3,),
                  NormalButton(title: "Schedule", onTap: (){}, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)
            
                ],
              ),
            ),
          ),
    ));
  }
}

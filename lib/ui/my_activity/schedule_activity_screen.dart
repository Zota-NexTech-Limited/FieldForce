import 'package:fieldsales/bloc/create_activity_bloc/create_activity_bloc.dart';
import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldsales/components/text_component/input_field_title_text.dart';
import 'package:fieldsales/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldsales/components/text_form_field_component/textformfield_with_suffix_icon.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/reuse_functions/date_picker.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/crm_models/create_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  late CreateActivityBloc createActivityBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createActivityBloc=BlocProvider.of<CreateActivityBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:BlocListener<CreateActivityBloc,CreateActivityState>(listener: (context, state) {
          if(state is CreateActivityLoadingState)
            {

            }else if(state is CreateActivitySuccessState)
              {
                final snackBar = SnackBar(content: Text(state.message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
               Navigator.pop(context);
              }else if(state is CreateActivityFailedState)
                {
                  final snackBar = SnackBar(content: Text(state.message));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
          setState(() {

          });
        },child:  Scaffold(
          backgroundColor: COLORS.white,
          appBar: appBarComponent(title: "Add My Activity", context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth*3,
            ),
            child: ListView(
             // crossAxisAlignment: CrossAxisAlignment.start,
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
                    isError: false,
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
                    isError: false,
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


              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: SizeConfig.blockHeight*8,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,),
            child: Column(
              children: [
                NormalButton(title: "Schedule", onTap: (){
                  setState(() {
                    CreateActivityModel activityDetails=CreateActivityModel(
                        activityName: selectedActivity,
                        activityDueDate: dueDateController.text,
                        activityAssignTo: selectedAssignedTo,
                        activitySummary: summaryController.text,
                        activityNotes: noteController.text
                    );
                    createActivityBloc.add(CreateNewActivityEvent(activityDetails: activityDetails));
                  });
                }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)
              ],
            ),
          ),
        ),)



    );
  }
}

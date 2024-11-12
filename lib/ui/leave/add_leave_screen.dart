//import 'package:fieldsales/bloc/create_activity_bloc/create_activity_bloc.dart';
import 'package:fieldsales/bloc/add_leave_bloc/add_leave_bloc.dart';
import 'package:fieldsales/bloc/leave_list_bloc/leave_list_bloc.dart';
import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldsales/components/text_component/input_field_title_text.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldsales/components/text_form_field_component/textformfield_with_suffix_icon.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/reuse_functions/date_picker.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/leave/leave_model.dart';
import 'package:fieldsales/ui/leave/leave_screen.dart';
//import 'package:fieldsales/models/crm_models/create_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AddLeaveScreen extends StatefulWidget {
  const AddLeaveScreen({super.key});

  @override
  State<AddLeaveScreen> createState() => _AddLeaveScreenState();
}

class _AddLeaveScreenState extends State<AddLeaveScreen> {
  String? selectedLeaveType;
  String? selectedAssignedTo;
  List<String> leaveTypeList=["example1"];
  List<String> assignedToList=["example1"];

  TextEditingController fromDateController=TextEditingController();
  TextEditingController toDateController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

   bool isHalfDay=false;
  late AddLeaveBloc addLeaveBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addLeaveBloc=BlocProvider.of<AddLeaveBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:BlocListener<AddLeaveBloc,AddLeaveState>(listener: (context, state) {
          if(state is AddLeaveLoadingState)
          {

          }else if(state is AddLeaveSuccessState)
          {
            final snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>LeaveListBloc()..add(const FetchLeaveListEvent()),child: LeaveScreen(),)));
          }else if(state is AddLeaveFailedState)
          {
            final snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          setState(() {

          });
        },child:  Scaffold(
          backgroundColor: COLORS.white,
          appBar: appBarComponent(title: "Add Leave", context: context),
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
                  const InputFieldTitleText(text: "Leave Type *"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedLeaveType,
                      list: leaveTypeList,
                      onChanged: (value){
                        setState(() {
                          selectedLeaveType=value;
                        });
                      },
                      isError: false,
                      hint: "Select Leave Type"),
                  const InputFieldTitleText(text: "From Date"),
                  TextFormFieldWithSuffixIcon(
                      onChanged:  (value){},
                      controller: fromDateController,
                      hintText: "From Date",
                      readOnly: true,
                      inputType: TextInputType.text,
                      validator: (value){
                        return null;
                      },
                      onTap: (){
                        setState(() {
                          showSingleDatePickerHelper(context: context,controller: fromDateController);
                        });
                        print("fromDateController----------------${fromDateController.text}");

                      },
                      suffixIcon: "assets/image/svg_icons/calendar.svg"),
                  const InputFieldTitleText(text: "To Date"),
                  TextFormFieldWithSuffixIcon(
                      onChanged:  (value){},
                      controller: toDateController,
                      hintText: "To Date",
                      readOnly: true,
                      inputType: TextInputType.text,
                      validator: (value){
                        return null;
                      },
                      onTap: (){
                        setState(() {
                          showSingleDatePickerHelper(context: context,controller: toDateController);
                        });
                        print("toDateController----------------${toDateController.text}");

                      },
                      suffixIcon: "assets/image/svg_icons/calendar.svg"),
                  const InputFieldTitleText(text: "Description"),
                  MultiLineTextFormField(
                      onChanged: (value){},
                      controller: descriptionController,
                      inputType: TextInputType.text,
                      validator:(value){return null;} ,
                      isReadOnly: false,
                      labelText: "Description"
                  ),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  Row(
                    children: [
                      Checkbox(

                        side: BorderSide(color:COLORS.gray,width: SizeConfig.blockWidth*0.5) ,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1.5))),
                          value: isHalfDay,
                          activeColor: COLORS.primaryColor,
                          onChanged: (value){
                            setState(() {
                              isHalfDay=value!;

                            });
                          }),
                      NormalText(fontWeight: FontWeight.w600, color: COLORS.black, fontSize: 2.2, text:"Half Day"),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight*3,),

                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: SizeConfig.blockHeight*8,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,),
            child: Column(
              children: [
                NormalButton(title: "Submit Leave", onTap: (){
                  setState(() {

                    Leave leaveDetails=Leave(
                      leaveType: selectedLeaveType,
                      leaveFromDate:DateTime.parse(fromDateController.text).add(Duration(hours: 5, minutes: 30)) ,
                      leaveToDate: DateTime.parse(toDateController.text).add(Duration(hours: 5, minutes: 30)),
                      description: descriptionController.text,
                      isHalfday: isHalfDay
                    );
                    addLeaveBloc.add(AddNewLeaveEvent(leaveDetails: leaveDetails));
                  });
                }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)
              ],
            ),
          ),
        ),)



    );
  }
}

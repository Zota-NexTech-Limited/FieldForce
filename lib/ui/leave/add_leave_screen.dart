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
import 'package:intl/intl.dart';
class AddLeaveScreen extends StatefulWidget {
  const AddLeaveScreen({super.key});

  @override
  State<AddLeaveScreen> createState() => _AddLeaveScreenState();
}

class _AddLeaveScreenState extends State<AddLeaveScreen> {
  String? selectedLeaveType;
  String? selectedAssignedTo;
  List<String> leaveTypeList=["Paid Time Off (PL)","CL + SL-2023","Unpaid (LWP)"];
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
          backgroundColor: COLORS.scaffoldBg,
          appBar: appBarComponent(title: "Add Leave", context: context),
          body: SingleChildScrollView(
            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.fromLTRB(
                SizeConfig.blockWidth*4,
                SizeConfig.blockHeight*2,
                SizeConfig.blockWidth*4,
                SizeConfig.blockHeight*4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: SizeConfig.blockHeight*2.5,),
                  _buildCard(
                    children: [
                      _sectionLabel("Leave Type *"),
                      SizedBox(height: SizeConfig.blockHeight*1,),
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
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  _buildCard(
                    children: [
                      _sectionLabel("Duration"),
                      SizedBox(height: SizeConfig.blockHeight*1,),
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
                      SizedBox(height: SizeConfig.blockHeight*2,),
                      _buildHalfDayTile(),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  _buildCard(
                    children: [
                      _sectionLabel("Description"),
                      SizedBox(height: SizeConfig.blockHeight*0.5,),
                      MultiLineTextFormField(
                          onChanged: (value){},
                          controller: descriptionController,
                          inputType: TextInputType.text,
                          validator:(value){return null;} ,
                          isReadOnly: false,
                          labelText: "Description"
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(
              SizeConfig.blockWidth*4,
              SizeConfig.blockHeight*1.5,
              SizeConfig.blockWidth*4,
              SizeConfig.blockHeight*2,
            ),
            decoration: BoxDecoration(
              color: COLORS.white,
              border: Border(top: BorderSide(color: COLORS.divider, width: 1)),
              boxShadow: [
                BoxShadow(
                  color: COLORS.shadow,
                  blurRadius: 16,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: NormalButton(title: "Submit Leave", onTap: (){
                setState(() {

                  Leave leaveDetails=Leave(
                    leaveType: selectedLeaveType,
                    leaveFromDate:DateFormat('yyyy-MM-dd').parse(fromDateController.text).add(Duration(hours: 5, minutes: 30)) ,
                    leaveToDate: DateFormat('yyyy-MM-dd').parse(toDateController.text).add(Duration(hours: 5, minutes: 30)),
                    description: descriptionController.text,
                    isHalfday: isHalfDay
                  );
                  addLeaveBloc.add(AddNewLeaveEvent(leaveDetails: leaveDetails));
                });
              }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth),
            ),
          ),
        ),)



    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: SizeConfig.blockWidth*12,
          height: SizeConfig.blockWidth*12,
          decoration: BoxDecoration(
            color: COLORS.primarySoft,
            borderRadius: BorderRadius.circular(SizeConfig.blockWidth*3.5),
          ),
          child: Icon(
            Icons.event_busy_rounded,
            color: COLORS.primaryColor,
            size: SizeConfig.blockWidth*6,
          ),
        ),
        SizedBox(width: SizeConfig.blockWidth*3.5,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Request Leave",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: SizeConfig.blockHeight*2.6,
                  fontWeight: FontWeight.w700,
                  color: COLORS.textPrimary,
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight*0.4,),
              Text(
                "Fill in the details to submit your request",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: SizeConfig.blockHeight*1.7,
                  fontWeight: FontWeight.w400,
                  color: COLORS.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth*4,
        vertical: SizeConfig.blockHeight*1,
      ),
      decoration: BoxDecoration(
        color: COLORS.surface,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth*4.5),
        border: Border.all(color: COLORS.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: COLORS.shadow,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockHeight*1.5),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: SizeConfig.blockHeight*1.9,
          fontWeight: FontWeight.w600,
          color: COLORS.textSecondary,
        ),
      ),
    );
  }

  Widget _buildHalfDayTile() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth*3,
        vertical: SizeConfig.blockHeight*0.5,
      ),
      decoration: BoxDecoration(
        color: isHalfDay ? COLORS.primarySoft : COLORS.surfaceMuted,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth*3),
        border: Border.all(
          color: isHalfDay ? COLORS.primaryLight : COLORS.outline,
          width: 1,
        ),
      ),
      child: Row(
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
          SizedBox(width: SizeConfig.blockWidth*1,),
          Expanded(
            child: NormalText(fontWeight: FontWeight.w600, color: COLORS.textPrimary, fontSize: 2.0, text:"Half Day"),
          ),
        ],
      ),
    );
  }
}

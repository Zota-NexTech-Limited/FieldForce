import 'package:fieldsales/bloc/create_activity_bloc/create_activity_bloc.dart';
import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldsales/components/text_component/input_field_title_text.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldsales/components/text_form_field_component/textformfield_with_suffix_icon.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/reuse_functions/date_picker.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/crm/lead_screens/history_screen.dart';
import 'package:fieldsales/ui/my_activity/schedule_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
class AddOpportunityDetailsScreen extends StatefulWidget {
  const AddOpportunityDetailsScreen({super.key});

  @override
  State<AddOpportunityDetailsScreen> createState() => _AddOpportunityDetailsScreenState();
}

class _AddOpportunityDetailsScreenState extends State<AddOpportunityDetailsScreen> {
  ///text controllers
  TextEditingController contactNameController=TextEditingController();
  TextEditingController professionController=TextEditingController();
  TextEditingController mobileNumberController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController startDateController=TextEditingController();
  TextEditingController rmRemarkController=TextEditingController();

  ///drop down values
  String? selectedInquirySource;
  String? selectedInquiryCategory;
  String? selectedFinancialStatus;
  String? selectedStoreLocation;
  String? selectedWelcomeMessageSent;
  String? selectedStatus;
  String? selectedProspectStatus;


  List<String> inquirySourceList=["example1"];
  List<String> inquiryCategoryList=["example1"];
  List<String> financialStatusList=["example1"];
  List<String> storeLocationList=["example1"];
  List<String> welcomeMessageSentList=["example1"];
  List<String> statusList=["example1"];
  List<String> prospectStatusList=["example1"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: COLORS.white,
          appBar: appBarComponent(title: "mkumara@zotanextech.com", context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*2,vertical: SizeConfig.blockHeight*2),
                    child: Row(
                      children: [
                        Container(
                          height: SizeConfig.blockHeight*8,
                          width: SizeConfig.blockWidth*14,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
                              border: Border.all(color: COLORS.white)
                          ),
                          child: Image.asset("assets/image/common/profile_image.png",fit: BoxFit.fill,),
                        ),
                        SizedBox(width: SizeConfig.blockWidth*2,),
                        const NormalText(fontWeight: FontWeight.w400, color: COLORS.black, fontSize: 2.4, text: "MaheshKumara M P"),
                        const Spacer(),
                        Stack(
                          children: [
                            SizedBox(
                              width: SizeConfig.blockWidth*13,
                              child: CircularPercentIndicator(
                                radius: SizeConfig.blockWidth*5.5,
                                lineWidth: SizeConfig.blockWidth*0.3,
                                percent: 0.4,
                                progressColor: COLORS.primaryColor,

                              ),
                            ),
                            Positioned(
                                top: SizeConfig.blockHeight*2,
                                left: SizeConfig.blockWidth*4,
                                child: NormalText(color:COLORS.black ,fontSize: 1.7,fontWeight: FontWeight.w500,text: "40%",))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  const InputFieldTitleText(text: "Inquiry Source"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedInquirySource,
                      list: inquirySourceList,
                      hint: "Select Inquiry Source",
                      isError: false,
                      onChanged: (value){
                        setState(() {
                          selectedInquirySource=value;
                        });
                      }
                  ),
                  const InputFieldTitleText(text: "Inquiry Category"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedInquiryCategory,
                      list: inquiryCategoryList,
                      hint: "Select Inquiry Category",
                      isError: false,
                      onChanged: (value){
                        setState(() {
                          selectedInquiryCategory=value;
                        });
                      }
                  ),
                  const InputFieldTitleText(text: "Contact Name"),
                  NormalTextFormField(
                      onChanged: (value){
                      },
                      controller: contactNameController,
                      hintText: "Contact Name",
                      inputType: TextInputType.text,
                      validator: (value){
                        return null;
                      },
                      readOnly: false
                  ),
                  const InputFieldTitleText(text: "Profession"),
                  NormalTextFormField(
                      onChanged: (value){
                      },
                      controller: professionController,
                      hintText: "profession",
                      inputType: TextInputType.text,
                      validator: (value){
                        return null;
                      },
                      readOnly: false
                  ),
                  const InputFieldTitleText(text: "Mobile Number"),
                  TextFormFieldWithSuffixIcon(
                      onChanged:  (value){

                      },
                      readOnly: false,
                      controller: mobileNumberController,
                      hintText: "Mobile Number",
                      inputType: TextInputType.phone,
                      validator: (value){
                        return null;
                      },
                      onTap: (){},
                      suffixIcon: "assets/image/svg_icons/phone_icon.svg"),
                  const InputFieldTitleText(text: "Phone"),
                  TextFormFieldWithSuffixIcon(
                      onChanged:  (value){

                      },
                      controller: phoneController,
                      hintText: "Phone",
                      readOnly: false,
                      inputType: TextInputType.phone,
                      validator: (value){
                        return null;
                      },
                      onTap: (){},
                      suffixIcon: "assets/image/svg_icons/phone_icon.svg"),
                  const InputFieldTitleText(text: "Start Date"),
                  TextFormFieldWithSuffixIcon(
                      onChanged:  (value){},
                      controller: startDateController,
                      hintText: "Start Date",
                      readOnly: true,
                      inputType: TextInputType.text,
                      validator: (value){
                        return null;
                      },
                      onTap: (){
                        setState(() {
                          showSingleDatePickerHelper(context: context,controller: startDateController);
                        });
                        print("startDateController----------------${startDateController.text}");

                      },
                      suffixIcon: "assets/image/svg_icons/calendar.svg"),
                  const InputFieldTitleText(text: "RM Remark"),
                  NormalTextFormField(
                      onChanged: (value){
                      },
                      controller: rmRemarkController,
                      hintText: "RM Remark",
                      inputType: TextInputType.text,
                      validator: (value){
                        return null;
                      },
                      readOnly: false
                  ),

                  const InputFieldTitleText(text: "Financial Status"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedFinancialStatus,
                      list: financialStatusList,
                      hint: "Select Financial Status",
                      isError: false,
                      onChanged: (value){
                        setState(() {
                          selectedFinancialStatus=value;
                        });
                      }
                  ),
                  const InputFieldTitleText(text: "Store Location"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedStoreLocation,
                      list: storeLocationList,
                      hint: "Select Store Location",
                      isError: false,
                      onChanged: (value){
                        setState(() {
                          selectedStoreLocation=value;
                        });
                      }
                  ),
                  const InputFieldTitleText(text: "Welcome Message"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedWelcomeMessageSent,
                      list: welcomeMessageSentList,
                      hint: "Select Welcome Message",
                      isError: false,
                      onChanged: (value){
                        setState(() {
                          selectedWelcomeMessageSent=value;
                        });
                      }
                  ),
                  const InputFieldTitleText(text: " Status"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedStatus,
                      list: statusList,
                      hint: "Select Status",
                      isError: false,
                      onChanged: (value){
                        setState(() {
                          selectedStatus=value;
                        });
                      }
                  ),
                  const InputFieldTitleText(text: "Prospect Status"),
                  SingleItemSelectDropdown(
                      selectedValue: selectedProspectStatus,
                      list: prospectStatusList,
                      hint: "Select Prospect Status",
                      isError: false,
                      onChanged: (value){
                        setState(() {
                          selectedProspectStatus=value;
                        });
                      }
                  ),
                  const InputFieldTitleText(text: "Last Updated By Maheshkumara M P (ETHICS) 01/07/2024 02:41:44"),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  NormalButton(title: "Show History", onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LeadHistoryScreen()));
                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  NormalButton(title: "Schedule Activity", onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>CreateActivityBloc(),child:const ScheduleActivityScreen(),)));
                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth),
                  SizedBox(height: SizeConfig.blockHeight*5,),




                ],
              ),
            ),
          ),
        )
    );
  }
}

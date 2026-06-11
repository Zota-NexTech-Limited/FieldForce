import 'package:fieldsales/bloc/create_activity_bloc/create_activity_bloc.dart';
import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldsales/components/svg_image_component.dart';
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
class AddLeadDetailsScreen extends StatefulWidget {
  const AddLeadDetailsScreen({super.key});

  @override
  State<AddLeadDetailsScreen> createState() => _AddLeadDetailsScreenState();
}

class _AddLeadDetailsScreenState extends State<AddLeadDetailsScreen> {
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
          backgroundColor: COLORS.scaffoldBg,
          appBar: appBarComponent(title: "7337722939", context: context),
          body: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                SizeConfig.blockWidth * 4,
                SizeConfig.blockHeight * 2,
                SizeConfig.blockWidth * 4,
                SizeConfig.blockHeight * 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileCard(),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),
                  _buildSectionCard(
                    title: "Inquiry Details",
                    icon: Icons.assignment_outlined,
                    children: [
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
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),
                  _buildSectionCard(
                    title: "Contact Information",
                    icon: Icons.person_outline,
                    children: [
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
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2.5),
                  _buildSectionCard(
                    title: "Lead Details",
                    icon: Icons.fact_check_outlined,
                    children: [
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
                      SizedBox(height: SizeConfig.blockHeight * 2),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockWidth * 3,
                          vertical: SizeConfig.blockHeight * 1.5,
                        ),
                        decoration: BoxDecoration(
                          color: COLORS.infoSoft,
                          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.history, size: SizeConfig.blockHeight * 2.2, color: COLORS.info),
                            SizedBox(width: SizeConfig.blockWidth * 2),
                            Expanded(
                              child: Text(
                                "Last Updated By Maheshkumara M P (ETHICS) 01/07/2024 02:41:44",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: SizeConfig.blockHeight * 1.7,
                                  fontWeight: FontWeight.w500,
                                  color: COLORS.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 3),
                  NormalButton(title: "Show History", onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LeadHistoryScreen()));
                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  NormalButton(title: "Archive(Delete) Lead", onTap: (){}, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  NormalButton(title: "Convert to Opportunity", onTap: (){}, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth),
                  SizedBox(height: SizeConfig.blockHeight*2,),
                  NormalButton(title: "Schedule Activity", onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>CreateActivityBloc(),child:const ScheduleActivityScreen(),)));
                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth),
                  SizedBox(height: SizeConfig.blockHeight*3,),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 2.2,
      ),
      decoration: BoxDecoration(
        color: COLORS.surface,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4.5),
        border: Border.all(color: COLORS.cardBorder),
        boxShadow: [
          BoxShadow(
            color: COLORS.shadow,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: SizeConfig.blockHeight * 8,
            width: SizeConfig.blockWidth * 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth * 3)),
              border: Border.all(color: COLORS.cardBorder),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset("assets/image/common/profile_image.png", fit: BoxFit.cover),
          ),
          SizedBox(width: SizeConfig.blockWidth * 3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MaheshKumara M P",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: SizeConfig.blockHeight * 2.3,
                    fontWeight: FontWeight.w700,
                    color: COLORS.textPrimary,
                  ),
                ),
                SizedBox(height: SizeConfig.blockHeight * 0.5),
                Text(
                  "Lead profile completion",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: SizeConfig.blockHeight * 1.6,
                    fontWeight: FontWeight.w500,
                    color: COLORS.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: SizeConfig.blockWidth * 2),
          Stack(
            alignment: Alignment.center,
            children: [
              CircularPercentIndicator(
                radius: SizeConfig.blockWidth * 6,
                lineWidth: SizeConfig.blockWidth * 1.1,
                percent: 0.4,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: COLORS.primarySoft,
                progressColor: COLORS.primaryColor,
              ),
              Text(
                "40%",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: SizeConfig.blockHeight * 1.7,
                  fontWeight: FontWeight.w700,
                  color: COLORS.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        SizeConfig.blockWidth * 4,
        SizeConfig.blockHeight * 1,
        SizeConfig.blockWidth * 4,
        SizeConfig.blockHeight * 2.5,
      ),
      decoration: BoxDecoration(
        color: COLORS.surface,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4.5),
        border: Border.all(color: COLORS.cardBorder),
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
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.blockHeight * 1.5),
            child: Row(
              children: [
                Container(
                  height: SizeConfig.blockHeight * 4.5,
                  width: SizeConfig.blockHeight * 4.5,
                  decoration: BoxDecoration(
                    color: COLORS.primarySoft,
                    borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2.5),
                  ),
                  child: Icon(icon, size: SizeConfig.blockHeight * 2.4, color: COLORS.primaryColor),
                ),
                SizedBox(width: SizeConfig.blockWidth * 3),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: SizeConfig.blockHeight * 2.1,
                    fontWeight: FontWeight.w700,
                    color: COLORS.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockHeight * 0.5),
          Divider(color: COLORS.divider, height: SizeConfig.blockHeight * 2),
          ...children,
        ],
      ),
    );
  }
}

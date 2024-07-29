import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button_with_icon.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/ui/crm/opportunity_screens/add_new_opportunity_screens/opportunity_source_information_screen.dart';
import 'package:flutter/material.dart';
class OpportunityContactInformationScreen extends StatefulWidget {
  const OpportunityContactInformationScreen({super.key});

  @override
  State<OpportunityContactInformationScreen> createState() => _OpportunityContactInformationScreenState();
}

class _OpportunityContactInformationScreenState extends State<OpportunityContactInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController emailAddressController=TextEditingController();
  TextEditingController contactNameController=TextEditingController();
  TextEditingController companyNameController=TextEditingController();
  String? selectedIndustry;
  List<String> industryList=[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarComponent(title: "contact Information", context: context),
        body: Form(
          key: _formKey,
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InputFieldTitleText(text: "Contact Name *"),
                NormalTextFormField(
                    onChanged: (value){
                    },
                    controller: contactNameController,
                    hintText: "Enter Name Here",
                    inputType: TextInputType.text,
                    validator: (value){
                      if(value==null||value.isEmpty)
                      {
                        return "Contact Name is Empty";
                      }
                      return null;
                    },
                    readOnly: false
                ),
                const InputFieldTitleText(text: "Email address *"),
                NormalTextFormField(
                    onChanged: (value){},
                    controller: emailAddressController,
                    hintText: "Enter Customer Email Address",
                    inputType: TextInputType.emailAddress,
                    validator: (value){
                      String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regex = RegExp(pattern);
                      if (value!.trim().isEmpty) {
                        return 'Email is Empty';
                      } else if (!regex.hasMatch(value)) {
                        return 'Email is not valid';
                      }
                      return null;
                    },
                    readOnly: false
                ),
                const InputFieldTitleText(text: "Phone Number *"),
                NormalTextFormField(
                    onChanged: (value){},
                    controller: phoneNumberController,
                    hintText: "Enter Customer Mobile Number",
                    inputType: TextInputType.phone,
                    validator: (value){
                      RegExp regex = RegExp(r"^\d{10}$");
                      if (!regex.hasMatch(value!)) {
                        return 'Phone Number is not valid';
                      }
                      return null;
                    },
                    readOnly: false
                ),
                const InputFieldTitleText(text: "Company  Name *"),
                NormalTextFormField(
                    onChanged: (value){
                    },
                    controller: companyNameController,
                    hintText: "Enter Company Name Here",
                    inputType: TextInputType.text,
                    validator: (value){
                      if(value==null||value.isEmpty)
                      {
                        return "Company Name is Empty";
                      }
                      return null;
                    },
                    readOnly: false
                ),
                const InputFieldTitleText(text: "Industry"),
                SingleItemSelectDropdown(
                    selectedValue: selectedIndustry,
                    list: industryList,
                    onChanged: (value)
                    {
                      setState(() {
                        selectedIndustry=value!;
                      });
                    },
                    hint: "Select Industry",
                    isError: false),
                const Spacer(),
                NormalButtonWithIcon(title: "Next Step", onTap: (){

                  if(_formKey.currentState!.validate())
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const OpportunitySourceInformationScreen()));
                    print('hgjn');
                  }

                }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth),
                SizedBox(height: SizeConfig.blockHeight*3,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

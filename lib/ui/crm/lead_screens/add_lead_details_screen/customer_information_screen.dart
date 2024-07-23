import 'package:fieldforce/bloc/get_address-by_pincode/get_address_by_pin_code_bloc.dart';
import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button_with_icon.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/contact_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CustomerInformationScreen extends StatefulWidget {
  const CustomerInformationScreen({super.key});
  @override
  State<CustomerInformationScreen> createState() => _CustomerInformationScreenState();
}
class _CustomerInformationScreenState extends State<CustomerInformationScreen> {
  TextEditingController fullNameController=TextEditingController();
  TextEditingController contactNameController=TextEditingController();
  TextEditingController contactTitleController=TextEditingController();
  TextEditingController companyNameController=TextEditingController();
  TextEditingController companySizeController=TextEditingController();
  TextEditingController industryController=TextEditingController();
  String? selectedCustomerSource;
  List<String> customerSourceList=["Existing Customer","Referral","Marketing Campaign","Other"];

   NewLeadModel leadDetails=NewLeadModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: COLORS.white,
          appBar: appBarComponent(title: "Customer Information",context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InputFieldTitleText(text: "Full Name *"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: fullNameController,
                      hintText: "Name of the inquirer or company",
                      inputType: TextInputType.text,
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return "Full Name is Empty";
                        }
                        return null;
                      },
                      readOnly: false
                  ),
                   const InputFieldTitleText(text: "Contact Name *"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: contactNameController,
                      hintText: "Name of the primary contact person",
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
                  const InputFieldTitleText(text: "Contact Title *"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: contactTitleController,
                      hintText: "Job title of the contact person",
                      inputType: TextInputType.text,
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return "Contact Title is Empty";
                        }
                        return null;
                      },
                      readOnly: false
                  ),
                  const InputFieldTitleText(text: "Company Name"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: companyNameController,
                      hintText: "Name of the company (if applicable)",
                      inputType: TextInputType.text,
                      validator: (value){
              
                        return null;
                      },
                      readOnly: false
                  ),
                  const InputFieldTitleText(text: "Company Size"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: companySizeController,
                      hintText: "Size of the company (if applicable)",
                      inputType: TextInputType.text,
                      validator: (value){
              
                        return null;
                      },
                      readOnly: false
                  ),
                  const InputFieldTitleText(text: "Industry"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: industryController,
                      hintText: "Industry the company operates in (if applicable)",
                      inputType: TextInputType.text,
                      validator: (value){
                        return null;
                      },
                      readOnly: false
                  ),
                  const InputFieldTitleText(text: "Customer Source *"),
                 SingleItemSelectDropdown(selectedValue: selectedCustomerSource, list: customerSourceList, onChanged: (value){
                   setState(() {
                     selectedCustomerSource=value;
                   });
                 }, hint: "Select how the customer was acquired"),
                  SizedBox(height: SizeConfig.blockHeight*3,),
                  NormalButtonWithIcon(title: "Next Step", onTap: (){

                    setState(() {
                      leadDetails=NewLeadModel(
                        leadFullName: fullNameController.text,
                        leadContactName: contactNameController.text,
                        leadContactTitle: contactTitleController.text,
                        leadCompanyName: companyNameController.text,
                        leadCompanySize: companySizeController.text,
                        leadIndustry: industryController.text,
                        leadSource: selectedCustomerSource

                      );


                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>GetAddressByPinCodeBloc(),child:ContactDetailsScreen(leadDetails:leadDetails,) ,) ));
                    });

                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)
                ],
              ),
            ),
          ),
        ));
  }
}

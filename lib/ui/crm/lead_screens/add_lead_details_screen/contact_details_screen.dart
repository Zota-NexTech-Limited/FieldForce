import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button_with_icon.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/product_or_service_details_screen.dart';
import 'package:flutter/material.dart';
class ContactDetailsScreen extends StatefulWidget {
  const ContactDetailsScreen({super.key});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController emailAddressController=TextEditingController();
  TextEditingController websiteController=TextEditingController();
  TextEditingController pinCodeController=TextEditingController();
  TextEditingController addressController=TextEditingController();

  String? selectedState;
  List<String> stateList=[];

  String? selectedCity;
  List<String> cityList=[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: COLORS.white,
          appBar: appBarComponent(title: "Contact Details",context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InputFieldTitleText(text: "Phone Number *"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: phoneNumberController,
                      hintText: "Enter Customer Mobile Number",
                      inputType: TextInputType.phone,
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return "Phone Number is Empty";
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
                        if(value==null||value.isEmpty)
                        {
                          return "Email address is Empty";
                        }
                        return null;
                      },
                      readOnly: false
                  ),

                  const InputFieldTitleText(text: "Website *"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: websiteController,
                      hintText: "Website URL here",
                      inputType: TextInputType.text,
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return "Website is Empty";
                        }
                        return null;
                      },
                      readOnly: false
                  ),

                  const InputFieldTitleText(text: "Address"),
                  const InputFieldTitleText(text: "State *"),
                  SingleItemSelectDropdown(selectedValue: selectedState, list: stateList, onChanged: (value){
                    setState(() {
                      selectedState=value;
                    });
                  }, hint: "State"),

                  const InputFieldTitleText(text: "City *"),
                  SingleItemSelectDropdown(selectedValue: selectedCity, list: cityList, onChanged: (value){
                    setState(() {
                      selectedCity=value;
                    });
                  }, hint: "City"),



                  const InputFieldTitleText(text: "PinCode *"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: pinCodeController,
                      hintText: "000 000",
                      inputType: TextInputType.phone,
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return "PinCode is Empty";
                        }
                        return null;
                      },
                      readOnly: false
                  ),

                  const InputFieldTitleText(text: "Address *"),
                  MultiLineTextFormField(onChanged: (value){}, controller: addressController, inputType: TextInputType.text, validator: (value){
                    if(value==null||value.isEmpty)
                    {
                      return " Address is Empty";
                    }
                    return null;
                  }, isReadOnly: false, labelText: "Address"),

                  SizedBox(height: SizeConfig.blockHeight*3,),
                  NormalButtonWithIcon(title: "Next Step", onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProductOrServiceDetailsScreen()));
                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)

                ],
              ),
            ),
          ),
        ));
  }
}

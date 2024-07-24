import 'package:fieldforce/bloc/get_address-by_pincode/get_address_by_pin_code_bloc.dart';
import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button_with_icon.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/product_or_service_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ContactDetailsScreen extends StatefulWidget {
   NewLeadModel leadDetails;
   ContactDetailsScreen({super.key,required this.leadDetails});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController emailAddressController=TextEditingController();
  TextEditingController websiteController=TextEditingController();
  TextEditingController pinCodeController=TextEditingController();
  TextEditingController addressController=TextEditingController();


  String? selectedState;
  List<String> stateList=[];

  String? selectedCity;
  List<String> cityList=[];
  late NewLeadModel leadDetails;
  late GetAddressByPinCodeBloc getAddressByPinCodeBloc;

  bool isStateDropdownIsEmpty=false;
  bool isCityDropdownIsEmpty=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leadDetails=widget.leadDetails;
    getAddressByPinCodeBloc=BlocProvider.of<GetAddressByPinCodeBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:BlocListener<GetAddressByPinCodeBloc,GetAddressByPinCodeState>(listener: (context, state) {
              if(state is FetchAddressByPinCodeLoadingState)
            {

            }else if(state is FetchAddressByPinCodeSuccessState)
              {
                final snackBar = SnackBar(content: Text("Success"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                  if(!state.areaList.contains(cityList))
                    {

                      selectedCity=null;
                      selectedState=null;
                    }
                  cityList=state.cityList;
                  stateList=state.stateList;
                  if(cityList.isNotEmpty&&stateList.isNotEmpty)
                    {
                      selectedState=stateList[0];
                      selectedCity=cityList[0];
                         isStateDropdownIsEmpty=false;
                          isCityDropdownIsEmpty=false;
                    }
                });

              }else if(state is FetchAddressByPinCodeFailedState)
                {
                  final snackBar = SnackBar(content: Text(state.message));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                   selectedCity=null;
                   selectedState=null;
                   cityList=[];
                   stateList=[];
                  });
                }
          setState(() {

          });
        },child: Form(
          key: _formKey,
          child: Scaffold(
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
                          RegExp regex = RegExp(r"^\d{10}$");
                          if (!regex.hasMatch(value!)) {
                            return 'Phone Number is not valid';
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

                    const InputFieldTitleText(text: "Website "),
                    NormalTextFormField(
                        onChanged: (value){},
                        controller: websiteController,
                        hintText: "Website URL here",
                        inputType: TextInputType.text,
                        validator: (value){
                          // if(value==null||value.isEmpty)
                          // {
                          //   return "Website is Empty";
                          // }
                           return null;
                        },
                        readOnly: false
                    ),

                    const InputFieldTitleText(text: "Address"),

                    const InputFieldTitleText(text: "PinCode *"),
                    NormalTextFormField(
                        onChanged: (value){
                          setState(() {
                            if(value.length==6){
                              getAddressByPinCodeBloc.add(FetchAddressByPinCodeEvent(pinCode: pinCodeController.text));
                            }
                          });
                        },
                        controller: pinCodeController,
                        hintText: "000 000",
                        inputType: TextInputType.phone,
                        validator: (value){
                          RegExp regex = RegExp(r"^\d{6}$");
                          if (!regex.hasMatch(value!)) {
                            return 'PinCode is Not Valid';
                          }
                          return null;

                        },
                        readOnly: false
                    ),
                    const InputFieldTitleText(text: "State *"),
                    SingleItemSelectDropdown(selectedValue: selectedState, list: stateList,
                        isError: isStateDropdownIsEmpty,
                        onChanged: (value){
                      setState(() {
                        selectedState=value;
                        isStateDropdownIsEmpty=false;
                      });
                    }, hint: "State"),

                    const InputFieldTitleText(text: "City *"),
                    SingleItemSelectDropdown(selectedValue: selectedCity, list: cityList,
                        isError: isCityDropdownIsEmpty,
                        onChanged: (value){
                      setState(() {
                        selectedCity=value;
                        isCityDropdownIsEmpty=false;

                      });
                    }, hint: "City"),




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

                    setState(() {
                      if(selectedState==null)
                      {
                        isStateDropdownIsEmpty=true;
                      }

                      if(selectedCity==null)
                      {
                        isCityDropdownIsEmpty=true;
                      }

                      if(_formKey.currentState!.validate())
                        {
                          if(isStateDropdownIsEmpty==false&&isCityDropdownIsEmpty==false){
                            setState(() {
                              leadDetails.leadPhoneNumber= phoneNumberController.text;
                              leadDetails.leadEmail= emailAddressController.text;
                              leadDetails.leadWebsite= websiteController.text;
                              leadDetails.leadState= selectedState;
                              leadDetails.leadCity= selectedCity;
                              leadDetails.leadPincode= pinCodeController.text;
                              leadDetails.leadAddress= addressController.text;



                              Navigator.push(context, MaterialPageRoute(builder: (context)=>  ProductOrServiceDetailsScreen(leadDetails:leadDetails,)));
                            });
                          }

                        }
                    });

                    }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)

                  ],
                ),
              ),
            ),
          ),
        ) ,)

       );
  }
}

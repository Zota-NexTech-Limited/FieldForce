import 'package:fieldforce/bloc/edit_lead_bloc/edit_lead_bloc.dart';
import 'package:fieldforce/bloc/get_address-by_pincode/get_address_by_pin_code_bloc.dart';
import 'package:fieldforce/bloc/get_lead_by_id_bloc/get_lead_by_id_bloc.dart';
import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/edit_button.dart';
import 'package:fieldforce/components/button_component/normal_button.dart';
import 'package:fieldforce/components/button_component/normal_button_with_icon.dart';
import 'package:fieldforce/components/dropdown_component/not_editable_dropdown.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/state_management_components/error_screen.dart';
import 'package:fieldforce/components/state_management_components/loading_screen.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/contact_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CustomerInformationScreen extends StatefulWidget {
  final String id;
  const CustomerInformationScreen({super.key,required this.id});
  @override
  State<CustomerInformationScreen> createState() => _CustomerInformationScreenState();
}
class _CustomerInformationScreenState extends State<CustomerInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController=TextEditingController();
  TextEditingController contactNameController=TextEditingController();
  TextEditingController contactTitleController=TextEditingController();
  TextEditingController companyNameController=TextEditingController();
  TextEditingController companySizeController=TextEditingController();
  TextEditingController industryController=TextEditingController();
  String? selectedCustomerSource;
  List<String> customerSourceList=["LinkedIn","Existing Customer","Referral","Marketing Campaign","Other"];
  bool isCustomerSourceDropdownEmpty=false;



  ///************************* view screen or edit screen or add lead screen condition variables//////////////////
  bool isView=false;
  bool isEdit=false;
  bool readOnly=false;
  bool isLoading=false;
  bool isError=false;
  late GetLeadByIdBloc getLeadByIdBloc;
  late EditLeadBloc editLeadBloc;
  NewLeadModel leadDetails=NewLeadModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLeadByIdBloc=BlocProvider.of<GetLeadByIdBloc>(context);
    editLeadBloc=BlocProvider.of<EditLeadBloc>(context);

  }

  updateLeadDetailsModel()
  {
    setState(() {
      leadDetails.leadFullName= fullNameController.text;
      leadDetails.leadContactName= contactNameController.text;
      leadDetails.leadContactTitle= contactTitleController.text;
      leadDetails.leadCompanyName= companyNameController.text;
      leadDetails.leadCompanySize= companySizeController.text;
      leadDetails.leadIndustry= industryController.text;
      leadDetails.leadSource= selectedCustomerSource;


    });
  }

  updateInputFields({required NewLeadModel leadDetails})
  {
    setState(() {
      fullNameController.text=leadDetails.leadFullName.toString();
       contactNameController.text=leadDetails.leadContactName.toString();
      contactTitleController.text=leadDetails.leadContactTitle.toString();
      companyNameController.text=leadDetails.leadCompanyName.toString();
       companySizeController.text=leadDetails.leadCompanySize.toString();
       industryController.text=leadDetails.leadIndustry.toString();
       selectedCustomerSource=leadDetails.leadSource!.isEmpty?null:leadDetails.leadSource.toString();
       print("selected value is--------------------${leadDetails.leadSource}");
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:MultiBlocListener(listeners: [
          BlocListener<GetLeadByIdBloc,GetLeadByIdState>(listener: (context, state) {
            if(state is GetLeadByIdLoadingState){
              setState(() {
                isLoading=true;
                isError=false;
              });
            }
            else if(state is GetLeadByIdSuccessState)
            {
              setState(() {
                leadDetails=state.leadDetails;
                isView=true;
                readOnly=true;
                isLoading=false;
                isError=false;
                updateInputFields(leadDetails: state.leadDetails);
              });
            }
            else if (state is GetLeadByIdFailedState)
            {
              setState(() {
                isLoading=false;
                isError=false;
              });
            }
          },),
          BlocListener<EditLeadBloc,EditLeadState>(listener: (context, state) {
            if(state is EditLeadLoadingState){

            }
            else if(state is EditLeadSuccessState)
            {
              setState(() {
                isView=true;
                readOnly=true;
                isEdit=false;
                // updateInputFields(opportunityDetails: state.opportunityDetails);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              });
            }
            else if (state is EditLeadFailedState)
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },)

        ], child:  isLoading==true?LoadingScreen():isError==true?ErrorScreen(onPressed: (){
          getLeadByIdBloc.add(TriggerGetLeadByIdEvent(id: widget.id));
        }): Form(
          key: _formKey,
          child: Scaffold(
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
                        readOnly: readOnly
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
                        readOnly: readOnly
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
                        readOnly: readOnly
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
                        readOnly: readOnly
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
                        readOnly: readOnly
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
                        readOnly: readOnly
                    ),
                    const InputFieldTitleText(text: "Customer Source *"),
                    if(readOnly==true)...[
                      NotEditableDropdownComponent(text: selectedCustomerSource==null?"--":selectedCustomerSource!)
                    ]else...[
                      SingleItemSelectDropdown(selectedValue: selectedCustomerSource, list: customerSourceList, onChanged: (value){
                        setState(() {
                          selectedCustomerSource=value;
                          isCustomerSourceDropdownEmpty=false;
                        });
                      },
                          isError: isCustomerSourceDropdownEmpty,
                          hint: "Select how the customer was acquired"),
                    ],

                    SizedBox(height: SizeConfig.blockHeight*3,),
                    if(isView==false)...[
                      NormalButtonWithIcon(title: "Next Step", onTap: (){
                        setState(() {
                          if(selectedCustomerSource==null||selectedCustomerSource!.isEmpty)
                          {
                            isCustomerSourceDropdownEmpty=true;
                          }
                        });
                        if(_formKey.currentState!.validate())
                        {
                          setState(() {
                            if(selectedCustomerSource==null||selectedCustomerSource!.isEmpty)
                            {
                              isCustomerSourceDropdownEmpty=true;
                            }else{
                             updateLeadDetailsModel();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  MultiBlocProvider(providers: [
                                    BlocProvider(create: (context)=>GetAddressByPinCodeBloc(),),
                                    BlocProvider(create: (context)=>EditLeadBloc(),),
                                  ], child:ContactDetailsScreen(leadDetails:leadDetails,) ,)
                                  ));

                            }




                          });
                        }


                      }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)
                    ]
                    else...[
                      if(isEdit==false)...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EditButtonComponent(onTap: (){
                              setState(() {
                                isEdit=true;
                                readOnly=false;
                              });
                            },),
                            NormalButtonWithIcon(title: "Next Step", onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                                BlocProvider(create: (context)=>GetAddressByPinCodeBloc(),),
                                BlocProvider(create: (context)=>EditLeadBloc(),),
                              ],child:ContactDetailsScreen(leadDetails:leadDetails,) )

                                  ));
                            }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.7)
                          ],
                        )
                      ]else...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NormalButton(title: "Cancel", onTap: (){
                              setState(() {
                                isEdit=false;
                                readOnly=true;
                                updateInputFields(leadDetails:leadDetails);
                              });
                            }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.4),
                            NormalButton(title: "Update", onTap: (){
                              setState(() {
                                if(selectedCustomerSource==null||selectedCustomerSource!.isEmpty)
                                {
                                  isCustomerSourceDropdownEmpty=true;
                                }
                              });
                              if(_formKey.currentState!.validate())
                              {
                                setState(() {
                                  if(selectedCustomerSource==null||selectedCustomerSource!.isEmpty)
                                  {
                                    isCustomerSourceDropdownEmpty=true;
                                  }else{
                                    updateLeadDetailsModel();
                                    editLeadBloc.add(TriggerEditLeadEvent(leadDetails: leadDetails));
                                  }

                                });
                              }

                            }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.4)
                          ],
                        )
                      ]
                    ]
                    ],
                ),
              ),
            ),
          ),
        ))


    );
  }
}

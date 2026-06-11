import 'package:fieldsales/bloc/add_opportunity_bloc/add_opportunity_bloc.dart';
import 'package:fieldsales/bloc/edit_opportunity_bloc/edit_opportunity_bloc.dart';
import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/edit_button.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/button_component/normal_button_with_icon.dart';
import 'package:fieldsales/components/dropdown_component/not_editable_dropdown.dart';
import 'package:fieldsales/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldsales/components/text_component/input_field_title_text.dart';
import 'package:fieldsales/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/crm_models/opportinuty_model.dart';
import 'package:fieldsales/ui/crm/opportunity_screens/add_new_opportunity_screens/opportunity_source_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class OpportunityContactInformationScreen extends StatefulWidget {
  final OpportunityDetailsModel opportunityDetails;
  final VoidCallback pageRefreshFunction;
  const OpportunityContactInformationScreen({super.key,required this.opportunityDetails,required this.pageRefreshFunction});

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

  ///************************* view screen or edit screen or add opportunity screen condition variables//////////////////
  bool isView=false;
  bool isEdit=false;
  bool readOnly=false;
  late EditOpportunityBloc editOpportunityBloc;
  late OpportunityDetailsModel opportunityDetails;
  updateOpportunityDetailsModel()
  {
    setState(() {
      opportunityDetails.opportunityContactName=contactNameController.text;
      opportunityDetails.opportunityEmail=emailAddressController.text;
      opportunityDetails.opportunityNumber=phoneNumberController.text;
      opportunityDetails.opportunityCompanyName=companyNameController.text;
      opportunityDetails.opportunityIndustry=selectedIndustry;
    });
  }

  updateInputFields({required OpportunityDetailsModel opportunityDetails})
  {
    setState(() {
      contactNameController.text=opportunityDetails.opportunityContactName.toString();
      emailAddressController.text=opportunityDetails.opportunityEmail.toString();
      phoneNumberController.text=opportunityDetails.opportunityNumber.toString();
      companyNameController.text=opportunityDetails.opportunityCompanyName.toString();
      selectedIndustry=opportunityDetails.opportunityIndustry;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opportunityDetails=widget.opportunityDetails;
    editOpportunityBloc=BlocProvider.of<EditOpportunityBloc>(context);
    setState(() {
      if(widget.opportunityDetails.opportunityId!=null&&widget.opportunityDetails.opportunityId!.isNotEmpty)
        {
          isView=true;
          readOnly=true;
          updateInputFields(opportunityDetails: widget.opportunityDetails);
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  BlocListener<EditOpportunityBloc,EditOpportunityState>(listener: (context, state) {
        if(state is EditOpportunityLoadingState){

        }
        else if(state is EditOpportunitySuccessState)
        {
          setState(() {
            isView=true;
            readOnly=true;
            isEdit=false;
           // updateInputFields(opportunityDetails: state.opportunityDetails);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          });
        }
        else if (state is EditOpportunityFailedState)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },child:
      Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: COLORS.scaffoldBg,
          appBar: appBarComponent(title: "Contact Information", context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.blockHeight*2),
                _sectionHeader(),
                SizedBox(height: SizeConfig.blockHeight*2),
                _formCard([
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
                    readOnly: readOnly
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
                    readOnly: readOnly
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
                    readOnly: readOnly
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
                    readOnly: readOnly
                ),
                const InputFieldTitleText(text: "Industry"),
                if(readOnly==true)...[
                  NotEditableDropdownComponent(text: selectedIndustry.toString())
                ]else...[
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
                ],
                ]),
                SizedBox(height: SizeConfig.blockHeight*3),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: SizeConfig.blockHeight*10,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4, vertical: SizeConfig.blockHeight*1.2),
            decoration: BoxDecoration(
              color: COLORS.surface,
              border: Border(top: BorderSide(color: COLORS.divider, width: 1)),
              boxShadow: [
                BoxShadow(
                  color: COLORS.shadow,
                  blurRadius: 16,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: Column(
              children: [
                if(isView==false)...[
                  NormalButtonWithIcon(title: "Next Step", onTap: (){
                    if(_formKey.currentState!.validate())
                    {
                      updateOpportunityDetailsModel();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                        BlocProvider(create: (context)=>AddOpportunityBloc(),),
                        BlocProvider(create: (context)=>EditOpportunityBloc(),),
                      ],child: OpportunitySourceInformationScreen(opportunityDetails: opportunityDetails,pageRefreshFunction: widget.pageRefreshFunction,),)
                      ));

                    }

                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth),
                ]else...[
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
                            BlocProvider(create: (context)=>AddOpportunityBloc(),),
                            BlocProvider(create: (context)=>EditOpportunityBloc(),),
                          ],child: OpportunitySourceInformationScreen(opportunityDetails: opportunityDetails,pageRefreshFunction: widget.pageRefreshFunction,),)
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
                            updateInputFields(opportunityDetails:opportunityDetails);
                          });
                        }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.4),
                        NormalButton(title: "Update", onTap: (){
                          setState(() {
                            updateOpportunityDetailsModel();
                            editOpportunityBloc.add(TriggerEditOpportunityEvent(opportunityDetails: opportunityDetails));

                          });
                        }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth*0.4)
                      ],
                    )
                  ]
                ],
              ],
            ),
          ),
        ),
      ),
      )


    );
  }

  Widget _sectionHeader() {
    return Row(
      children: [
        Container(
          height: SizeConfig.blockHeight*5.5,
          width: SizeConfig.blockHeight*5.5,
          decoration: BoxDecoration(
            color: COLORS.primarySoft,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            Icons.contact_phone_outlined,
            color: COLORS.primaryColor,
            size: SizeConfig.blockHeight*3,
          ),
        ),
        SizedBox(width: SizeConfig.blockWidth*3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Contact Information",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.blockHeight*2.3,
                  color: COLORS.textPrimary,
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight*0.4),
              Text(
                "Tell us who to reach and how",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.blockHeight*1.6,
                  color: COLORS.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _formCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth*4,
        vertical: SizeConfig.blockHeight*1,
      ),
      decoration: BoxDecoration(
        color: COLORS.surface,
        borderRadius: BorderRadius.circular(18),
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
        children: [
          ...children,
          SizedBox(height: SizeConfig.blockHeight*2),
        ],
      ),
    );
  }
}

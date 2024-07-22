import 'package:fieldforce/bloc/new_lead_bloc/new_lead_bloc.dart';
import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button_with_icon.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class InquiryDetailsScreen extends StatefulWidget {
  final NewLeadModel leadDetails;
  const InquiryDetailsScreen({super.key,required this.leadDetails});

  @override
  State<InquiryDetailsScreen> createState() => _InquiryDetailsScreenState();
}

class _InquiryDetailsScreenState extends State<InquiryDetailsScreen> {
  TextEditingController inquiryDescriptionController=TextEditingController();
  TextEditingController keywordsController=TextEditingController();
  TextEditingController customerRequirementsController=TextEditingController();
  TextEditingController competitorInformationController=TextEditingController();
  TextEditingController nextStepsController=TextEditingController();
  TextEditingController notesController=TextEditingController();

  String? selectedInquiryMedium;
  List<String> inquiryMediumList=[];

  String? selectedInquirySource;
  List<String> inquirySourceList=[];
  late NewLeadBloc newLeadBloc;
  late NewLeadModel leadDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leadDetails=widget.leadDetails;
    newLeadBloc=BlocProvider.of<NewLeadBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:BlocListener<NewLeadBloc,NewLeadState>(
            listener: (context, state) {
              if(state is NewLeadLoadingState)
                {

                }else if(state is NewLeadSuccessState)
                  {
                    setState(() {
                      final snackBar = SnackBar(content: Text(state.message));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  }else if(state is NewLeadFailedState)
                    {
                      final snackBar = SnackBar(content: Text(state.message));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
              setState(() {

              });
            },child:  Scaffold(
          backgroundColor: COLORS.white,
          appBar: appBarComponent(title: "Inquiry Details",context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InputFieldTitleText(text: "Inquiry Medium *"),
                  SingleItemSelectDropdown(selectedValue: selectedInquiryMedium, list: inquiryMediumList, onChanged: (value){
                    setState(() {
                      selectedInquiryMedium=value;
                    });
                  }, hint: "Channel inquiry came in"),

                  const InputFieldTitleText(text: "Inquiry Source *"),
                  SingleItemSelectDropdown(selectedValue: selectedInquirySource, list: inquirySourceList, onChanged: (value){
                    setState(() {
                      selectedInquiryMedium=value;
                    });
                  }, hint: "How the inquiry came in"),

                  const InputFieldTitleText(text: "Inquiry Description"),
                  MultiLineTextFormField(onChanged: (value){}, controller: inquiryDescriptionController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: false, labelText: "Detailed description of the customer's needs or questions."),

                  const InputFieldTitleText(text: "Keywords "),
                  MultiLineTextFormField(onChanged: (value){}, controller: keywordsController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: false, labelText: "Relevant keywords or search terms used by the customer"),

                  const InputFieldTitleText(text: "Customer Requirements "),
                  MultiLineTextFormField(onChanged: (value){}, controller: customerRequirementsController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: false, labelText: "Specific requirements or preferences expressed by the customer"),

                  const InputFieldTitleText(text: "Competitor Information  "),
                  MultiLineTextFormField(onChanged: (value){}, controller: competitorInformationController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: false, labelText: "Information about competitors mentioned by the customer"),

                  const InputFieldTitleText(text: "Next Steps "),
                  MultiLineTextFormField(onChanged: (value){}, controller: nextStepsController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: false, labelText: "Specific requirements or preferences expressed by the customer"),

                  const InputFieldTitleText(text: "Notes "),
                  MultiLineTextFormField(onChanged: (value){}, controller: notesController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: false, labelText: "Additional comments or observations"),






                  SizedBox(height: SizeConfig.blockHeight*3,),
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    height:SizeConfig.blockHeight*7,
                    child:  ElevatedButton(
                      child: NormalText(fontWeight: FontWeight.w500, color: COLORS.white, fontSize:2.3, text: "Submit") ,
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(COLORS.green),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3))))
                      ),
                      onPressed: (){
                        setState(() {
                          leadDetails=NewLeadModel(
                              leadInquiryMedium: selectedInquiryMedium,
                              leadInquirySource: selectedInquirySource,
                              leadDescription: inquiryDescriptionController.text,
                              leadKeywords: keywordsController.text,
                              leadRequirements:customerRequirementsController.text,
                              leadCompInformation: competitorInformationController.text,
                              leadNextSteps: nextStepsController.text,
                              leadNotes: notesController.text
                          );

                          newLeadBloc.add(PostNewLeadEvent(leadDetails: leadDetails));
                        });
                      },
                    ),
                  )

                ],
              ),
            ),
          ),
        ),)

       );
  }
}

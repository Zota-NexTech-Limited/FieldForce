import 'package:fieldforce/bloc/new_lead_bloc/new_lead_bloc.dart';
import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button_with_icon.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:fieldforce/ui/crm/lead_screens/add_lead_details_screen/inquiry_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProductOrServiceDetailsScreen extends StatefulWidget {
  final NewLeadModel leadDetails;
  const ProductOrServiceDetailsScreen({super.key,required this.leadDetails});

  @override
  State<ProductOrServiceDetailsScreen> createState() => _ProductOrServiceDetailsScreenState();
}

class _ProductOrServiceDetailsScreenState extends State<ProductOrServiceDetailsScreen> {
  TextEditingController additionalDetailsController=TextEditingController();
  TextEditingController quantityController=TextEditingController();
  TextEditingController budgetController=TextEditingController();

  String? selectedProduct;
  List<String> productList=[];
  late NewLeadModel leadDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leadDetails=widget.leadDetails;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: COLORS.white,
          appBar: appBarComponent(title: "Product/Service Details",context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InputFieldTitleText(text: "Product / Service Interested *"),
                  SingleItemSelectDropdown(selectedValue: selectedProduct, list: productList, onChanged: (value){
                    setState(() {
                      selectedProduct=value;
                    });
                  }, hint: "Product / Service customer interested in"),

                  const InputFieldTitleText(text: "Additional details "),
                  MultiLineTextFormField(onChanged: (value){}, controller: additionalDetailsController, inputType: TextInputType.text, validator: (value){
                    return null;
                  }, isReadOnly: false, labelText: "Additional details about the product or service"),

                  const InputFieldTitleText(text: "Quantity "),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: quantityController,
                      hintText: "Desired quantity of the product (if applicable)",
                      inputType: TextInputType.phone,
                      validator: (value){
                        return null;
                      },
                      readOnly: false
                  ),

                  const InputFieldTitleText(text: "Budget"),
                  NormalTextFormField(
                      onChanged: (value){},
                      controller: budgetController,
                      hintText: "Customer's estimated budget (if applicable)",
                      inputType: TextInputType.phone,
                      validator: (value){
                        return null;
                      },
                      readOnly: false
                  ),




                   SizedBox(height: SizeConfig.blockHeight*3,),
                  NormalButtonWithIcon(title: "Next Step", onTap: (){
                    setState(() {
                      leadDetails.leadProduct= selectedProduct;
                      leadDetails.leadDetails= additionalDetailsController.text;
                      leadDetails.leadQuantity= quantityController.text;
                      leadDetails.leadBudget= budgetController.text;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>NewLeadBloc(),child:InquiryDetailsScreen(leadDetails: leadDetails,) ,) ));
                    });

                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)

                ],
              ),
            ),
          ),
        ));
  }
}

import 'dart:io';

import 'package:fieldsales/bloc/add_expense/add_expense_bloc.dart';
import 'package:fieldsales/bloc/expense_list_bloc/expense_list_bloc.dart';
import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/file_upload_button.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldsales/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldsales/components/text_form_field_component/textformfield_with_suffix_icon.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/reuse_functions/date_picker.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/expense/add_ecpense_model.dart';
import 'package:fieldsales/ui/expense/expence_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  String? selectedProduct;
  String? selectedStationType;

  List<String> productList=[
    "Daily Allowance",
    "Food Expenses",
    "Gift / Courier",
    "HQ",
    "Hotel Stay",
    "Internet Charges",
    "Out Station" ,
    "Travelling by Auto" ,
    "Travelling by Bus" ,
    "Travelling by Cab" ,
    "Travelling by Own Vehicle" ,
    "Travelling by Train" ,

  ];
  List<String> stationTypeList=["HQ","Ex-HQ","Outstation"];


  bool isProductDropdownEmpty=false;


  final _formKey = GlobalKey<FormState>();
  TextEditingController reportingPlaceController=TextEditingController();
  TextEditingController claimPriceController=TextEditingController();
  TextEditingController claimQuantityController=TextEditingController();
  TextEditingController totalController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController billReferenceController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

///file picker variables **************************************
  final _dialogTitleController = TextEditingController();
  final _initialDirectoryController = TextEditingController();
  final _fileExtensionController = TextEditingController();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _lockParentWindow = false;
  bool _userAborted = false;
  bool _multiPick = true;
  FileType _pickingType = FileType.any;

  void _pickFiles() async {
    //_resetState();
    try {
      _directoryPath = null;
      List<PlatformFile>? _pathsSelected;
      _pathsSelected = (await FilePicker.pickFiles(
        compressionQuality: 30,
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        dialogTitle: _dialogTitleController.text,
        initialDirectory: _initialDirectoryController.text,
        lockParentWindow: _lockParentWindow,
      ))
          ?.files;
      if(_paths==null)
      {
        _paths=_pathsSelected;
      }
      else if(_pathsSelected!=null)
      {
        _paths!.addAll(_pathsSelected);
      }

    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }


  late AddExpenseBloc addExpenseBloc;
  @override
  void initState() {
    super.initState();
    _fileExtensionController.addListener(() => _extension = _fileExtensionController.text);
    addExpenseBloc=BlocProvider.of<AddExpenseBloc>(context);
  }


/*  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }*/



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<AddExpenseBloc,AddExpenseState>(
          listener: (context, state) {
          if(state is AddExpenseLoadingState)
            {

            }
          else if(state is AddExpenseSuccessState)
            {
              final snackBar = SnackBar(content: Text(state.message));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>ExpenseListBloc()..add(const FetchExpenseListEvent()),child: const ExpenceScreen(),)));

            }
          else if(state is AddExpenseFailedState)
            {
              final snackBar = SnackBar(content: Text(state.message));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          setState(() {

          });
        },child:  Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: COLORS.scaffoldBg,
            appBar: appBarComponent(title: "Add Expense", context: context),
            body: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,),
              child:SingleChildScrollView(
                physics:const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.blockHeight*2.5,),
                    _sectionHeader(
                      icon: Icons.receipt_long_outlined,
                      title: "Expense Details",
                      subtitle: "Tell us about this expense",
                    ),
                    SizedBox(height: SizeConfig.blockHeight*1.5,),
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label("Product *"),
                          SizedBox(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.blockHeight*6,

                            child: SingleItemSelectDropdown(isError: isProductDropdownEmpty,selectedValue: selectedProduct, list: productList, onChanged: (value){
                              setState(() {
                                selectedProduct=value;
                                isProductDropdownEmpty=false;
                              });
                            }, hint: "Product"),
                          ),
                          _label("Station Type *"),
                          SizedBox(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.blockHeight*6,

                            child: SingleItemSelectDropdown(selectedValue: selectedStationType, list: stationTypeList,isError: false, onChanged: (value){
                              setState(() {
                                selectedStationType=value;
                              });
                            }, hint: "Station Type"),
                          ),
                          _label("Reporting Place *"),
                          NormalTextFormField(
                              onChanged: (value){},
                              controller: reportingPlaceController,
                              hintText: "Reporting Place",
                              inputType: TextInputType.text,
                              validator: (value){
                                if(value==null||value.isEmpty)
                                {
                                  return "Reporting Place is Empty";
                                }
                                return null;
                              },
                              readOnly: false
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight*2.5,),
                    _sectionHeader(
                      icon: Icons.payments_outlined,
                      title: "Claim & Amount",
                      subtitle: "Pricing and quantity for this claim",
                    ),
                    SizedBox(height: SizeConfig.blockHeight*1.5,),
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label("Claim Price *"),
                                    NormalTextFormField(
                                        onChanged: (value){},
                                        controller: claimPriceController,
                                        hintText: "Claim Price",
                                        inputType: TextInputType.number,
                                        validator: (value){
                                          RegExp regex = RegExp(r'^[-+]?\d*\.?\d+$');
                                          if (!regex.hasMatch(value!)) {
                                            return 'Invalid Claim Price';
                                          }
                                        },
                                        readOnly: false
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: SizeConfig.blockWidth*4,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label("Claim Quantity *"),
                                    NormalTextFormField(
                                        onChanged: (value){},
                                        controller: claimQuantityController,
                                        hintText: "Claim Quantity",
                                        inputType: TextInputType.number,
                                        validator: (value){
                                            RegExp regex = RegExp(r"^[0-9]+$");
                                            if (!regex.hasMatch(value!)) {
                                              return 'Numbers are allowed';
                                          }
                                        },
                                        readOnly: false
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label("Total"),
                                    NormalTextFormField(
                                        onChanged: (value){},
                                        controller: totalController,
                                        hintText: "Total",
                                        inputType: TextInputType.text,
                                        validator: (value){
                                          if(value==null||value.isEmpty)
                                          {
                                            return null;
                                          }
                                          else{
                                            RegExp regex = RegExp(r'^[-+]?\d*\.?\d+$');
                                            if (!regex.hasMatch(value)) {
                                              return 'Numbers are allowed';
                                            }
                                          }
                                        },
                                        readOnly: false
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: SizeConfig.blockWidth*4,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label("Date"),
                                    SizedBox(
                                      height: SizeConfig.blockHeight*6,
                                      child:TextFormFieldWithSuffixIcon(
                                          onChanged:  (value){},
                                          controller: dateController,
                                          hintText: "Date",
                                          readOnly: true,
                                          inputType: TextInputType.text,
                                          validator: (value){
                                            return null;
                                          },
                                          onTap: (){
                                            setState(() {
                                              showSingleDatePickerHelper(context: context,controller: dateController);
                                            });


                                          },
                                          suffixIcon: "assets/image/svg_icons/calendar.svg"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight*2.5,),
                    _sectionHeader(
                      icon: Icons.description_outlined,
                      title: "Reference & Notes",
                      subtitle: "Bill reference and a short description",
                    ),
                    SizedBox(height: SizeConfig.blockHeight*1.5,),
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label("Bill Reference *"),
                          NormalTextFormField(
                              onChanged: (value){},
                              controller: billReferenceController,
                              hintText: "Bill Reference",
                              inputType: TextInputType.text,
                              validator: (value){
                                if(value==null||value.isEmpty)
                                {
                                  return "Bill Reference is Empty";
                                }
                                return null;
                              },
                              readOnly: false
                          ),
                          _label("Description *"),
                          MultiLineTextFormField(
                              onChanged: (value){},
                              controller: descriptionController,
                              inputType: TextInputType.text,
                              validator:  (value){
                                if(value==null||value.isEmpty)
                                {
                                  return "Description is Empty";
                                }
                                return null;
                              },
                              isReadOnly: false,
                              labelText: "Description"),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight*2.5,),
                    _sectionHeader(
                      icon: Icons.attach_file_outlined,
                      title: "Attachments",
                      subtitle: "Upload supporting documents",
                    ),
                    SizedBox(height: SizeConfig.blockHeight*1.5,),
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label("Attach Document *"),
                          FileUploadButton(onTap:(){
                            _pickFiles();
                          } ,actionText: "Upload",leadingText: "Upload Documents",),
                          if(_paths!=null)...[
                            SizedBox(height: SizeConfig.blockHeight*2,),
                            GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: SizeConfig.blockWidth*0,
                                  mainAxisSpacing: SizeConfig.blockHeight*2

                              ),
                              shrinkWrap: true,
                              physics:const NeverScrollableScrollPhysics(),
                              itemCount: _paths!.length,
                              itemBuilder:(context, index) {
                                final path = kIsWeb
                                    ? null
                                    : _paths!
                                    .map((e) => e.path)
                                    .toList()[index]
                                    .toString();
                                return Stack(
                                  children: [
                                    _paths![index].name.contains(".jpg")?Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(

                                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)),
                                          border: Border.all(color: COLORS.cardBorder)
                                      ),
                                      height: SizeConfig.blockHeight*10,
                                      width: SizeConfig.blockWidth*20,
                                      child: Image.file(File(path!),fit: BoxFit.fill,),
                                    ):Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          color: COLORS.primarySoft,
                                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)),
                                          border: Border.all(color: COLORS.cardBorder)
                                      ),
                                      height: SizeConfig.blockHeight*10,
                                      width: SizeConfig.blockWidth*20,
                                      child: Center(
                                        child: Icon(Icons.file_present_sharp,color: COLORS.primaryColor,),
                                      ),
                                    ),
                                    Positioned(
                                        top: SizeConfig.blockHeight*0.5,
                                        right: SizeConfig.blockWidth*5 ,
                                        child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                _paths!.removeAt(index);
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(SizeConfig.blockWidth*1),
                                              decoration: BoxDecoration(
                                                color: COLORS.dangerSoft,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(CupertinoIcons.delete,color: COLORS.danger,size: SizeConfig.blockHeight*2.4,),
                                            )))
                                  ],
                                );
                              },)
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight*3,),


                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.fromLTRB(
                SizeConfig.blockWidth*4,
                SizeConfig.blockHeight*1.5,
                SizeConfig.blockWidth*4,
                SizeConfig.blockHeight*2,
              ),
              decoration: BoxDecoration(
                color: COLORS.white,
                border: Border(top: BorderSide(color: COLORS.divider)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NormalButton(title: "ADD", onTap: (){
                    if(selectedProduct==null||selectedProduct!.isEmpty)
                    {
                      setState(() {
                        isProductDropdownEmpty=true;
                      });
                    }
                    if(_formKey.currentState!.validate())
                    {
                      if(isProductDropdownEmpty==false)
                      {
                        setState(() {
                          late AddExpenseModel expenseDetails;
                          expenseDetails=AddExpenseModel(
                              expenseProduct:selectedProduct,
                              expenseStationType: selectedStationType,
                              expenseReportingPlace: reportingPlaceController.text,
                              expenseClaimPrice: claimPriceController.text,
                              expenseClaimQuantity: claimQuantityController.text,
                              expenseTotalPrice: totalController.text,
                              expenseDate: dateController.text.isEmpty?null:dateController.text,
                              expenseBillReference: billReferenceController.text,
                              expenseDescription: descriptionController.text,
                              expenseAttachDocuments: []
                          );
                          addExpenseBloc.add(TriggerAddExpenseEvent(expenseDetails: expenseDetails));
                        });
                      }
                    }

                  }, height: SizeConfig.blockHeight*7, width: SizeConfig.screenWidth)

                  ],
                ),
              ),
            ),
          ),
        ),)


    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth*4,
        vertical: SizeConfig.blockHeight*1,
      ),
      decoration: BoxDecoration(
        color: COLORS.white,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth*4.5),
        border: Border.all(color: COLORS.cardBorder),
        boxShadow: [
          BoxShadow(
            color: COLORS.shadow,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _sectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: SizeConfig.blockHeight*5.5,
          width: SizeConfig.blockHeight*5.5,
          decoration: BoxDecoration(
            color: COLORS.primarySoft,
            borderRadius: BorderRadius.circular(SizeConfig.blockWidth*3),
          ),
          child: Icon(icon, color: COLORS.primaryColor, size: SizeConfig.blockHeight*3),
        ),
        SizedBox(width: SizeConfig.blockWidth*3,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize: 2.3, text: title),
              SizedBox(height: SizeConfig.blockHeight*0.3,),
              NormalText(fontWeight: FontWeight.w500, color: COLORS.textTertiary, fontSize: 1.8, text: subtitle),
            ],
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockHeight*2,
        bottom: SizeConfig.blockHeight*1,
      ),
      child: NormalText(
        fontWeight: FontWeight.w600,
        color: COLORS.textSecondary,
        fontSize: 2.0,
        text: text,
      ),
    );
  }
}

import 'dart:io';

import 'package:fieldforce/bloc/add_expense/add_expense_bloc.dart';
import 'package:fieldforce/bloc/expense_list_bloc/expense_list_bloc.dart';
import 'package:fieldforce/components/app_bar_component/app_bar_component.dart';
import 'package:fieldforce/components/button_component/normal_button.dart';
import 'package:fieldforce/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldforce/components/text_component/input_field_title_text.dart';
import 'package:fieldforce/components/text_component/normal_text.dart';
import 'package:fieldforce/components/text_form_field_component/multy_line_text_form_field.dart';
import 'package:fieldforce/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldforce/components/text_form_field_component/textformfield_with_suffix_icon.dart';
import 'package:fieldforce/helper/colors.dart';
import 'package:fieldforce/helper/reuse_functions/date_picker.dart';
import 'package:fieldforce/helper/size_config.dart';
import 'package:fieldforce/models/expense/add_ecpense_model.dart';
import 'package:fieldforce/ui/expense/expence_screen.dart';
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
    "Healthcare Services",
    "Education & Training",
    "Travel & Hospitality",
    "Automotive Parts Replacement",
    "Hardware",
    "Software",
    "Consumer Electronics" ];
  List<String> stationTypeList=["example1"];


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
      _pathsSelected = (await FilePicker.platform.pickFiles(
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
            backgroundColor: COLORS.white,
            appBar: appBarComponent(title: "Add Expense", context: context),
            body: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,),
              child:SingleChildScrollView(
                physics:const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const  InputFieldTitleText(text: "Product *"),
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
                    const InputFieldTitleText(text: "Station Type *"),
                    SizedBox(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.blockHeight*6,

                      child: SingleItemSelectDropdown(selectedValue: selectedStationType, list: stationTypeList,isError: false, onChanged: (value){
                        setState(() {
                          selectedStationType=value;
                        });
                      }, hint: "Station Type"),
                    ),
                    const InputFieldTitleText(text: "Reporting Place *"),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const  InputFieldTitleText(text: "Claim Price *"),
                            SizedBox(
                                width: SizeConfig.blockWidth*45,
                                child:NormalTextFormField(
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
                                )
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const InputFieldTitleText(text: "Claim Quantity *"),
                            SizedBox(
                              width: SizeConfig.blockWidth*45,


                              child:NormalTextFormField(
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
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const  InputFieldTitleText(text: "Total"),
                            SizedBox(
                                width: SizeConfig.blockWidth*45,
                                child:NormalTextFormField(
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
                                )
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const InputFieldTitleText(text: "Date"),
                            SizedBox(
                              width: SizeConfig.blockWidth*45,
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
                      ],
                    ),
                    const InputFieldTitleText(text: "Bill Reference *"),
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
                    const InputFieldTitleText(text: "Description *"),
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
                    SizedBox(height: SizeConfig.blockHeight*2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const NormalText(fontWeight: FontWeight.w500, color: COLORS.blue, fontSize: 3, text: "Attach Document *"),
                        IconButton(onPressed: (){
                          _pickFiles();
                        }, icon: Icon(Icons.add_box,size: SizeConfig.blockHeight*5,color: COLORS.blue,))
                      ],
                    ),
                    if(_paths!=null)...[
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

                                    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
                                    border: Border.all(color: COLORS.blue)
                                ),
                                height: SizeConfig.blockHeight*10,
                                width: SizeConfig.blockWidth*20,
                                child: Image.file(File(path!),fit: BoxFit.fill,),
                              ):Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2)),
                                    border: Border.all(color: COLORS.blue)
                                ),
                                height: SizeConfig.blockHeight*10,
                                width: SizeConfig.blockWidth*20,
                                child:const Center(
                                  child: Icon(Icons.file_present_sharp,color: COLORS.blue,),
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
                                      child: Icon(CupertinoIcons.delete,color: COLORS.red,size: SizeConfig.blockHeight*3,)))
                            ],
                          );
                        },)
                    ],
                    SizedBox(height: SizeConfig.blockHeight*2,),
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
}

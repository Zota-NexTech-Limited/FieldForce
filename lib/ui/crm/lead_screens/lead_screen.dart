import 'dart:ui';

import 'package:fieldsales/bloc/edit_lead_bloc/edit_lead_bloc.dart';
import 'package:fieldsales/bloc/get_lead_by_id_bloc/get_lead_by_id_bloc.dart';
import 'package:fieldsales/bloc/lead_list_bloc/lead_list_bloc.dart';
import 'package:fieldsales/components/button_component/add_new_button.dart';
import 'package:fieldsales/components/button_component/circular_button.dart';
import 'package:fieldsales/components/state_management_components/empty_screen_component.dart';
import 'package:fieldsales/components/state_management_components/error_screen.dart';
import 'package:fieldsales/components/state_management_components/loading_screen.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/filter_field.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/date_converter.dart';
import 'package:fieldsales/helper/reuse_functions/date_picker.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/crm_models/new_lead_model.dart';
import 'package:fieldsales/ui/crm/lead_screens/add_lead_details_screen/add_lead_details_screen.dart';
import 'package:fieldsales/ui/crm/lead_screens/add_lead_details_screen/add_lead_screen.dart';
import 'package:fieldsales/ui/crm/lead_screens/add_lead_details_screen/customer_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  TextEditingController filterController=TextEditingController();
  List<NewLeadModel>leadList=[];
  late LeadListBloc leadListBloc;
  String fromDate="";
  String toDate="";
  ScrollController scrollController=ScrollController();
  double lastOffset = 0.0;
  bool  showNewLeadButton=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leadListBloc=BlocProvider.of<LeadListBloc>(context);
  }
  void _refreshPage() {
    setState(() {
      leadListBloc.add(FetchLeadListEvent(fromDate: "", toDate: "", search: "") );
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:BlocBuilder<LeadListBloc,LeadListState>(
          builder: (context, state) {
             if(state is LeadListLoadingState)
               {
                 return const LoadingScreen();
               }else if (state is LeadListSuccessState)
                 {
                   leadList=state.leadList;
                   return Scaffold(
                     backgroundColor: COLORS.skyBlue,
                     body: Stack(
                       children: [
                         Container(
                           margin: EdgeInsets.only(top: SizeConfig.blockHeight*12,left: SizeConfig.blockWidth*2,right:SizeConfig.blockWidth*2 ),
                           width: SizeConfig.screenWidth,
                           height: SizeConfig.screenHeight,
                           child: RefreshIndicator(
                             color: COLORS.blue,
                             onRefresh: (){
                               return Future.delayed(
                                   const Duration(milliseconds: 200),
                                       (){

                                     _refreshPage();
                                     setState(() {
                                       fromDate="";
                                       toDate="";
                                       filterController.clear();
                                     });

                                   }
                               );
                             },
                             child:leadList.isNotEmpty?ListView.builder(
                               itemCount: leadList.length,
                               shrinkWrap: true,
                               controller: scrollController..addListener(() {

                                 double currentOffset=scrollController.offset;
                                 if (currentOffset > lastOffset)
                                 {
                                   print("scroll down***************************");
                                   setState(() {
                                     showNewLeadButton=false;
                                   });
                                 }else{
                                   print("scroll top***************************");
                                   setState(() {
                                     showNewLeadButton=true;
                                   });
                                 }

                               }),
                               physics: BouncingScrollPhysics(),
                               itemBuilder: (context, index) {
                                 return Dismissible(
                                     key:Key(index.toString()),
                                     background: Container(
                                         margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*1.5,),
                                         decoration: BoxDecoration(
                                             color:COLORS.orange,
                                             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(SizeConfig.blockWidth*2),topLeft:  Radius.circular(SizeConfig.blockWidth*2))
                                         ),
                                         // padding: EdgeInsets.only(left: SizeConfig.blockWidth*10),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Container(
                                                   width: SizeConfig.blockWidth*40,
                                                   //color: COLORS.orange,
                                                   child: SizedBox(
                                                       height: SizeConfig.blockHeight*3,
                                                       width: SizeConfig.blockWidth*10,
                                                       child: SvgImageHelper(image: "assets/image/svg_icons/note_icon.svg")),
                                                 ),
                                                 NormalText(fontWeight: FontWeight.w600, color: COLORS.white, fontSize: 2, text: "Note")
                                               ],
                                             ),
                                           ],
                                         )),
                                     secondaryBackground: Container(
                                         margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*1.5,),
                                         decoration: BoxDecoration(
                                             color:COLORS.green,
                                             borderRadius: BorderRadius.only(bottomRight: Radius.circular(SizeConfig.blockWidth*2),topRight:  Radius.circular(SizeConfig.blockWidth*2))
                                         ),
                                         // padding: EdgeInsets.only(left: SizeConfig.blockWidth*10),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.end,
                                           children: [
                                             Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Container(
                                                   width: SizeConfig.blockWidth*40,
                                                   //color: COLORS.orange,
                                                   child: SizedBox(
                                                       height: SizeConfig.blockHeight*3,
                                                       width: SizeConfig.blockWidth*10,
                                                       child: SvgImageHelper(image: "assets/image/svg_icons/call_icon.svg")),
                                                 ),
                                                 NormalText(fontWeight: FontWeight.w600, color: COLORS.white, fontSize: 2, text: "Call")
                                               ],
                                             ),
                                           ],
                                         )), // Background for left swipe
                                     confirmDismiss: (direction) async {
                                       // Optionally confirm action here
                                       return false; // Return true to dismiss
                                     },
                                     onDismissed: (direction) {
                                       if (direction == DismissDirection.endToStart) {
                                         // Call function for left swipe

                                       } else {
                                         // Call function for right swipe

                                       }
                                     },
                                     child:leadCard(name: "${leadList[index].leadFullName}", enquiry: "${leadList[index].leadInquiryMedium}", date: "15 jul 2024", contactName: " ${leadList[index].leadContactName}", status: "new", menuTap: (){}, cardTap: (){
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                                         BlocProvider(create: (context)=>GetLeadByIdBloc()..add(TriggerGetLeadByIdEvent(id: leadList[index].leadId!))),
                                         BlocProvider(create: (context)=>EditLeadBloc()),
                                       ], child: CustomerInformationScreen(id:leadList[index].leadId!,))));
                                     })

                                 );
                               },):ListView(
                               physics:const BouncingScrollPhysics(),
                               children: [
                                 SizedBox(
                                     width:SizeConfig.screenWidth,
                                     height: SizeConfig.screenHeight,
                                     child: EmptyScreen(text: "Lead Not Found!     ",distanceFromTop: 10))
                               ], ),
                           ),
                         ),
                         Positioned(
                             top: SizeConfig.blockHeight*0,
                             child: SizedBox(
                               width: SizeConfig.screenWidth,
                               child: Padding(
                                 padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*2,vertical: SizeConfig.blockHeight*2),
                                 child: FilterTextFormField(
                                   clearIconTap: (){

                                     setState(() {
                                       _refreshPage();
                                       setState(() {
                                         fromDate="";
                                         toDate="";
                                         filterController.clear();
                                       });
                                        });
                                   },
                                   onChanged: (value){},
                                   controller: filterController,
                                   hintText: "Search",
                                   inputType: TextInputType.text,
                                   validator: (value){},
                                   isReadOnly: false,
                                   onSubmit: (value){
                                     leadListBloc.add(FetchLeadListEvent(fromDate: fromDate, toDate: toDate, search:filterController.text));
                                   },
                                   iconTap: (){
                                     _showPopupMenu(context);
                                   },
                                   filterText: "",
                                 ),
                               ),
                             )),
                         if(showNewLeadButton)...[
                           Positioned(
                               bottom: SizeConfig.blockHeight*2,
                               left: SizeConfig.screenWidth*0.3,
                               child:  Align(
                                 alignment: Alignment.bottomCenter,
                                 child: AddNewButton(title: "New Lead", onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                                     BlocProvider(create: (context)=>GetLeadByIdBloc()),
                                     BlocProvider(create: (context)=>EditLeadBloc()),
                                   ], child: CustomerInformationScreen(id:"",))));
                                 }),
                               ))
                         ]

                       ],
                     ),
                   );
                 }else if(state is LeadListFailedState){

               return ErrorScreen(onPressed: (){
                 leadListBloc.add(FetchLeadListEvent(fromDate: "", toDate: "", search: ""));
               });
             }
            return  Container();
        },)
    );
  }
  Widget dateSelect({required String title,required String date,required VoidCallback onTap})
  {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.date_range,color: COLORS.blue,size: SizeConfig.blockHeight*3.8,),
          SizedBox(width: SizeConfig.blockWidth*5,),
           Column(
            children: [
              NormalText(
                  fontWeight: FontWeight.w400,
                  color: COLORS.blue,
                  fontSize: 2,
                  text: title),
              NormalText(
                  fontWeight: FontWeight.w400,
                  color: COLORS.black,
                  fontSize: 2.5,
                  text: date),
            ],
          )
        ],
      ),
    );
  }
  Widget cardSubText({required String title,required String subTitle,required double width})
  {
    return SizedBox(
    width: SizeConfig.screenWidth*width,
        child: Text("${title} : ${subTitle}",
  style: TextStyle(fontSize: SizeConfig.blockHeight*1.8,color:COLORS.black,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500),
  overflow: TextOverflow.ellipsis,
  )
  );
  }


  void _showPopupMenu(BuildContext context) {

    showMenu<String>(
      context: context,
      color: COLORS.white,
      position:RelativeRect.fromDirectional(textDirection: TextDirection.ltr, start: SizeConfig.blockHeight*1, top: SizeConfig.blockHeight*30, end: 0, bottom: 0),
      items: [
        PopupMenuItem(
          value: "From Date",
          child: Container(
              padding: EdgeInsets.symmetric(horizontal:SizeConfig.blockWidth*2,vertical: SizeConfig.blockHeight*1),
              decoration: BoxDecoration(
                  color: fromDate.isNotEmpty?COLORS.skyBlue:COLORS.white,
                  borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1))
              ),

              child: NormalText(text: "From Date:$fromDate",color: COLORS.black,fontSize: 2,fontWeight: FontWeight.w600,)),
        ),
        PopupMenuItem(
          value: "To Date",
          child: Container(
              padding: EdgeInsets.symmetric(horizontal:SizeConfig.blockWidth*2,vertical: SizeConfig.blockHeight*1),
              decoration: BoxDecoration(
                  color: toDate.isNotEmpty?COLORS.skyBlue:COLORS.white,
                  borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1))
              ),

              child: NormalText(text: "To Date:$toDate",color: COLORS.black,fontSize:2,fontWeight: FontWeight.w600,)),
        ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {

          if(value=="From Date")
            {
              showSingleDatePickerHelper2(context: context,onDateSelected: (selectedDate){
                setState(() {
                  fromDate=selectedDate;
                  leadListBloc.add(FetchLeadListEvent(fromDate: fromDate, toDate: toDate, search:filterController.text));
                });
              });
            }else{
            showSingleDatePickerHelper2(context: context,onDateSelected: (selectedDate){
              setState(() {
                toDate=selectedDate;
                leadListBloc.add(FetchLeadListEvent(fromDate: fromDate, toDate: toDate, search:filterController.text));
              });
            });
          }

        });
      }
    });
  }


  Widget leadCard({required String name,required String enquiry,required String date,required String contactName,required String status,required VoidCallback menuTap,required VoidCallback cardTap,})
  {
    return InkWell(
      onTap: cardTap,
      splashColor: COLORS.skyBlue,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
        margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*1.5,),
        height: SizeConfig.blockHeight*16,
        decoration: BoxDecoration(
          /*boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0.1,
              blurRadius: 10,
              offset: Offset(0, 1),
            ),
          ],*/
            color: COLORS.white,
            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*2.5))
        ),
        child:Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NormalText(fontWeight: FontWeight.w700, color: COLORS.black, fontSize:2.2, text: name),
                  NormalText(fontWeight: FontWeight.w500, color: COLORS.grayLight, fontSize:1.8, text: "#$enquiry"),
                ],
              ),
              Align(alignment:Alignment.topRight,child: NormalText(fontWeight: FontWeight.w500, color: COLORS.grayLight, fontSize: 1.8, text: date)),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NormalText(fontWeight: FontWeight.w500, color: COLORS.grayLight, fontSize: 1.8, text: "Contact Name"),
                      NormalText(fontWeight: FontWeight.w700, color: COLORS.black, fontSize:2.2, text: "$contactName"),

                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*1.5,vertical: SizeConfig.blockHeight*0.2),
                        decoration: BoxDecoration(
                            color:status=="new"? COLORS.red.withOpacity(0.2):status=="Completed"?COLORS.green.withOpacity(0.2):COLORS.yellow.withOpacity(0.2),
                            border: Border.all(color:status=="new"? COLORS.red:status=="Completed"?COLORS.green:COLORS.yellow ,width: SizeConfig.blockWidth*0.1),
                            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1.5)
                            )),
                        child: NormalText(fontWeight: FontWeight.w500, color: COLORS.black, fontSize: 2, text:status),
                      ),
                      SizedBox(width: SizeConfig.blockWidth*5,),
                      InkWell(
                          onTap: menuTap,
                          child:const SvgImageHelper(image: "assets/image/svg_icons/more_icon.svg"))
                    ],
                  )
                ],
              ),

            ]
        ) ,
      ),
    );
  }
}

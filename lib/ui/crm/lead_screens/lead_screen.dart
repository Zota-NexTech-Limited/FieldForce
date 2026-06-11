import 'dart:ui';

import 'package:fieldsales/bloc/create_activity_bloc/create_activity_bloc.dart';
import 'package:fieldsales/bloc/edit_lead_bloc/edit_lead_bloc.dart';
import 'package:fieldsales/bloc/get_lead_by_id_bloc/get_lead_by_id_bloc.dart';
import 'package:fieldsales/bloc/lead_list_bloc/lead_list_bloc.dart';
import 'package:fieldsales/components/button_component/circular_button.dart';
import 'package:fieldsales/components/state_management_components/empty_screen_component.dart';
import 'package:fieldsales/components/state_management_components/error_screen.dart';
import 'package:fieldsales/components/state_management_components/loading_screen.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/filter_field.dart';
import 'package:fieldsales/components/text_form_field_component/not_editable_search_field.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/date_converter.dart';
import 'package:fieldsales/helper/reuse_functions/date_picker.dart';
import 'package:fieldsales/helper/reuse_functions/upper_camel_case.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/models/crm_models/new_lead_model.dart';
import 'package:fieldsales/ui/crm/lead_screens/add_lead_details_screen/add_lead_details_screen.dart';
import 'package:fieldsales/ui/crm/lead_screens/add_lead_details_screen/add_lead_screen.dart';
import 'package:fieldsales/ui/crm/lead_screens/add_lead_details_screen/customer_information_screen.dart';
import 'package:fieldsales/ui/home_screen/filter_screen.dart';
import 'package:fieldsales/ui/my_activity/schedule_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
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
                     backgroundColor: COLORS.scaffoldBg,
                     floatingActionButtonLocation:
                         FloatingActionButtonLocation.endFloat,
                     floatingActionButton: AnimatedScale(
                       duration: const Duration(milliseconds: 200),
                       curve: Curves.easeOut,
                       scale: showNewLeadButton ? 1 : 0,
                       child: FloatingActionButton.extended(
                         onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => MultiBlocProvider(providers: [
                             BlocProvider(create: (context) => GetLeadByIdBloc()),
                             BlocProvider(create: (context) => EditLeadBloc()),
                           ], child: CustomerInformationScreen(id: "", onSuccessFunction: () {
                             _refreshPage();
                           },))));
                         },
                         backgroundColor: COLORS.primaryColor,
                         foregroundColor: COLORS.white,
                         elevation: 3,
                         icon: const Icon(Icons.add_rounded, size: 22),
                         label: const Text(
                           "New Lead",
                           style: TextStyle(
                             fontFamily: 'Inter',
                             fontWeight: FontWeight.w600,
                             fontSize: 14.5,
                           ),
                         ),
                       ),
                     ),
                     body: Stack(
                       children: [
                         Container(
                           margin: EdgeInsets.only(top: SizeConfig.blockHeight*12,left: SizeConfig.blockWidth*4,right:SizeConfig.blockWidth*4 ),
                           width: SizeConfig.screenWidth,
                           height: SizeConfig.screenHeight,
                           child: RefreshIndicator(
                             color: COLORS.primaryColor,
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
                                         padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*6),
                                         alignment: Alignment.centerLeft,
                                         decoration: BoxDecoration(
                                             color:COLORS.warning,
                                             borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4))
                                         ),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 SizedBox(
                                                       height: SizeConfig.blockHeight*3,
                                                       width: SizeConfig.blockWidth*10,
                                                       child: SvgImageHelper(image: "assets/image/svg_icons/my_activity.svg")),
                                                 SizedBox(height: SizeConfig.blockHeight*0.6,),
                                                 const NormalText(fontWeight: FontWeight.w600, color: COLORS.white, fontSize: 1.9, text: "Schedule Activity")
                                               ],
                                             ),
                                           ],
                                         )),
                                     secondaryBackground: Container(
                                         margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*1.5,),
                                         padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*6),
                                         alignment: Alignment.centerRight,
                                         decoration: BoxDecoration(
                                             color:COLORS.success,
                                             borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4))
                                         ),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.end,
                                           children: [
                                             Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 SizedBox(
                                                       height: SizeConfig.blockHeight*3,
                                                       width: SizeConfig.blockWidth*10,
                                                       child: SvgImageHelper(image: "assets/image/svg_icons/call_icon.svg")),
                                                 SizedBox(height: SizeConfig.blockHeight*0.6,),
                                                 NormalText(fontWeight: FontWeight.w600, color: COLORS.white, fontSize: 1.9, text: "Call")
                                               ],
                                             ),
                                           ],
                                         )), // Background for left swipe
                                     confirmDismiss: (direction) async {
                                       if (direction == DismissDirection.endToStart) {
                                         // Call function for left swipe
                                         launchUrl(Uri.parse('tel:+91 ${leadList[index].leadPhoneNumber!}'));

                                       } else {
                                         // Call function for right swipe
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=>CreateActivityBloc(),child:const ScheduleActivityScreen(),)));


                                       }

                                       return false; // Return true to dismiss
                                     },
                                     onDismissed: (direction) {

                                     },
                                     child:leadCard(name: "${leadList[index].leadFullName}", enquiry: "${leadList[index].leadInquiryMedium}", date: "15 jul 2024", contactName: " ${leadList[index].leadContactName}", status: "new", menuTap: (){}, cardTap: (){
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                                         BlocProvider(create: (context)=>GetLeadByIdBloc()..add(TriggerGetLeadByIdEvent(id: leadList[index].leadId!))),
                                         BlocProvider(create: (context)=>EditLeadBloc()),
                                       ], child: CustomerInformationScreen(id:leadList[index].leadId!,onSuccessFunction: (){
                                         _refreshPage();
                                       },))));
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
                             child:  Container(
                               width: SizeConfig.screenWidth,
                               padding: EdgeInsets.only(left: SizeConfig.blockWidth*4,right: SizeConfig.blockWidth*4,top: SizeConfig.blockHeight*2,bottom: SizeConfig.blockHeight*1.5),
                               decoration: BoxDecoration(
                                 color: COLORS.scaffoldBg,
                                 boxShadow: [
                                   BoxShadow(
                                     color: COLORS.shadow,
                                     blurRadius: 14,
                                     offset: const Offset(0, 6),
                                   ),
                                 ],
                               ),
                               child: NotEditableSearchField(text: filterController.text.isNotEmpty?filterController.text:"Search",onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterScreen(
                                   filterText: filterController.text,
                                   filterType: "",
                                   fromDate: fromDate,
                                   toDate: toDate,
                                   onSearch: (value){
                                     filterController.text=value['filter_text'];
                                     fromDate=value["from_date"];
                                     toDate=value["to_date"];
                                     print("filterController-----------${filterController.text}");

                                     state.leadList.clear();

                                     leadListBloc.add(FetchLeadListEvent(fromDate: fromDate, toDate: toDate, search:filterController.text));


                                   },
                                   screenName: "lead_screen",

                                 )))  ;
                               },),
                             )

                            /* SizedBox(
                               width: SizeConfig.screenWidth,
                               child: Padding(
                                 padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*3,vertical: SizeConfig.blockHeight*2),
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
                             )*/

                         ),

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
          Icon(Icons.date_range,color: COLORS.primaryColor,size: SizeConfig.blockHeight*3.8,),
          SizedBox(width: SizeConfig.blockWidth*5,),
           Column(
            children: [
              NormalText(
                  fontWeight: FontWeight.w400,
                  color: COLORS.primaryColor,
                  fontSize: 2,
                  text: title),
              NormalText(
                  fontWeight: FontWeight.w400,
                  color: COLORS.textColor,
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
  style: TextStyle(fontSize: SizeConfig.blockHeight*1.8,color:COLORS.textColor,fontFamily: Config.fountFamilyPrimary,fontWeight:FontWeight.w500),
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
                  color: fromDate.isNotEmpty?COLORS.backgroundColor:COLORS.white,
                  borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1))
              ),

              child: NormalText(text: "From Date:$fromDate",color: COLORS.textColor,fontSize: 2,fontWeight: FontWeight.w600,)),
        ),
        PopupMenuItem(
          value: "To Date",
          child: Container(
              padding: EdgeInsets.symmetric(horizontal:SizeConfig.blockWidth*2,vertical: SizeConfig.blockHeight*1),
              decoration: BoxDecoration(
                  color: toDate.isNotEmpty?COLORS.backgroundColor:COLORS.white,
                  borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*1))
              ),

              child: NormalText(text: "To Date:$toDate",color: COLORS.textColor,fontSize:2,fontWeight: FontWeight.w600,)),
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
    final Color statusBg = status=="new"
        ? COLORS.dangerSoft
        : status=="Completed"
            ? COLORS.successSoft
            : COLORS.warningSoft;
    final Color statusFg = status=="new"
        ? COLORS.danger
        : status=="Completed"
            ? COLORS.success
            : COLORS.warning;
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: SizeConfig.blockHeight*1.6,),
      decoration: BoxDecoration(
          color: COLORS.surface,
          border: Border.all(color: COLORS.cardBorder),
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4.2)),
          boxShadow: [
            BoxShadow(
              color: COLORS.shadow,
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ]
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: cardTap,
          splashColor: COLORS.primarySoft,
          highlightColor: COLORS.primarySoft.withOpacity(0.4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*2),
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.blockWidth*11,
                        height: SizeConfig.blockWidth*11,
                        decoration: BoxDecoration(
                          color: COLORS.primarySoft,
                          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)),
                        ),
                        child: Icon(Icons.person_outline_rounded, color: COLORS.primaryColor, size: SizeConfig.blockHeight*3.2,),
                      ),
                      SizedBox(width: SizeConfig.blockWidth*3,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize:2.2, text: toUpperCamelCase(name)),
                            SizedBox(height: SizeConfig.blockHeight*0.4,),
                            NormalText(fontWeight: FontWeight.w500, color: COLORS.textTertiary, fontSize:1.7, text: "#$enquiry"),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*2.5,vertical: SizeConfig.blockHeight*0.6),
                        decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*5))),
                        child: NormalText(fontWeight: FontWeight.w600, color: statusFg, fontSize: 1.6, text:toUpperCamelCase(status)),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight*1.6,),
                  Divider(height: 1, color: COLORS.divider,),
                  SizedBox(height: SizeConfig.blockHeight*1.4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NormalText(fontWeight: FontWeight.w500, color: COLORS.textTertiary, fontSize: 1.6, text: "Contact Name"),
                            SizedBox(height: SizeConfig.blockHeight*0.3,),
                            NormalText(fontWeight: FontWeight.w600, color: COLORS.textPrimary, fontSize:2, text: "${toUpperCamelCase(contactName)}"),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.event_outlined, color: COLORS.textTertiary, size: SizeConfig.blockHeight*2,),
                              SizedBox(height: SizeConfig.blockHeight*0.3,),
                              NormalText(fontWeight: FontWeight.w500, color: COLORS.textTertiary, fontSize: 1.6, text: date),
                            ],
                          ),
                          SizedBox(width: SizeConfig.blockWidth*3,),
                          InkWell(
                              onTap: menuTap,
                              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*5)),
                              child:Padding(
                                padding: EdgeInsets.all(SizeConfig.blockWidth*1),
                                child: const SvgImageHelper(image: "assets/image/svg_icons/more_icon.svg"),
                              ))
                        ],
                      )
                    ],
                  ),
                ]
            ) ,
          ),
        ),
      ),
    );
  }
}

import 'package:fieldsales/bloc/edit_opportunity_bloc/edit_opportunity_bloc.dart';
import 'package:fieldsales/bloc/get_opportunity_by_id_bloc/get_opportunity_by_id_bloc.dart';
import 'package:fieldsales/bloc/opportunity_list_bloc/opportunity_list_bloc.dart';
import 'package:fieldsales/components/state_management_components/empty_screen_component.dart';
import 'package:fieldsales/components/state_management_components/error_screen.dart';
import 'package:fieldsales/components/state_management_components/loading_screen.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/date_converter.dart';
import 'package:fieldsales/ui/crm/opportunity_screens/add_new_opportunity_screens/add-oppertunity_screen.dart';
import 'package:fieldsales/ui/crm/opportunity_screens/add_opportunity_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:fieldsales/components/button_component/add_new_button.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/components/text_form_field_component/filter_field.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/crm/lead_screens/add_lead_details_screen/add_lead_details_screen.dart';
import 'package:fieldsales/ui/crm/lead_screens/add_lead_details_screen/add_lead_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
class OpportunityScreen extends StatefulWidget {
  const OpportunityScreen({super.key});

  @override
  State<OpportunityScreen> createState() => _OpportunityScreenState();
}

class _OpportunityScreenState extends State<OpportunityScreen> {
  late OpportunityListBloc opportunityListBloc;
  ScrollController scrollController=ScrollController();
  double lastOffset = 0.0;
  bool  showNewOpportunityButton=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opportunityListBloc=BlocProvider.of<OpportunityListBloc>(context);
  }

  void _refreshPage() {
    setState(() {
      opportunityListBloc.add(const GetOpportunityListEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:BlocBuilder<OpportunityListBloc,OpportunityListState>(builder:
            (context, state) {
          if(state is OpportunityListLoadingState)
            {
              return const LoadingScreen();
            }
          else if(state is OpportunityListSuccessState)
            {
              return RefreshIndicator(
                color: COLORS.blue,
                onRefresh: (){
                  return Future.delayed(
                      const Duration(milliseconds: 200),
                          (){
                            _refreshPage();

                      }
                  );
                },
                child: Scaffold(
                  backgroundColor: COLORS.skyBlue,
                  body: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: SizeConfig.blockHeight*3,left: SizeConfig.blockWidth*2,right: SizeConfig.blockWidth*2),
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        child:state.opportunityList.isNotEmpty?ListView.builder(
                          itemCount: state.opportunityList.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          controller: scrollController..addListener(() {

                            double currentOffset=scrollController.offset;
                            if (currentOffset > lastOffset)
                            {
                              print("scroll down***************************");
                              setState(() {
                                showNewOpportunityButton=false;
                              });
                            }else{
                              print("scroll top***************************");
                              setState(() {
                                showNewOpportunityButton=true;
                              });
                            }

                          }),
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
                              child: opportunityCard(
                                  name: "${state.opportunityList[index].opportunityCompanyName}",
                                  source: "${state.opportunityList[index].opportunitySource}",
                                  stage: "${state.opportunityList[index].opportunityStage}",
                                  contact: "${state.opportunityList[index].opportunityEmail}",
                                  status: "new",
                                  menuTap: (){},
                                  cardTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                                      BlocProvider(create: (context)=>GetOpportunityByIdBloc()..add(TriggerGetOpportunityByIdEvent(id: state.opportunityList[index].opportunityId.toString()))),
                                      BlocProvider(create: (context)=>EditOpportunityBloc()),
                                    ], child: AddOpportunityScreen(pageRefreshFunction: _refreshPage,),)
                                    ));

                                  }),
                            );
                          },):EmptyScreen(text: "Opportunity Not Found!",distanceFromTop: 10,),
                      ),
                     if(showNewOpportunityButton)...[
                       Positioned(
                           bottom: SizeConfig.blockHeight*2,
                           left: SizeConfig.screenWidth*0.3,
                           child:  Align(
                             alignment: Alignment.bottomCenter,
                             child: AddNewButton(title: "New Opportunity", onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(providers: [
                                 BlocProvider(create: (context)=>GetOpportunityByIdBloc()),
                                 BlocProvider(create: (context)=>EditOpportunityBloc()),
                               ], child: AddOpportunityScreen(pageRefreshFunction: _refreshPage,),)
                               ));
                             }),
                           )
                       )
                     ]
                    ],
                  ),
                ),
              );
            }
          else if(state is OpportunityListFailedState)
            {
              return ErrorScreen(onPressed: (){
                opportunityListBloc.add(const GetOpportunityListEvent());
              });
            }
          return Container();
        },)


    );
  }

  Widget opportunityCard({required String name,required String source,required String stage,required String contact,required String status,required VoidCallback menuTap,required VoidCallback cardTap,})
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
                  NormalText(fontWeight: FontWeight.w500, color: COLORS.grayLight, fontSize:1.8, text: "#$source"),
                ],
              ),
              Align(alignment:Alignment.topRight,child: NormalText(fontWeight: FontWeight.w500, color: COLORS.grayLight, fontSize: 1.8, text: stage)),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NormalText(fontWeight: FontWeight.w500, color: COLORS.grayLight, fontSize: 1.8, text: "Contact"),
                      NormalText(fontWeight: FontWeight.w700, color: COLORS.black, fontSize:2.2, text: "$contact"),

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

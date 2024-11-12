import 'package:fieldsales/bloc/lead_list_bloc/lead_list_bloc.dart';
import 'package:fieldsales/bloc/opportunity_list_bloc/opportunity_list_bloc.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/crm/lead_screens/lead_filter_screen.dart';
import 'package:fieldsales/ui/crm/lead_screens/lead_screen.dart';
import 'package:fieldsales/ui/crm/opportunity_screens/add_opportunity_details_screen.dart';
import 'package:fieldsales/ui/crm/opportunity_screens/opportunity_screen.dart';
import 'package:fieldsales/ui/my_activity/my_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CRMScreen extends StatefulWidget {
  const CRMScreen({super.key});

  @override
  State<CRMScreen> createState() => _CRMScreenState();
}

class _CRMScreenState extends State<CRMScreen>  with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final List<Widget> _tabs=[
     BlocProvider(create: (context)=>LeadListBloc()..add(const FetchLeadListEvent(fromDate: "", toDate: "", search: "")),child:const  LeadScreen(),),
    BlocProvider(create: (context)=>OpportunityListBloc()..add(const GetOpportunityListEvent()),child:const  OpportunityScreen(),),


  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: COLORS.skyBlue,
          body: Column(
            children: [
              SizedBox(height: SizeConfig.blockHeight*2,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*2),
                decoration: BoxDecoration(
                    color: COLORS.white,
                    borderRadius: BorderRadius.only(topLeft:  Radius.circular(SizeConfig.blockWidth*2),topRight: Radius.circular(SizeConfig.blockWidth*2))
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: COLORS.black,
                  indicatorColor: COLORS.primaryColor,
                  dividerColor: COLORS.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: EdgeInsets.all(SizeConfig.blockWidth * 0),
                  labelPadding: EdgeInsets.all(SizeConfig.blockWidth * 0),
                  unselectedLabelColor: COLORS.grayDark.withOpacity(0.6),
                  onTap: (value){
                    setState(() {

                    });
                  },
                  labelStyle: TextStyle(
                    color: COLORS.white,
                    fontSize: SizeConfig.blockWidth *4,
                    fontFamily: Config.fountFamilyPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: "LEAD"),
                    Tab(text: "OPPORTUNITY"),
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: TabBarView(
                    controller: _tabController,
                    children: _tabs,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

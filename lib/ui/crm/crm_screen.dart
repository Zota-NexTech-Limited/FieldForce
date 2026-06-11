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
    BlocProvider(create: (context)=>OpportunityListBloc()..add(const GetOpportunityListEvent(leadId: "",search: "")),child:const  OpportunityScreen(),),


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
          backgroundColor: COLORS.backgroundColor,
          body: Column(
            children: [
              SizedBox(height: SizeConfig.blockHeight * 2),
              // Modern segmented tab control inside a soft card.
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 4,
                ),
                padding: EdgeInsets.all(SizeConfig.blockWidth * 1.2),
                decoration: BoxDecoration(
                  color: COLORS.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: COLORS.cardBorder),
                  boxShadow: const [
                    BoxShadow(
                      color: COLORS.shadow,
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: COLORS.white,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  splashBorderRadius: BorderRadius.circular(12),
                  overlayColor:
                      MaterialStateProperty.all(Colors.transparent),
                  indicator: BoxDecoration(
                    color: COLORS.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: COLORS.shadow,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  unselectedLabelColor: COLORS.textSecondary,
                  onTap: (value) {
                    setState(() {});
                  },
                  labelStyle: TextStyle(
                    fontSize: SizeConfig.blockWidth * 3.6,
                    fontFamily: Config.fountFamilyPrimary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: SizeConfig.blockWidth * 3.6,
                    fontFamily: Config.fountFamilyPrimary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                  tabs: [
                    Tab(
                      height: SizeConfig.blockHeight * 5.5,
                      child: const Center(child: Text("LEAD")),
                    ),
                    Tab(
                      height: SizeConfig.blockHeight * 5.5,
                      child: const Center(child: Text("OPPORTUNITY")),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 1.5),
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

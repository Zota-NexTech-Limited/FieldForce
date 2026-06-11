import 'package:fieldsales/bloc/expense_list_bloc/expense_list_bloc.dart';
import 'package:fieldsales/bloc/get_activity_list/activity_list_bloc.dart';
import 'package:fieldsales/bloc/leave_list_bloc/leave_list_bloc.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/expense/expence_screen.dart';
import 'package:fieldsales/ui/leave/leave_screen.dart';
import 'package:fieldsales/ui/menu/day_plan/day_plan_screen.dart';
import 'package:fieldsales/ui/menu/report/reports_screen.dart';
import 'package:fieldsales/ui/my_activity/my_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedTab="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.scaffoldBg,
      body:SingleChildScrollView(
        child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4,vertical: SizeConfig.blockHeight*3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.blockWidth*1, bottom: SizeConfig.blockHeight*1),
              child: NormalText(fontWeight: FontWeight.w700, color: COLORS.textPrimary, fontSize: 2.6, text: "Menu"),
            ),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.blockWidth*1, bottom: SizeConfig.blockHeight*2.5),
              child: NormalText(fontWeight: FontWeight.w500, color: COLORS.textTertiary, fontSize: 1.7, text: "Quick access to your daily tools"),
            ),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Home";
              });
            }, title: "Home", icon: "assets/image/svg_icons/home_icon2.svg"),
            /*tabCard(onTap: (){
              setState(() {
                selectedTab="My Activity";
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>ActivityListBloc()..add(const FetchActivityListEvent()),child: MyActivityScreen(),)));
              });
            }, title: "My Activity", icon: "assets/image/svg_icons/my_activity.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Reports";
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportsScreen()));
                 });
            }, title: "Reports", icon: "assets/image/svg_icons/contacts_reports.svg"),*/
            tabCard(onTap: (){
              setState(() {
                selectedTab="End Day";
              });
            }, title: "End Day", icon: "assets/image/svg_icons/end_day.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Start Day";
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DayPlanScreen()));
              });
            }, title: "Start Day", icon: "assets/image/svg_icons/start_day.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Expense";
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>ExpenseListBloc()..add(const FetchExpenseListEvent()),child: const ExpenceScreen(),)));
              });
            }, title: "Expense", icon: "assets/image/svg_icons/expense.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Ticket Status";
              });
            }, title: "Ticket Status", icon: "assets/image/svg_icons/ticket_status.svg"),
            tabCard(onTap: (){
              setState(() {
                selectedTab="Leave";
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>LeaveListBloc()..add(const FetchLeaveListEvent()),child: LeaveScreen(),)));
              });
            }, title: "Leave", icon: "assets/image/svg_icons/call_black.svg"),
          ],
        ),

      ),
      ) ,
    );
  }

  Widget tabCard({required VoidCallback onTap,required String title,required String icon,})
  {
    final bool isSelected = selectedTab == title;
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.blockHeight*1.6),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth*4),
        child: InkWell(
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth*4),
          splashColor: COLORS.primarySoft,
          highlightColor: COLORS.primarySoft,
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth*4, vertical: SizeConfig.blockHeight*2),
            decoration: BoxDecoration(
              color: isSelected ? COLORS.primarySoft : COLORS.surface,
              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*4)),
              border: Border.all(color: isSelected ? COLORS.primaryColor : COLORS.cardBorder, width: 1),
              boxShadow: [
                BoxShadow(
                  color: COLORS.shadow,
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: SizeConfig.blockWidth*11,
                  width: SizeConfig.blockWidth*11,
                  decoration: BoxDecoration(
                    color: isSelected ? COLORS.white : COLORS.primarySoft,
                    borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockWidth*3)),
                  ),
                  padding: EdgeInsets.all(SizeConfig.blockWidth*2.5),
                  child: SvgImageHelper(image: icon),
                ),
                SizedBox(width: SizeConfig.blockWidth*4),
                Expanded(
                  child: NormalText(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? COLORS.primaryDark : COLORS.textPrimary,
                    fontSize: 2.0,
                    text: title,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: isSelected ? COLORS.primaryColor : COLORS.textTertiary,
                  size: SizeConfig.blockWidth*6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

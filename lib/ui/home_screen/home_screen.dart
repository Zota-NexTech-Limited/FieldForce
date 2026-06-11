import 'dart:ui';

import 'package:fieldsales/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fieldsales/bloc/expense_list_bloc/expense_list_bloc.dart';
import 'package:fieldsales/bloc/get_activity_list/activity_list_bloc.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/global_handler.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/crm/crm_screen.dart';
import 'package:fieldsales/ui/expense/expence_screen.dart';
import 'package:fieldsales/ui/my_activity/my_activity_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: COLORS.scaffoldBg,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig.blockWidth * 5,
                  SizeConfig.blockHeight * 3,
                  SizeConfig.blockWidth * 5,
                  SizeConfig.blockHeight * 1.5,
                ),
                child: NormalText(
                  fontWeight: FontWeight.w700,
                  color: COLORS.textPrimary,
                  fontSize: 2.4,
                  text: "Quick Actions",
                ),
              ),
              _buildGrid(),
              SizedBox(height: SizeConfig.blockHeight * 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(
        top: SizeConfig.blockHeight * 7,
        bottom: SizeConfig.blockHeight * 4,
        left: SizeConfig.blockWidth * 5,
        right: SizeConfig.blockWidth * 5,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [COLORS.primaryColor, COLORS.primaryDark],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(SizeConfig.blockWidth * 8),
          bottomRight: Radius.circular(SizeConfig.blockWidth * 8),
        ),
        boxShadow: [
          BoxShadow(
            color: COLORS.primaryColor.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NormalText(
                fontWeight: FontWeight.w700,
                color: COLORS.onPrimaryColor,
                fontSize: 2.6,
                text: "Dashboard",
              ),
              InkWell(
                borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 6),
                onTap: () {
                  setState(() {
                    GlobalBlocClass.authenticationBloc!
                        .add(AuthenticationLogoutEvent());
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
                  decoration: BoxDecoration(
                    color: COLORS.onPrimaryColor.withOpacity(0.15),
                    borderRadius:
                        BorderRadius.circular(SizeConfig.blockWidth * 3),
                  ),
                  child: Icon(
                    CupertinoIcons.power,
                    color: COLORS.onPrimaryColor,
                    size: SizeConfig.blockHeight * 2.8,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockHeight * 3),
          Row(
            children: [
              Container(
                height: SizeConfig.blockHeight * 8,
                width: SizeConfig.blockHeight * 8,
                decoration: BoxDecoration(
                  color: COLORS.onPrimaryColor.withOpacity(0.18),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: COLORS.onPrimaryColor.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: NormalText(
                    text: Config.userName[0].toUpperCase(),
                    color: COLORS.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 3.6,
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                      fontWeight: FontWeight.w400,
                      color: COLORS.onPrimaryColor.withOpacity(0.85),
                      fontSize: 1.9,
                      text: "Welcome back",
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 0.6),
                    NormalText(
                      fontWeight: FontWeight.w700,
                      color: COLORS.onPrimaryColor,
                      fontSize: 2.6,
                      text: Config.userName.toUpperCase(),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 0.4),
                    NormalText(
                      fontWeight: FontWeight.w300,
                      color: COLORS.onPrimaryColor.withOpacity(0.8),
                      fontSize: 1.7,
                      text: "15-07-2001",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: homeCard(
                  icon: "assets/image/svg_icons/calender_icon.svg",
                  title: "End Day",
                  onTap: () {},
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 4),
              Expanded(
                child: homeCard(
                  icon: "assets/image/svg_icons/calender_icon.svg",
                  title: "Day Plan",
                  onTap: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockHeight * 2),
          Row(
            children: [
              Expanded(
                child: homeCard(
                  icon: "assets/image/svg_icons/calender_icon.svg",
                  title: "Reports",
                  onTap: () {},
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 4),
              Expanded(
                child: homeCard(
                  icon: "assets/image/svg_icons/calender_icon.svg",
                  title: "CRM",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CRMScreen()));
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockHeight * 2),
          Row(
            children: [
              Expanded(
                child: homeCard(
                  icon: "assets/image/svg_icons/calender_icon.svg",
                  title: "My Activity",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => ActivityListBloc()
                                    ..add(const FetchActivityListEvent()),
                                  child: MyActivityScreen(),
                                )));
                  },
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 4),
              Expanded(
                child: homeCard(
                  icon: "assets/image/svg_icons/calender_icon.svg",
                  title: "Expense",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => ExpenseListBloc()
                                    ..add(const FetchExpenseListEvent()),
                                  child: const ExpenceScreen(),
                                )));
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockHeight * 2),
          Row(
            children: [
              Expanded(
                child: homeCard(
                  icon: "assets/image/svg_icons/calender_icon.svg",
                  title: "Ticket Status ",
                  onTap: () {},
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 4),
              Expanded(
                child: homeCard(
                  icon: "assets/image/svg_icons/calender_icon.svg",
                  title: "Leave",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget homeCard(
      {required String icon,
      required String title,
      required VoidCallback onTap}) {
    return Material(
      color: COLORS.surface,
      borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4.5),
        onTap: onTap,
        child: Container(
          height: SizeConfig.blockHeight * 18,
          padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
          decoration: BoxDecoration(
            color: COLORS.surface,
            borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4.5),
            border: Border.all(color: COLORS.cardBorder),
            boxShadow: const [
              BoxShadow(
                color: COLORS.shadow,
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: SizeConfig.blockHeight * 6.5,
                width: SizeConfig.blockHeight * 6.5,
                decoration: BoxDecoration(
                  color: COLORS.primarySoft,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockWidth * 3.5),
                ),
                padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
                child: SvgImageHelper(image: icon),
              ),
              NormalText(
                fontWeight: FontWeight.w600,
                color: COLORS.textPrimary,
                fontSize: 2.1,
                text: title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

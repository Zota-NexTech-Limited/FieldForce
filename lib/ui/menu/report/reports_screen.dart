import 'dart:ui';

import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/reuse_property/reuse_padding.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/menu/report/day_plan_report_screen.dart';
import 'package:flutter/material.dart';
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: COLORS.scaffoldBg,
         /* appBar: appBarComponent(
              context: context,
              title: "Reports"
          ),*/
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: SizeConfig.screenWidth,
              padding: screenPadding(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockHeight * 1),
                  NormalText(
                    fontWeight: FontWeight.w700,
                    color: COLORS.textPrimary,
                    fontSize: 2.6,
                    text: "Reports",
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 0.6),
                  NormalText(
                    fontWeight: FontWeight.w400,
                    color: COLORS.textTertiary,
                    fontSize: 1.6,
                    text: "View and export your sales insights",
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 3),
                  _sectionLabel("Sales / Purchase Reports"),
                  SizedBox(height: SizeConfig.blockHeight * 1.6),
                  _reportCard(
                    items: [
                      _ReportItem(
                        icon: Icons.point_of_sale_rounded,
                        title: "Retails Sales v/s Purchase Report",
                        onTap: () {},
                      ),
                      _ReportItem(
                        icon: Icons.inventory_2_rounded,
                        title: "Stocklist Sales v/s Purchase Report",
                        onTap: () {},
                      ),
                      _ReportItem(
                        icon: Icons.event_note_rounded,
                        title: "Day Plan Report",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DayPlanReportScreen()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 3),
                  _sectionLabel("ABC Reports"),
                  SizedBox(height: SizeConfig.blockHeight * 1.6),
                  _reportCard(
                    items: [
                      _ReportItem(
                        icon: Icons.point_of_sale_rounded,
                        title: "Retails Sales v/s Purchase Report",
                        onTap: () {},
                      ),
                      _ReportItem(
                        icon: Icons.inventory_2_rounded,
                        title: "Stocklist Sales v/s Purchase Report",
                        onTap: () {},
                      ),
                      _ReportItem(
                        icon: Icons.event_note_rounded,
                        title: "Day Plan Report",
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 2),
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget _sectionLabel(String text) {
    return NormalText(
      fontWeight: FontWeight.w600,
      color: COLORS.textSecondary,
      fontSize: 1.7,
      text: text,
    );
  }

  Widget _reportCard({required List<_ReportItem> items}) {
    final List<Widget> children = [];
    for (int i = 0; i < items.length; i++) {
      children.add(buttonText(
        title: items[i].title,
        icon: items[i].icon,
        onTap: items[i].onTap,
      ));
      if (i != items.length - 1) {
        children.add(Divider(
          height: 1,
          thickness: 1,
          color: COLORS.divider,
          indent: SizeConfig.blockWidth * 4,
          endIndent: SizeConfig.blockWidth * 4,
        ));
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: COLORS.surface,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4.5),
        border: Border.all(color: COLORS.cardBorder),
        boxShadow: [
          BoxShadow(
            color: COLORS.shadow,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4.5),
        child: Column(children: children),
      ),
    );
  }

  Widget buttonText({required String title, required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockWidth * 4,
            vertical: SizeConfig.blockHeight * 2,
          ),
          child: Row(
            children: [
              Container(
                width: SizeConfig.blockWidth * 10,
                height: SizeConfig.blockWidth * 10,
                decoration: BoxDecoration(
                  color: COLORS.primarySoft,
                  borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
                ),
                child: Icon(
                  icon,
                  color: COLORS.primaryColor,
                  size: SizeConfig.blockHeight * 2.6,
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 3.5),
              Expanded(
                child: NormalText(
                  fontWeight: FontWeight.w500,
                  color: COLORS.textPrimary,
                  fontSize: 1.75,
                  text: title,
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 2),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: COLORS.textTertiary,
                size: SizeConfig.blockHeight * 1.9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  _ReportItem({required this.icon, required this.title, required this.onTap});
}

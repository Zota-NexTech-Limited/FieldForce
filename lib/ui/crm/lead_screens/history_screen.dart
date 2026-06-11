import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class LeadHistoryScreen extends StatefulWidget {
  const LeadHistoryScreen({super.key});

  @override
  State<LeadHistoryScreen> createState() => _LeadHistoryScreenState();
}

class _LeadHistoryScreenState extends State<LeadHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLORS.scaffoldBg,
        appBar: appBarComponent(title: "History", context: context),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockWidth * 4,
            vertical: SizeConfig.blockHeight * 2,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return _historyCard();
          },
        ),
      ),
    );
  }

  Widget _historyCard() {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockHeight * 1.8),
      padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
      decoration: BoxDecoration(
        color: COLORS.surface,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
        border: Border.all(color: COLORS.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: COLORS.shadow,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeConfig.blockHeight * 6.4,
            width: SizeConfig.blockHeight * 6.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
              border: Border.all(color: COLORS.cardBorder, width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              "assets/image/common/profile_image.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: SizeConfig.blockWidth * 3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: NormalText(
                        fontWeight: FontWeight.w700,
                        color: COLORS.textPrimary,
                        fontSize: 2.0,
                        text: "Mahesh Kumara M P",
                      ),
                    ),
                    SizedBox(width: SizeConfig.blockWidth * 2),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockWidth * 2.5,
                        vertical: SizeConfig.blockHeight * 0.5,
                      ),
                      decoration: BoxDecoration(
                        color: COLORS.primarySoft,
                        borderRadius:
                            BorderRadius.circular(SizeConfig.blockWidth * 5),
                      ),
                      child: NormalText(
                        fontWeight: FontWeight.w600,
                        color: COLORS.primaryColor,
                        fontSize: 1.5,
                        text: "15-07-2024",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.blockHeight * 1.2),
                _detailRow(
                  icon: Icons.event_outlined,
                  text: "Event Name Goes Here....",
                ),
                SizedBox(height: SizeConfig.blockHeight * 0.8),
                _detailRow(
                  icon: Icons.info_outline,
                  text: "Other Information Goes Here...",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: SizeConfig.blockHeight * 2.2,
          color: COLORS.textTertiary,
        ),
        SizedBox(width: SizeConfig.blockWidth * 2),
        Expanded(child: subTextComponent(text: text)),
      ],
    );
  }

  Widget subTextComponent({required String text}) {
    return NormalText(
      fontWeight: FontWeight.w500,
      color: COLORS.textSecondary,
      fontSize: 1.7,
      text: text,
    );
  }
}

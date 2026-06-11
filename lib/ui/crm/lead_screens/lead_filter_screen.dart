import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/button_component/normal_button.dart';
import 'package:fieldsales/components/dropdown_component/single_item_select_dropdown.dart';
import 'package:fieldsales/components/text_component/input_field_title_text.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';

class LeadFilterScreen extends StatefulWidget {
  const LeadFilterScreen({super.key});

  @override
  State<LeadFilterScreen> createState() => _LeadFilterScreenState();
}

class _LeadFilterScreenState extends State<LeadFilterScreen> {
  String ?selectedValue;
  String ?selectedStatus;
  String ?selectedProspectStatus;
  String ?selectedSubStatus;
  String ?selectedRMRemark;
  List<String> statusList=["Pending","Approve","Reject","Hold"];
  List<String> prospectStatusList=["Pending","Approve","Reject","Hold"];
  List<String> subStatusList=["Pending","Approve","Reject","Hold"];
  List<String> rmRemarkList=["Pending","Approve","Reject","Hold"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLORS.scaffoldBg,
        appBar: appBarComponent(title: "Lead Filter", context: context),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockWidth * 4,
            vertical: SizeConfig.blockHeight * 2.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel("Quick Filters"),
                    SizedBox(height: SizeConfig.blockHeight * 0.5),
                    radioListTile(title: "My Lead", value: "My Lead"),
                    _innerDivider(),
                    radioListTile(title: "Today's call", value: "Today's call"),
                    _innerDivider(),
                    radioListTile(
                        title: "Newly(fresh) lead", value: "Newly(fresh) lead"),
                    _innerDivider(),
                    radioListTile(
                        title: "Archive(Delete) Lead",
                        value: "Archive(Delete) Lead"),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 2),
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel("Refine Results"),
                    const InputFieldTitleText(text: "Status"),
                    SingleItemSelectDropdown(
                      selectedValue: selectedStatus,
                      list: statusList,
                      hint: "Select Status",
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                      isError: false,
                    ),
                    const InputFieldTitleText(text: "Prospect Status"),
                    SingleItemSelectDropdown(
                      selectedValue: selectedProspectStatus,
                      list: prospectStatusList,
                      hint: "Select Prospect Status",
                      onChanged: (value) {
                        setState(() {
                          selectedProspectStatus = value;
                        });
                      },
                      isError: false,
                    ),
                    const InputFieldTitleText(text: "Sub Status"),
                    SingleItemSelectDropdown(
                        selectedValue: selectedSubStatus,
                        list: subStatusList,
                        hint: "Select Sub Status",
                        isError: false,
                        onChanged: (value) {
                          setState(() {
                            selectedSubStatus = value;
                          });
                        }),
                    const InputFieldTitleText(text: "RM Remarks"),
                    SingleItemSelectDropdown(
                        selectedValue: selectedRMRemark,
                        list: rmRemarkList,
                        hint: "Select RM Remark",
                        isError: false,
                        onChanged: (value) {
                          setState(() {
                            selectedRMRemark = value;
                          });
                        }),
                    SizedBox(height: SizeConfig.blockHeight * 1),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NormalButton(
                      title: "Apply",
                      onTap: () {},
                      height: SizeConfig.blockHeight * 6,
                      width: SizeConfig.blockWidth * 40),
                  NormalButton(
                      title: "Clear",
                      onTap: () {},
                      height: SizeConfig.blockHeight * 6,
                      width: SizeConfig.blockWidth * 40),
                ],
              ),
              SizedBox(height: SizeConfig.blockHeight * 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 1.5,
      ),
      decoration: BoxDecoration(
        color: COLORS.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: COLORS.cardBorder),
        boxShadow: const [
          BoxShadow(
            color: COLORS.shadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.blockHeight * 0.5),
      child: NormalText(
        text: text.toUpperCase(),
        color: COLORS.textSecondary,
        fontSize: 1.5,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _innerDivider() {
    return Divider(
      height: SizeConfig.blockHeight * 0.5,
      thickness: 1,
      color: COLORS.divider,
    );
  }

  Widget radioListTile({required String value, required String title}) {
    final bool isSelected = selectedValue == value;
    return RadioListTile(
        value: value,
        title: NormalText(
          color: isSelected ? COLORS.primaryColor : COLORS.textPrimary,
          fontSize: 1.9,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          text: title,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 0),
        activeColor: COLORS.primaryColor,
        groupValue: selectedValue,
        visualDensity: const VisualDensity(vertical: -2),
        dense: true,
        onChanged: (value) {
          setState(() {
            selectedValue = value.toString();
          });
        });
  }
}

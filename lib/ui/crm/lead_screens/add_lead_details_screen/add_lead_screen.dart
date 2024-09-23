import 'package:fieldsales/components/app_bar_component/app_bar_component.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/normal_text.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:flutter/material.dart';
class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBarComponent(title: "Add Lead",context: context),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child:const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              ],
            ),
          ),
    ));
  }
}

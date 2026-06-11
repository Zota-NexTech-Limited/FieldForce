import 'package:fieldsales/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fieldsales/components/button_component/auth_screen_button.dart';
import 'package:fieldsales/components/svg_image_component.dart';
import 'package:fieldsales/components/text_component/auth_screen_inputfield_title_text.dart';
import 'package:fieldsales/components/text_form_field_component/normal_textform_field.dart';
import 'package:fieldsales/helper/colors.dart';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/helper/global_handler.dart';
import 'package:fieldsales/helper/local_constant.dart';
import 'package:fieldsales/helper/size_config.dart';
import 'package:fieldsales/ui/auth_screens/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HostUrlScreen extends StatefulWidget {
  const HostUrlScreen({super.key});

  @override
  State<HostUrlScreen> createState() => _HostUrlScreenState();
}

class _HostUrlScreenState extends State<HostUrlScreen> {
  TextEditingController urlController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Config.hostUrl.isNotEmpty)
      {
        urlController.text=Config.hostUrl;
      }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.backgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 6,
              vertical: SizeConfig.blockHeight * 4,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: SizeConfig.screenHeight - SizeConfig.blockHeight * 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ---------------------------------------------------------
                  // Brand header
                  // ---------------------------------------------------------
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
                      decoration: BoxDecoration(
                        color: COLORS.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: COLORS.shadow,
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: SvgImageHelper(
                        image: "assets/image/svg_icons/logo.svg",
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 3),
                  Text(
                    "Connect to your workspace",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: SizeConfig.blockHeight * 2.8,
                      fontWeight: FontWeight.w700,
                      color: COLORS.textPrimary,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 1),
                  Text(
                    "Enter your organisation's host or server URL to get started.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: SizeConfig.blockHeight * 1.7,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: COLORS.textSecondary,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 5),

                  // ---------------------------------------------------------
                  // Form card
                  // ---------------------------------------------------------
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
                    decoration: BoxDecoration(
                      color: COLORS.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: COLORS.cardBorder, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: COLORS.shadow,
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AuthScreenInputFieldTitleText(
                          text: "Enter Host OR Server URL",
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 1.6),
                        NormalTextFormField(
                          hintText: "Enter Host Url",
                          onChanged: (value) {},
                          inputType: TextInputType.emailAddress,
                          readOnly: false,
                          controller: urlController,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return 'Url should not be  Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 1.4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: SizeConfig.blockHeight * 2,
                              color: COLORS.textTertiary,
                            ),
                            SizedBox(width: SizeConfig.blockWidth * 2),
                            Expanded(
                              child: Text(
                                "Example: yourcompany.fieldsales.com",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: SizeConfig.blockHeight * 1.5,
                                  fontWeight: FontWeight.w400,
                                  color: COLORS.textTertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 3.2),
                        AuthScreenButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                storeToLocalStorage(
                                    LocalConstant.hostUrl, urlController.text);
                                Config.hostUrl =
                                    urlController.text.toLowerCase();
                                Config.url =
                                    "https://${urlController.text.toLowerCase()}/api";
                                Navigator.pushAndRemoveUntil(
                                  GlobalBlocClass.authenticationContext!,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                        create: (context) => AuthenticationBloc()
                                          ..add(const InitializeApp()),
                                        child: const Authentication()),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              });
                            }
                          },
                          text: "Save",
                          isLoding: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

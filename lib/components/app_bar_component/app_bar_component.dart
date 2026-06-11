import 'package:fieldsales/helper/colors.dart';
import 'package:flutter/material.dart';

/// Modern, consistent app bar used across screens.
///
/// Signature preserved: `appBarComponent(title:, context:)`.
AppBar appBarComponent({required String title, required BuildContext context}) {
  return AppBar(
    backgroundColor: COLORS.primaryColor,
    foregroundColor: COLORS.onPrimaryColor,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 2,
    shadowColor: COLORS.shadow,
    centerTitle: false,
    titleSpacing: 4,
    leadingWidth: 52,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      splashRadius: 22,
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 20,
        color: COLORS.onPrimaryColor,
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: 18,
        letterSpacing: 0.2,
        color: COLORS.onPrimaryColor,
      ),
    ),
  );
}

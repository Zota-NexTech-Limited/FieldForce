import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SvgImageHelper extends StatelessWidget {
  final String image;
  const SvgImageHelper({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(image,fit: BoxFit.contain,);
  }
}

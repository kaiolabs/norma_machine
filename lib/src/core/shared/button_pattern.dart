import 'package:flutter/material.dart';
import 'package:norma_machine/src/core/shared/text_pattern.dart';

import '../theme/color_outlet.dart';
import '../theme/size_outlet.dart';

class ButtonPattern extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? textColor;
  final String? fontFamily;
  final Function()? onPressed;
  const ButtonPattern({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = ColorOutlet.primaryColor,
    this.textColor = Colors.white,
    this.fontFamily = 'Inter',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizePattern),
      ),
      width: MediaQuery.of(context).size.width,
      height: 56,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizePattern),
        child: InkWell(
          onTap: onPressed ?? () {},
          borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizePattern),
          child: Center(
              child: TextPattern(
            text: label,
            color: textColor ?? Colors.white,
          ).bold()),
        ),
      ),
    );
  }
}

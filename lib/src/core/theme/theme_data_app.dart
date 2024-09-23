import 'package:flutter/material.dart';

import 'color_outlet.dart';

class ThemeDataApp {
  get lightTheme => ThemeData(
        primaryColor: ColorOutlet.primaryColor,

        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        colorScheme: const ColorScheme.light(
          onPrimary: ColorOutlet.primaryColor,
          surface: ColorOutlet.colorWhite,
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorOutlet.primaryColor,
          foregroundColor: ColorOutlet.colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),

        switchTheme: SwitchThemeData(
          thumbIcon: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const Icon(
                Icons.circle,
                size: 20,
                color: Color(0xFF7FA630),
              );
            } else {
              return const Icon(Icons.circle, size: 20, color: Color(0xFF30344C));
            }
          }),
          // color thumb
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFF7FA630);
            } else {
              return const Color(0xFF30344C);
            }
          }),
          // background color
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFF7FA630);
            } else {
              return const Color(0xFF30344C).withOpacity(0.4);
            }
          }),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),

        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(ColorOutlet.primaryColor),
        ),

        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(ColorOutlet.primaryColor),
        ),
        // conf showBottomSheet
        bottomSheetTheme: const BottomSheetThemeData(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: ColorOutlet.colorWhite,
          elevation: 1,
          shadowColor: ColorOutlet.colorWhite,
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
        ),
      );

  get darkTheme => ThemeData(
        primaryColor: ColorOutlet.primaryColor,
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorOutlet.secondaryColor,
        colorScheme: const ColorScheme.dark(
          onPrimary: ColorOutlet.primaryColor,
          surface: ColorOutlet.secondaryColor,
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(ColorOutlet.primaryColor),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(ColorOutlet.primaryColor),
        ),
      );
}

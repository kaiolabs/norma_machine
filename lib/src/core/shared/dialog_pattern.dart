// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DialogPattern {
  static Future show({
    /// context to be used to show the dialog
    required BuildContext context,

    /// content to be displayed inside the dialog
    required Widget child,

    /// Pattern: 0.9 = 90% of screen width
    double width = 0.9,

    /// background color of the dialog (default: Colors.white)
    Color backgroundColor = Colors.white,

    /// borderRadius of the dialog (default: 8)
    double borderRadius = 8,

    /// padding content of the dialog (default: 10)
    EdgeInsets padding = const EdgeInsets.all(10),

    /// lockBackButton: true = disable back button (default: false)
    bool lockBackButton = false,
  }) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        reverseTransitionDuration: const Duration(milliseconds: 250),
        transitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return SafeArea(
            child: _Dialog(
              width: width,
              backgroundColor: backgroundColor,
              borderRadius: borderRadius,
              padding: padding,
              lockBackButton: lockBackButton,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _Dialog extends StatefulWidget {
  final Widget child;
  final double width;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final bool lockBackButton;

  const _Dialog({
    super.key,
    required this.child,
    required this.width,
    required this.backgroundColor,
    required this.borderRadius,
    required this.padding,
    required this.lockBackButton,
  });

  @override
  State<_Dialog> createState() => __DialogState();
}

class __DialogState extends State<_Dialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.lockBackButton) {
          return false;
        } else {
          Navigator.pop(context);
          return true;
        }
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            width: MediaQuery.of(context).size.width * widget.width,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

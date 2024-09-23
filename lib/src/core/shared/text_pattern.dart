import 'package:flutter/material.dart';

class TextPattern {
  String text;
  double fontSize;
  Color color;
  TextAlign textAlign;
  int maxLines;
  TextOverflow overflow;

  TextPattern({
    this.text = '',
    this.fontSize = 16,
    this.color = const Color(0xFF2E334D),
    this.textAlign = TextAlign.start,
    this.maxLines = 1000,
    this.overflow = TextOverflow.ellipsis,
  });

  Text black() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: color,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Text bold() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: color,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text extraBold() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: color,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Text extraLight() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: color,
        fontWeight: FontWeight.w200,
      ),
    );
  }

  Text light() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: color,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Text medium() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text regular() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: color,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Text semiBold() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text thin() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: color,
        fontWeight: FontWeight.w100,
      ),
    );
  }
}

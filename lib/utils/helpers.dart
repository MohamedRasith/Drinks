import 'package:flutter/material.dart';
import 'package:drinks/utils/globals.dart';

void showSnackBar(
  String? text, {
  Duration duration = const Duration(seconds: 2),
}) {
  if (isNullOrBlank(text)) return;

  Globals.scaffoldMessengerKey.currentState
    ?..clearSnackBars()
    ..showSnackBar(
      SnackBar(content: Text(text!), duration: duration),
    );
}

bool isNullOrBlank(String? data) => data?.trim().isEmpty ?? true;

String capitalizeFirst(String? text) => isNullOrBlank(text)
    ? ''
    : '${text?[0].toUpperCase()}${text?.substring(1).toLowerCase()}';

// Size getParagraphSize(
//   String? text, {
//   TextStyle? style,
// }) {
//   final textPainter = TextPainter(
//     text: TextSpan(text: text, style: style),
//     textDirection: TextDirection.ltr,
//   )..layout(minWidth: 0, maxWidth: double.infinity);
//   return textPainter.size;
// }

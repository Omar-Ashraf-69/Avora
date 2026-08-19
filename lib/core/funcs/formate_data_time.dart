import 'package:flutter/material.dart';

String formatMessageTime(DateTime time,BuildContext context) {
  return TimeOfDay.fromDateTime(
    time.toLocal(),
  ).format(context);
}
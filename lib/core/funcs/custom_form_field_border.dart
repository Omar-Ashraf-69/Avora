import 'package:flutter/material.dart';

OutlineInputBorder customBorder([Color? color]) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color ?? Color(0xffF9FAFA), width: 1.3),
    borderRadius: BorderRadius.circular(16.0),
  );
}

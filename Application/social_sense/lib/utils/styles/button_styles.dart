import 'package:flutter/material.dart';

ButtonStyle customOutlieStyle() {
  return ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

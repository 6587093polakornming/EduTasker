import 'package:edu_tasker_app/constants/materialDesign.dart';
import 'package:flutter/material.dart';

Container getWidgetListViewHomePage(Widget insideWidget) {
  return Container(
      width: 160,
      height: 208,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: primaryColor,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      child: insideWidget);
}

Container getWidgetButtonHomePage(Widget insideWidget) {
  return Container(
    width: 160,
    height: 104,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: primaryColor,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    child: insideWidget
  );
}

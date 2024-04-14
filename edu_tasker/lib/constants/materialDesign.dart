import 'package:flutter/material.dart';

const Color tdWhite = Color.fromARGB(255, 255, 255, 255);
const Color tdBlue = Colors.blueAccent;
const Color primaryColor = Color.fromARGB(255, 24, 28, 75);

const TextStyle H5 = TextStyle(fontSize: 24, color: Colors.white);
const TextStyle subtitle = TextStyle(fontSize: 16, color: Colors.white);


String TimeOfDayToString(int hour, int minute) {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final String hourLabel = addLeadingZeroIfNeeded(hour);
    final String minuteLabel = addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }
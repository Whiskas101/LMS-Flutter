import 'package:dy_integrated_5/models/Semester.dart';
import 'package:flutter/material.dart';
import 'dart:io';

String removeFileExtension(String fileName) {
  final indexOfDot = fileName.lastIndexOf('.');
  if (indexOfDot == -1) {
    return fileName; // No extension found, return the original name
  }

  return fileName.substring(0, indexOfDot);
}

String shortFormOf(String title) {
  String result = "";

  title = title.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), ' ');
  List<String> words = title.split(" ");

  int i;
  for (i = 0; i < words.length; i++) {
    String word = words[i];

    if (word == " ") continue;
    // Checking if word is upper case. if so, add it to the result;
    if (word == word.toUpperCase()) {
      result += " $word "; // SPACE HERE IS IMPORTANT
    } else {
      // if the first letter is capital
      if (word[0] == word[0].toUpperCase()) {
        result += word[0];
      }
    }
  }

  result = result.split(" ").where((element) => element.isNotEmpty).toList()[0];
  return result;
}

double handlePercentage(String percentage, {bool floor = false}) {
  String temp = percentage.substring(0, percentage.length - 1);

  return floor
      ? // to floor, or not to floor that is the question
      double.parse(temp).floorToDouble() / 100
      : double.parse(temp) / 100;
}

String codeExtractor(String link) {
  return link.substring(link.lastIndexOf("=") + 1, link.length);
}

String dayAtIndex(int index) {
  if (index < 0 || index > 4) return "-";
  final map = {0: 'Mon', 1: 'Tue', 2: 'Wed', 3: 'Thu', 4: 'Fri'};

  return map[index]!;
}

String timeAtIndex(int index) {
  int rowIndex = (index / 5).floor();
  if (rowIndex < 0 || rowIndex > 8) return "";
  final map = {
    // Modulus of height of the matrix => current col num
    // Modulus of width of the matrix => current row num
    0: "9:00",
    1: "10:00",
    2: "11:00",
    3: "12:00",
    4: "1:00",
    5: "2:00",
    6: "3:00",
    7: "4:00",
  };

  return map[rowIndex]!;
}

String timeAtIndexLinear(int rowIndex) {
  // int rowIndex = (index/5).floor();
  if (rowIndex < 0 || rowIndex > 8) return "";
  final map = {
    // Modulus of height of the matrix => current col num
    // Modulus of width of the matrix => current row num
    0: "9:00",
    1: "10:00",
    2: "11:00",
    3: "12:00",
    4: "1:00",
    5: "2:00",
    6: "3:00",
    7: "4:00",
  };
  // print(map[rowIndex]);
  return map[rowIndex]!;
}

Color getSubjectColor(String subject) {
  if (subject.toLowerCase().contains("lab")) {
    return Colors.lightBlue;
  }
  if (subject.toLowerCase() == "break") {
    return Colors.greenAccent;
  }

  if (subject.toLowerCase() == "mp") {
    return Colors.lightGreenAccent;
  }

  return Colors.lightBlueAccent;
}

bool isDesktopType() {
  if (Platform.isAndroid || Platform.isIOS) {
    return false;
  }
  return true;
}

String overallAttendance(Semester sem) {
  String result = "";
  int totalSubjects = sem.subjects.length;
  double overallPercentage = 0;
  for (int i = 0; i < totalSubjects; i++) {
    String percentage = sem.subjects[i].attendance;
    double value = handlePercentage(percentage); // string to double
    overallPercentage += value;
  }

  overallPercentage /= totalSubjects;
  int percent = (overallPercentage * 100).toInt();
  result = "$percent%";
  return result;
}

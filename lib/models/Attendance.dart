// Simple attendance object to better abstract the more complicated
// analytical aspects

class Attendance {
  late int absent;
  late double percentage;
  late int present;
  late String subject;
  late int total;

  @override
  String toString() {
    String repr = """
      Attendance data for $subject 
         
        absent : $absent 
        percentage : $percentage 
        present : $present 
        subject : $subject 
        total : $total 

    """;
    return repr;
  }

  Attendance.fromJSON(Map<String, dynamic> jsonData) {
    absent = int.parse(jsonData['absent']);
    subject = jsonData['subject'];
    present = int.parse(jsonData['present']);
    percentage = double.parse(jsonData['percentage']);
    total = int.parse(jsonData['total']);
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['percentage'] = percentage;
    jsonData['absent'] = absent;
    jsonData['present'] = present;
    jsonData['subject'] = subject;
    jsonData['total'] = total;
    return jsonData;
  }

  // Generates the would-be percentage of attendance if X
  // no. of classes were missed.
  double futureAttendanceIf({int skip = 1}) {
    // Simple arithmetic formula:
    //    would_be_attendance = attended_classes / (total_classes_attended + no_of_classes_to_skip)
    return present / (total + skip);
  }

  // Returns how many classes must be attended to reach X
  // percentage attendance in this subject
  int requiredClassesIf({double min_attendance_percentage = 0.75}) {
    // Simple arithmetic here as well:
    //  let T : Total no. of classes
    //  let A : no. of classes attended
    //  let MinP : Min percentage that must be achieved
    //  let X : no. of classes needed to reach [min_attendance_percentage]
    //
    //    1)  (A + X)/(T + X) = (MinP)
    //    2)  (A + X) = (MinP)*(T + X)
    //    3)  (A + X) = MinP*T + MinP*X
    //    4)  A - MinP*T =  MinP*X - X
    //    5)  A - MinP*T =  X*(MinP - 1)
    //    6)  (A - MinP*T) /(MinP - 1) =  X

    if (min_attendance_percentage == 1.0) {
      // this will cause division by zero error
      return 0;
    }

    // if the attendance criteria is met, then theres no "need" to attend more lectures
    if (percentage / 100 >= min_attendance_percentage) return 0;

    // returning X

    return ((present - min_attendance_percentage * total) /
            (min_attendance_percentage - 1))
        .ceil();
  }

  // Returns no. of classes that can be skipped without attendance falling below
  // min attendance criteria
  int skippableClassesIf({double min_attendance_percentage = 0.75}) {
    // Very similar to the [requiredClasses] function
    // Simple formula:
    //  let T : Total no. of classes
    //  let A : no. of classes attended
    //  let MinP : Min percentage that must be achieved
    //  let X : no. of classes needed to reach [min_attendance_percentage]

    //      1) A / (T + X) = MinP
    //      2) A = MinP * (T + X)
    //      3) A = MinP * T + MinP * X
    //      4) A - MinP * T = MinP * X
    //      5) (A - MinP * T) / MinP = X
    //

    // Cant skip classes if you are exactly on the attendance limit, or below it
    print(percentage);
    if (percentage / 100 <= min_attendance_percentage) return 0;

    // Something off here, investigate.
    return ((present - min_attendance_percentage * total) /
            (min_attendance_percentage))
        .floor()
        .ceil();
  }

  // Timetable integrated functions go here
  // To be done after the timetable revamp
}

class AttendanceSummary {
  // This class is meant to work in sync with the timetable data to try and
  // suggest which classes to skip or not to skip.
  // Will have to look into how exactly I will make the process of creating
  // the timetable less tedious, and not ugly as hell on desktop aspect ratios

  List<Attendance> rawAttendanceData = [];

  // In this case, attendance summary expects an array of JSON strings
  // this just puts the attendance data into a variable, which can be operated on
  AttendanceSummary({List<Map<String, dynamic>>? attendanceList}) {
    // dont do anything, if it has no data supplied
    if (attendanceList == null) return;

    List<Attendance> temp = [];
    for (var subjectAttendanceJSON in attendanceList) {
      Attendance attendance = Attendance.fromJSON(subjectAttendanceJSON);
      temp.add(attendance);
    }
    rawAttendanceData = temp;
  }

  // Functions that return some useful statistics that can be used to inform
  // decisions about attending or missing lectures, and their impact on
  // overall and subject specific attendance.

  // TODO : Develop some sort of time metric to judge when
  // the professor has not updated the attendance in a long time
  // in order to not make some unfounded recommendations that are
  // working with outdated information.
  // Preferably one that can persist state outside, using shared preferences ig
}

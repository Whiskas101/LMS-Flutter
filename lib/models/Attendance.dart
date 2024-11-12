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
}

class AttendanceSummary {
  // This class is meant to work in sync with the timetable data to try and
  // suggest which classes to skip or not to skip.
  // Will have to look into how exactly I will make the process of creating
  // the timetable less tedious, and not ugly as hell on desktop aspect ratios

  late List<Attendance> data;

  // In this case, attendance summary expects an array of JSON strings
  AttendanceSummary(List<Map<String, dynamic>> attendanceList) {
    List<Attendance> temp = [];
    for (var subjectAttendanceJSON in attendanceList) {
      Attendance attendance = Attendance.fromJSON(subjectAttendanceJSON);
      // print(attendance.toString());
      print(subjectAttendanceJSON);
      temp.add(attendance);
    }

    // new Attendance.fromJSON({
    //   'percentage': 90,
    //   'subject': 'nollos',
    //   'total': '46',
    //   'absent': '6',
    //   'present': '40'
    // });
    data = temp;
  }
}

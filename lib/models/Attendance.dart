// Simple attendance object to better abstract the more complicated
// analytical aspects
class Attendance {
  late String absent;
  late String percentage;
  late String present;
  late String subject;
  late String total;

  Attendance.fromJSON(Map<String, dynamic> jsonData) {
    absent = jsonData['absent'];
    percentage = jsonData['percentage'];
    present = jsonData['present'];
    subject = jsonData['subject'];
    total = jsonData['total'];
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
}

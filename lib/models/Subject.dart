

class Subject{

  late String name;
  late String instructor;
  late String attendance;
  late String courseId;
  late String link;


  Subject.fromJSON(Map<String, dynamic> jsonData){
    name = jsonData['name'];
    instructor = jsonData['instructor'];
    attendance = jsonData['attendance'];
    link = jsonData['link'];
    courseId = jsonData['course_id'];
  }

  Map<String, dynamic> toJSON(){
    Map<String, dynamic> jsonData = <String,dynamic>{};

    jsonData['name'] = name;
    jsonData['instructor'] = instructor;
    jsonData['attendance'] = attendance;
    jsonData['link'] = link;
    jsonData['course_id'] = courseId;

    return jsonData;

  }

}
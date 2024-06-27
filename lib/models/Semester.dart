

import 'package:dy_integrated_5/models/Subject.dart';


class Semester{
  /// this only exists so I have a neat way of persisting data across multiple launches,
  /// without having to call the API again and again, it's a very slow process sometimes.

  late List<Subject> subjects;


  Semester.fromJSON(List<Map<String,dynamic>> jsonData){
    for (int i=0; i < jsonData.length; i++){
      Subject subject = Subject.fromJSON(jsonData[i]);
      subjects.add(subject);
    }
  }

  List<Map<String, dynamic>> toJSON(){
    List<Map<String, dynamic>>  jsonData = <Map<String, dynamic>>[];

    for (Subject subject in subjects){
      Map<String, dynamic> subjectJSON = subject.toJSON();
      jsonData.add(subjectJSON);
    }

    return jsonData;
  }






}
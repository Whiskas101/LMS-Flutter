
class CourseMaterial{

  late String link;
  late String name;
  late String type;

  CourseMaterial.fromJSON(Map<String, dynamic> jsonData){
    link = jsonData['link'];
    name = jsonData['name'];
    type = jsonData['type'];
  }

  Map<String, dynamic> toJSON(){
    Map<String,dynamic> jsonData = <String, dynamic>{};
    jsonData['link'] = link ;
    jsonData['name'] = name;
    jsonData['type'] = type;

    return jsonData;
  }

}
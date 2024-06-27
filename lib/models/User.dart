

class User{
  late String username;
  late String password;

  User({required this.username, required this.password});

  User.fromJson(Map<String, dynamic> jsonData){

    username = jsonData['username'];
    password = jsonData['password'];

  }


  Map<String, dynamic> toJSON(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;

    return data;
  }




}
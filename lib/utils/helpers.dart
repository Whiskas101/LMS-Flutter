String removeFileExtension(String fileName) {
  final indexOfDot = fileName.lastIndexOf('.');
  if (indexOfDot == -1) {
    return fileName; // No extension found, return the original name
  }

  return fileName.substring(0, indexOfDot);
}


String shortFormOf(String title){
  String result = "";

  List<String> Words = title.split(" ");
  int i;
  for (i = 0; i < Words.length; i++){
    String word = Words[i];

    // Checking if the first letter of the word is upper case. if so, add it to the result;
    if(word[0] == word[0].toUpperCase()){
      result += word[0];
    }
  }
  return result;
}


double handlePercentage(String percentage, {bool floor = false}){
  String temp = percentage.substring(0, percentage.length - 1);

  return floor ? // to floor, or not to floor that is the question
  double.parse(temp).floorToDouble()/100
      :
  double.parse(temp)/100;
}



String codeExtractor(String link){
  return link.substring(link.lastIndexOf("=")+1, link.length);
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Static Class for handling writing and reading file
///  ONLY FOR THE APPLICATION DIRECTORY.
class FileHandler{

    /// Just Syntactic sugar for getting the Application Documents Directory
    static Future<Directory> _getAppDir() async {
      return await getApplicationDocumentsDirectory();
    }

    static Future<void> writeThenReadFile(String dirname, String fileName, List<int> data, {bool rewrite = false}) async {

      Directory appDir = await _getAppDir();
      File file = File("${appDir.path}/$dirname/$fileName");
      try{
        await file.create(
          exclusive: rewrite, // rewrite is false, unless the user explicitly wants a re-download + rewrite
          recursive: true, // Create any missing directories if there are any
        );
        await file.writeAsBytes(data);
        print("Created a file ${dirname}/$fileName");

        // Creating a key value pair, 
        // dirname IS the subject name
        // removing the extension from the filename
        String removeFileExtension(String fileName) {
          final indexOfDot = fileName.lastIndexOf('.');
          if (indexOfDot == -1) {
            return fileName; // No extension found, return the original name
          }
          return fileName.substring(0, indexOfDot);
        }
        String rawFileName = removeFileExtension(fileName);
        String key = "$dirname@$rawFileName";
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(key, fileName);
        print("wrote into prefs => {$key : $fileName}");

        
        readFile(dirname, fileName); // Read after downloading duh

      }catch(e){
        
        rethrow; //rethrowing rn cause developing
      }

    }

    static Future<bool> readFile(String dirname, String fileName) async {
      print("Reading $fileName");
      Directory appDir = await _getAppDir();
      // print("${appDir.path}/$dirname/$fileName");
      File file = File("${appDir.path}/$dirname/$fileName");
      // print(file);
      // if file doesn't already exist, return false for failure to read
      if(await file.exists() == false){
        // print(file.existsSync());
        return false;
      }

      var result = await OpenFilex.open(file.path);
      print(result.message);
      return true;

    }


}
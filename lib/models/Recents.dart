
import 'CourseMaterial.dart';

/// Recent is just a CourseMaterial Object + a String for Subject
/// This was necessary because the way ApiService and resource downloading is set up,
/// to open a CourseMaterial, you need the folder within which it lies, [subject] is the name of the dir
/// This is simple for the case of opening individual subjects, from within their screens, as the data from the parent can be accessed
/// But for the case of recents, the Course Material can belong to any folder from the subjects, making this abstraction necessary.

/// It would have been ideal to have planned for this feature before hand, preventing a need for this class from ever arising.

class Recent{

  late CourseMaterial material;
  late String subject;

  Recent(this.material, this.subject);


}
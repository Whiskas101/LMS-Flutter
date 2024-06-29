


import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_service.dart';

class CourseMaterialNotifier extends Notifier<List<CourseMaterial>>{
  @override
  List<CourseMaterial> build() {
    return []; //default is an empty list
  }

  void getCourseMaterials(String link, {bool forceReFetch = false})async {
    List<CourseMaterial> materials = await ApiService.getSubjectMaterial(link, forceReFetch: forceReFetch);
    state = materials;
  }


}

final courseMaterialProvider = NotifierProvider<CourseMaterialNotifier, List<CourseMaterial>>(
      () => CourseMaterialNotifier(),
);
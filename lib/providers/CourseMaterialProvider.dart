


import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/api_service.dart';

class CourseMaterialNotifier extends AsyncNotifier<List<CourseMaterial>>{
  @override
  List<CourseMaterial> build()  {
    return []; //default is an empty list
  }

  void getCourseMaterials(String link, {bool forceReFetch = false}) async {
    state = const AsyncLoading<List<CourseMaterial>>();
    List<CourseMaterial> materials = await ApiService.getSubjectMaterial(link, forceReFetch: forceReFetch);
    print("Found materials");
    state = AsyncData(materials);
  }

}

final courseMaterialProvider = AsyncNotifierProvider<CourseMaterialNotifier, List<CourseMaterial>>(
      () => CourseMaterialNotifier(),
);
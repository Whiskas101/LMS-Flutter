import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseMaterialNotifier extends AsyncNotifier<List<CourseMaterial>> {
  @override
  List<CourseMaterial> build() {
    return []; //default is an empty list
  }

  void getCourseMaterials(String link, {bool forceReFetch = false}) async {
    state = const AsyncLoading<List<CourseMaterial>>();
    final apiService = ref.read(apiServiceProvider);
    List<CourseMaterial> materials =
        await apiService.getSubjectMaterial(link, forceReFetch: forceReFetch);
    state = AsyncData(materials);
  }
}

final courseMaterialProvider =
    AsyncNotifierProvider<CourseMaterialNotifier, List<CourseMaterial>>(
  () => CourseMaterialNotifier(),
);

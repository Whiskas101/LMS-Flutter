import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final credentialProvider = FutureProvider<Map<String, String?>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getCredentials();
});

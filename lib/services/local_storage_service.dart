import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final localStorageServiceProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

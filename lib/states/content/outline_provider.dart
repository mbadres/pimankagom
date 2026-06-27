import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/nodes/library.dart';
import 'package:pimankagom/repositories/data_repository.dart';

final outlineProvider = FutureProvider<Library>((ref) {
  return ref.watch(dataRepositoryProvider).loadOutline();
});

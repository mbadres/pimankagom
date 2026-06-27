import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/nodes/chapter.dart';
import 'package:pimankagom/repositories/data_repository.dart';

final chapterProvider = FutureProvider.family<Chapter, String>((ref, chapterId) {
  return ref.watch(dataRepositoryProvider).loadChapter(chapterId);
});

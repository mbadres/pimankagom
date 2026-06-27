import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/core/node.dart';
import 'package:pimankagom/models/nodes/chapter.dart';
import 'package:pimankagom/models/nodes/library.dart';
import 'package:pimankagom/services/asset_data_service.dart';

class DataRepository {
  final AssetDataService _assetDataService;

  DataRepository({required AssetDataService assetDataService})
    : _assetDataService = assetDataService;

  Future<Library> loadOutline() async {
    final raw = await _assetDataService.loadString('assets/data/outline.json');
    return compute(_parseLibrary, raw);
  }

  Future<Chapter> loadChapter(String chapterId) async {
    final raw = await _assetDataService.loadString('assets/data/chapters/$chapterId.json');
    return compute(_parseChapter, raw);
  }
}

Library _parseLibrary(String raw) {
  return nodeFromJson(jsonDecode(raw) as Map<String, dynamic>) as Library;
}

Chapter _parseChapter(String raw) {
  return nodeFromJson(jsonDecode(raw) as Map<String, dynamic>) as Chapter;
}

final dataRepositoryProvider = Provider<DataRepository>((ref) {
  final assetDataService = ref.watch(assetDataServiceProvider);

  return DataRepository(assetDataService: assetDataService);
});

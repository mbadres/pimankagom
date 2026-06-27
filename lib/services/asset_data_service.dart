import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssetDataService {
  Future<String> loadString(String path) {
    return rootBundle.loadString(path);
  }
}

final assetDataServiceProvider = Provider<AssetDataService>((ref) => AssetDataService());

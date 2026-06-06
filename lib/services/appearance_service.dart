import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pimankagom/models/core/node.dart';

class AppearanceService {
  bool isVisible(Node node) {
    return true;
  }
}

final appearanceServiceProvider = Provider<AppearanceService>((ref) => AppearanceService());

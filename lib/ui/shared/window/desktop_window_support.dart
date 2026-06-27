import 'dart:io';

import 'package:flutter/foundation.dart';

bool get isDesktopWindowPlatform =>
    !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

#!/usr/bin/env dart
// ignore_for_file: avoid_print
// Usage:
//   dart run scripts/rename_app.dart
//   dart run scripts/rename_app.dart --dry-run
//   dart run scripts/rename_app.dart \
//     --name myapp \
//     --display-name "My App" \
//     --bundle-id com.example.myapp \
//     --description "Short description"

import 'dart:io';

// ANSI Colors
const _r = '\x1B[0m';
const _bold = '\x1B[1m';
const _green = '\x1B[32m';
const _yellow = '\x1B[33m';
const _red = '\x1B[31m';
const _cyan = '\x1B[36m';
const _dim = '\x1B[2m';

void main(List<String> args) async {
  final dryRun = args.contains('--dry-run');
  final argName = _arg(args, '--name');
  final argDisplay = _arg(args, '--display-name');
  final argBundle = _arg(args, '--bundle-id');
  final argDesc = _arg(args, '--description');

  print('$_bold╔══════════════════════════════════╗$_r');
  print('$_bold║    Flutter App Rename Script     ║$_r');
  print('$_bold╚══════════════════════════════════╝$_r');
  if (dryRun) print('$_yellow[DRY RUN – no files will be changed]$_r');
  print('');

  final root = _findRoot();
  if (root == null) {
    _err('pubspec.yaml not found. Run this script from the project root.');
    exit(1);
  }

  // Read current values
  final cur = _readCurrent(root);
  print('${_dim}Current values:$_r');
  print('  Name:          ${cur.name}');
  print('  Display name:  ${cur.displayName}');
  print('  Bundle ID:     ${cur.bundleId}');
  print('  Description:   ${cur.description}');
  print('');

  // New values — from args or interactive prompts
  final newName =
      argName ??
      _prompt('Technical name', cur.name, hint: 'lowercase/digits/underscores, e.g. myapp');
  final newDisplay =
      argDisplay ?? _prompt('Display name', cur.displayName, hint: 'Shown in store and launcher');
  final newBundle =
      argBundle ??
      _prompt(
        'Bundle ID',
        cur.bundleId,
        hint: 'Cannot be changed after publishing, e.g. com.example.myapp',
      );
  final newDesc = argDesc ?? _prompt('Short description', cur.description);

  // Validate
  if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(newName)) {
    _err('Technical name must only contain a-z, 0-9, _ and start with a-z.');
    exit(1);
  }
  if (!RegExp(r'^[a-z][a-z0-9]*(\.[a-z][a-z0-9]*)+$').hasMatch(newBundle)) {
    _err('Bundle ID must follow the format "xxx.yyy", e.g. com.example.myapp');
    exit(1);
  }

  print('');
  print('$_bold${dryRun ? '$_yellow[DRY RUN] ' : ''}Planned changes:$_r');
  _printDiff('Name', cur.name, newName);
  _printDiff('Display name', cur.displayName, newDisplay);
  _printDiff('Bundle ID', cur.bundleId, newBundle);
  _printDiff('Description', cur.description, newDesc);
  print('');

  if (!dryRun) {
    stdout.write('Continue? (y/N): ');
    final c = stdin.readLineSync()?.toLowerCase() ?? '';
    if (c != 'y' && c != 'yes') {
      print('Cancelled.');
      exit(0);
    }
    print('');
  }

  final n = _Names(
    oldName: cur.name,
    oldDisplay: cur.displayName,
    oldBundle: cur.bundleId,
    oldDesc: cur.description,
    newName: newName,
    newDisplay: newDisplay,
    newBundle: newBundle,
    newDesc: newDesc,
  );

  final changed = <String>[];

  // ── pubspec.yaml ──────────────────────────────────────────────────────────
  _replace(
    path: '$root/pubspec.yaml',
    replacements: [
      (RegExp(r'^name:\s*.+$', multiLine: true), 'name: ${n.newName}'),
      (RegExp(r'^description:\s*"[^"]*"', multiLine: true), 'description: "${n.newDesc}"'),
    ],
    dryRun: dryRun,
    changed: changed,
  );

  // ── Android: build.gradle.kts ─────────────────────────────────────────────
  _replace(
    path: '$root/android/app/build.gradle.kts',
    replacements: [
      (RegExp(r'namespace\s*=\s*"[^"]*"'), 'namespace = "${n.newBundle}"'),
      (RegExp(r'applicationId\s*=\s*"[^"]*"'), 'applicationId = "${n.newBundle}"'),
    ],
    dryRun: dryRun,
    changed: changed,
  );

  // ── Android: AndroidManifest.xml ──────────────────────────────────────────
  _replace(
    path: '$root/android/app/src/main/AndroidManifest.xml',
    replacements: [(RegExp(r'android:label="[^"]*"'), 'android:label="${n.newDisplay}"')],
    dryRun: dryRun,
    changed: changed,
  );

  // ── Android: MainActivity.kt (content + directory) ──────────────────────
  _renameKotlinPackage(root: root, n: n, dryRun: dryRun, changed: changed);

  // ── iOS: Info.plist ───────────────────────────────────────────────────────
  _replace(
    path: '$root/ios/Runner/Info.plist',
    replacements: [
      (
        RegExp(r'(<key>CFBundleDisplayName</key>\s*<string>)[^<]*(</string>)', dotAll: true),
        r'\1${n.newDisplay}\2',
      ),
      (
        RegExp(r'(<key>CFBundleName</key>\s*<string>)[^<]*(</string>)', dotAll: true),
        r'\1${n.newName}\2',
      ),
    ],
    dryRun: dryRun,
    changed: changed,
    customReplace: (content) {
      var c = content;
      c = c.replaceFirstMapped(
        RegExp(r'(<key>CFBundleDisplayName</key>\s*<string>)[^<]*(</string>)', dotAll: true),
        (m) => '${m[1]}${n.newDisplay}${m[2]}',
      );
      c = c.replaceFirstMapped(
        RegExp(r'(<key>CFBundleName</key>\s*<string>)[^<]*(</string>)', dotAll: true),
        (m) => '${m[1]}${n.newName}${m[2]}',
      );
      return c;
    },
  );

  // ── iOS: project.pbxproj ──────────────────────────────────────────────────
  _replaceAll(
    path: '$root/ios/Runner.xcodeproj/project.pbxproj',
    from: n.oldBundle,
    to: n.newBundle,
    fromAlt: '${n.oldBundle}.RunnerTests',
    toAlt: '${n.newBundle}.RunnerTests',
    dryRun: dryRun,
    changed: changed,
  );

  // ── macOS: AppInfo.xcconfig ───────────────────────────────────────────────
  final macOsName = n.newName; // technical name = bundle filename
  _replace(
    path: '$root/macos/Runner/Configs/AppInfo.xcconfig',
    replacements: [
      (RegExp(r'^PRODUCT_NAME\s*=\s*.+$', multiLine: true), 'PRODUCT_NAME = $macOsName'),
      (
        RegExp(r'^PRODUCT_BUNDLE_IDENTIFIER\s*=\s*.+$', multiLine: true),
        'PRODUCT_BUNDLE_IDENTIFIER = ${n.newBundle}',
      ),
      (
        RegExp(r'^PRODUCT_COPYRIGHT\s*=\s*.+$', multiLine: true),
        'PRODUCT_COPYRIGHT = Copyright © ${DateTime.now().year} ${n.newBundle}. All rights reserved.',
      ),
    ],
    dryRun: dryRun,
    changed: changed,
  );

  // ── macOS: Info.plist ─────────────────────────────────────────────────────
  _replace(
    path: '$root/macos/Runner/Info.plist',
    dryRun: dryRun,
    changed: changed,
    customReplace: (content) {
      // Insert or replace CFBundleDisplayName
      if (content.contains('<key>CFBundleDisplayName</key>')) {
        return content.replaceFirstMapped(
          RegExp(r'(<key>CFBundleDisplayName</key>\s*<string>)[^<]*(</string>)', dotAll: true),
          (m) => '${m[1]}${n.newDisplay}${m[2]}',
        );
      } else {
        // Insert before CFBundleName
        return content.replaceFirstMapped(
          RegExp(r'(<key>CFBundleName</key>)'),
          (m) => '\t<key>CFBundleDisplayName</key>\n\t<string>${n.newDisplay}</string>\n\t${m[1]}',
        );
      }
    },
  );

  // ── macOS: project.pbxproj ────────────────────────────────────────────────
  _replace(
    path: '$root/macos/Runner.xcodeproj/project.pbxproj',
    dryRun: dryRun,
    changed: changed,
    customReplace: (content) {
      final oldMacName = _extractMacOsProductName(content) ?? n.oldName;
      var c = content;
      // .app references
      c = c.replaceAll('$oldMacName.app', '${n.newName}.app');
      c = c.replaceAll(
        'BUNDLE_EXECUTABLE_FOLDER_PATH)/$oldMacName',
        'BUNDLE_EXECUTABLE_FOLDER_PATH)/${n.newName}',
      );
      // Bundle IDs
      c = c.replaceAll('${n.oldBundle}.RunnerTests', '${n.newBundle}.RunnerTests');
      c = c.replaceAll(n.oldBundle, n.newBundle);
      return c;
    },
  );

  // ── Web: manifest.json ────────────────────────────────────────────────────
  _replace(
    path: '$root/web/manifest.json',
    dryRun: dryRun,
    changed: changed,
    customReplace: (content) {
      var c = content;
      c = c.replaceFirstMapped(RegExp(r'"name"\s*:\s*"[^"]*"'), (_) => '"name": "${n.newDisplay}"');
      c = c.replaceFirstMapped(
        RegExp(r'"short_name"\s*:\s*"[^"]*"'),
        (_) => '"short_name": "${n.newName}"',
      );
      c = c.replaceFirstMapped(
        RegExp(r'"description"\s*:\s*"[^"]*"'),
        (_) => '"description": "${n.newDesc}"',
      );
      return c;
    },
  );

  // ── Web: index.html ───────────────────────────────────────────────────────
  _replace(
    path: '$root/web/index.html',
    dryRun: dryRun,
    changed: changed,
    customReplace: (content) {
      var c = content;
      c = c.replaceFirstMapped(
        RegExp(r'<title>[^<]*</title>'),
        (_) => '<title>${n.newDisplay}</title>',
      );
      c = c.replaceFirstMapped(
        RegExp(r'name="description"\s+content="[^"]*"'),
        (_) => 'name="description" content="${n.newDesc}"',
      );
      c = c.replaceFirstMapped(
        RegExp(r'name="apple-mobile-web-app-title"\s+content="[^"]*"'),
        (_) => 'name="apple-mobile-web-app-title" content="${n.newDisplay}"',
      );
      return c;
    },
  );

  // ── Windows: main.cpp ─────────────────────────────────────────────────────
  _replace(
    path: '$root/windows/runner/main.cpp',
    replacements: [(RegExp(r'window\.Create\(L"[^"]*"'), 'window.Create(L"${n.newDisplay}"')],
    dryRun: dryRun,
    changed: changed,
  );

  // ── Windows: Runner.rc ────────────────────────────────────────────────────
  _replace(
    path: '$root/windows/runner/Runner.rc',
    dryRun: dryRun,
    changed: changed,
    customReplace: (content) {
      var c = content;
      c = c.replaceFirstMapped(
        RegExp(r'VALUE "FileDescription",\s*"[^"]*"'),
        (_) => 'VALUE "FileDescription", "${n.newDisplay}"',
      );
      c = c.replaceFirstMapped(
        RegExp(r'VALUE "InternalName",\s*"[^"]*"'),
        (_) => 'VALUE "InternalName", "${n.newName}"',
      );
      c = c.replaceFirstMapped(
        RegExp(r'VALUE "OriginalFilename",\s*"[^"]*"'),
        (_) => 'VALUE "OriginalFilename", "${n.newName}.exe"',
      );
      c = c.replaceFirstMapped(
        RegExp(r'VALUE "ProductName",\s*"[^"]*"'),
        (_) => 'VALUE "ProductName", "${n.newDisplay}"',
      );
      return c;
    },
  );

  // ── Windows: CMakeLists.txt ───────────────────────────────────────────────
  _replace(
    path: '$root/windows/CMakeLists.txt',
    replacements: [
      (RegExp(r'set\(BINARY_NAME\s*"[^"]*"\)'), 'set(BINARY_NAME "${n.newName}")'),
      (RegExp(r'^project\([^\)]*\)', multiLine: true), 'project(${n.newName} LANGUAGES CXX)'),
    ],
    dryRun: dryRun,
    changed: changed,
  );

  // ── Linux: CMakeLists.txt ─────────────────────────────────────────────────
  _replace(
    path: '$root/linux/CMakeLists.txt',
    replacements: [
      (RegExp(r'set\(BINARY_NAME\s*"[^"]*"\)'), 'set(BINARY_NAME "${n.newName}")'),
      (RegExp(r'set\(APPLICATION_ID\s*"[^"]*"\)'), 'set(APPLICATION_ID "${n.newBundle}")'),
    ],
    dryRun: dryRun,
    changed: changed,
  );

  // ── Linux: my_application.cc ──────────────────────────────────────────────
  _replace(
    path: '$root/linux/runner/my_application.cc',
    dryRun: dryRun,
    changed: changed,
    customReplace: (content) => content
        .replaceAll(
          RegExp(r'gtk_header_bar_set_title\(header_bar,\s*"[^"]*"\)'),
          'gtk_header_bar_set_title(header_bar, "${n.newDisplay}")',
        )
        .replaceAll(
          RegExp(r'gtk_window_set_title\(window,\s*"[^"]*"\)'),
          'gtk_window_set_title(window, "${n.newDisplay}")',
        ),
  );

  // ── Dart: package-Imports ─────────────────────────────────────────────────
  if (n.oldName != n.newName) {
    _replaceDartImports(
      root: root,
      oldName: n.oldName,
      newName: n.newName,
      dryRun: dryRun,
      changed: changed,
    );
  }

  // ── Result ────────────────────────────────────────────────────────────────
  print('');
  if (changed.isEmpty) {
    print('${_yellow}No changes made (values already correct or no matches found).$_r');
  } else {
    final verb = dryRun ? 'would be changed' : 'changed';
    print('$_bold$_green✓ ${changed.length} file(s) $verb:$_r');
    for (final f in changed) {
      print('  $_green✓$_r ${f.replaceAll('$root/', '')}');
    }
    if (!dryRun) {
      print('');
      print('${_cyan}Next steps:$_r');
      print('  flutter pub get');
      print('  flutter clean  (recommended after bundle ID change)');
    }
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

class _AppValues {
  final String name;
  final String displayName;
  final String bundleId;
  final String description;
  const _AppValues({
    required this.name,
    required this.displayName,
    required this.bundleId,
    required this.description,
  });
}

class _Names {
  final String oldName, oldDisplay, oldBundle, oldDesc;
  final String newName, newDisplay, newBundle, newDesc;
  const _Names({
    required this.oldName,
    required this.oldDisplay,
    required this.oldBundle,
    required this.oldDesc,
    required this.newName,
    required this.newDisplay,
    required this.newBundle,
    required this.newDesc,
  });
}

String? _findRoot() {
  var dir = Directory.current;
  for (var i = 0; i < 5; i++) {
    if (File('${dir.path}/pubspec.yaml').existsSync()) return dir.path;
    dir = dir.parent;
  }
  return null;
}

_AppValues _readCurrent(String root) {
  String name = 'unknown';
  String description = '';

  final pubspec = File('$root/pubspec.yaml').readAsStringSync();
  final nameMatch = RegExp(r'^name:\s*(.+)$', multiLine: true).firstMatch(pubspec);
  if (nameMatch != null) name = nameMatch.group(1)!.trim();
  final descMatch = RegExp(r'^description:\s*"?([^"\n]*)"?', multiLine: true).firstMatch(pubspec);
  if (descMatch != null) description = descMatch.group(1)!.trim();

  // Bundle ID from Android
  String bundleId = 'unknown';
  final gradle = File('$root/android/app/build.gradle.kts');
  if (gradle.existsSync()) {
    final m = RegExp(r'applicationId\s*=\s*"([^"]+)"').firstMatch(gradle.readAsStringSync());
    if (m != null) bundleId = m.group(1)!;
  }

  // Display name from AndroidManifest
  String displayName = name;
  final manifest = File('$root/android/app/src/main/AndroidManifest.xml');
  if (manifest.existsSync()) {
    final m = RegExp(r'android:label="([^"]+)"').firstMatch(manifest.readAsStringSync());
    if (m != null) displayName = m.group(1)!;
  }

  return _AppValues(
    name: name,
    displayName: displayName,
    bundleId: bundleId,
    description: description,
  );
}

String _prompt(String label, String current, {String? hint}) {
  if (hint != null) stdout.write('$_cyan$label$_r $_dim($hint)$_r\n');
  stdout.write('$_cyan$label$_r [${_dim}Enter = "$current"$_r]: ');
  final input = stdin.readLineSync()?.trim() ?? '';
  return input.isEmpty ? current : input;
}

String? _arg(List<String> args, String flag) {
  final i = args.indexOf(flag);
  if (i == -1 || i + 1 >= args.length) return null;
  return args[i + 1];
}

void _printDiff(String label, String from, String to) {
  if (from == to) {
    print('  $_dim$label: $from (unchanged)$_r');
  } else {
    print('  $label: $_red$from$_r → $_green$to$_r');
  }
}

void _err(String msg) => print('$_red$_bold✗ Error: $msg$_r');

void _ok(String path, bool dryRun) {
  final flag = dryRun ? '$_yellow[DRY RUN]$_r ' : '';
  print('  $flag$_green✓$_r $path');
}

// Replace file content using regex list or a custom replace function
void _replace({
  required String path,
  List<(RegExp, String)>? replacements,
  required bool dryRun,
  required List<String> changed,
  String Function(String)? customReplace,
}) {
  final file = File(path);
  if (!file.existsSync()) return;

  var content = file.readAsStringSync();
  final original = content;

  if (customReplace != null) {
    content = customReplace(content);
  } else if (replacements != null) {
    for (final (pattern, replacement) in replacements) {
      content = content.replaceAll(pattern, replacement);
    }
  }

  if (content != original) {
    if (!dryRun) file.writeAsStringSync(content);
    _ok(path, dryRun);
    changed.add(path);
  }
}

// Plain string replacement (no RegExp)
void _replaceAll({
  required String path,
  required String from,
  required String to,
  String? fromAlt,
  String? toAlt,
  required bool dryRun,
  required List<String> changed,
}) {
  final file = File(path);
  if (!file.existsSync()) return;

  var content = file.readAsStringSync();
  final original = content;

  // Replace the more specific (longer) pattern first
  if (fromAlt != null && toAlt != null) {
    content = content.replaceAll(fromAlt, toAlt);
  }
  content = content.replaceAll(from, to);

  if (content != original) {
    if (!dryRun) file.writeAsStringSync(content);
    _ok(path, dryRun);
    changed.add(path);
  }
}

// Rename Kotlin package directory and update package declaration
void _renameKotlinPackage({
  required String root,
  required _Names n,
  required bool dryRun,
  required List<String> changed,
}) {
  final kotlinBase = '$root/android/app/src/main/kotlin';
  final dir = Directory(kotlinBase);
  if (!dir.existsSync()) return;

  // Locate MainActivity.kt
  File? mainActivity;
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('MainActivity.kt')) {
      mainActivity = entity;
      break;
    }
  }
  if (mainActivity == null) return;

  // Update package declaration
  var content = mainActivity.readAsStringSync();
  final original = content;
  content = content.replaceAll(
    RegExp(r'^package\s+\S+', multiLine: true),
    'package ${n.newBundle}',
  );

  if (!dryRun && content != original) {
    mainActivity.writeAsStringSync(content);
  }

  // Rename directory if bundle ID changed
  if (n.oldBundle != n.newBundle) {
    final newDirPath = '$kotlinBase/${n.newBundle.replaceAll('.', '/')}';
    final newDir = Directory(newDirPath);

    if (!dryRun) {
      newDir.createSync(recursive: true);
      File('$newDirPath/MainActivity.kt').writeAsStringSync(content);
      mainActivity.deleteSync();

      // Remove now-empty parent directories
      _cleanEmptyDirs(dir);
    }

    _ok('android/app/src/main/kotlin/.../ → ${n.newBundle.replaceAll('.', '/')}/', dryRun);
    changed.add(mainActivity.path);
  } else if (content != original) {
    _ok(mainActivity.path, dryRun);
    changed.add(mainActivity.path);
  }
}

void _cleanEmptyDirs(Directory dir) {
  for (final entity in dir.listSync(recursive: false).toList().reversed) {
    if (entity is Directory) {
      _cleanEmptyDirs(entity);
      if (entity.listSync().isEmpty) entity.deleteSync();
    }
  }
}

// Update all Dart package imports
void _replaceDartImports({
  required String root,
  required String oldName,
  required String newName,
  required bool dryRun,
  required List<String> changed,
}) {
  final dirs = [Directory('$root/lib'), Directory('$root/test')];
  int count = 0;
  for (final dir in dirs) {
    if (!dir.existsSync()) continue;
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final content = entity.readAsStringSync();
      final updated = content.replaceAll('package:$oldName/', 'package:$newName/');
      if (updated != content) {
        if (!dryRun) entity.writeAsStringSync(updated);
        count++;
      }
    }
  }
  if (count > 0) {
    _ok(
      'lib/**/*.dart + test/**/*.dart ($count files, package:$oldName/ → package:$newName/)',
      dryRun,
    );
    changed.add('$root/lib');
  }
}

// Extract PRODUCT_NAME from macOS project file
String? _extractMacOsProductName(String projectFile) {
  final m = RegExp(r'path\s*=\s*"([^"]+)\.app"').firstMatch(projectFile);
  return m?.group(1);
}

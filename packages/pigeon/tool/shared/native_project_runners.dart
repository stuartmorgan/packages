// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'process_utils.dart';

/// Runs a `flutter` [command] in the given Flutter [projectDirectory].
///
/// Any arguments to the command can be provided in [commandArguments].
Future<int> runFlutterCommand(
  String projectDirectory,
  String command, [
  List<String> commandArguments = const <String>[],
]) {
  final String flutterCommand = Platform.isWindows ? 'flutter.bat' : 'flutter';
  return runProcess(
    flutterCommand,
    <String>[
      command,
      ...commandArguments,
    ],
    workingDirectory: projectDirectory,
  );
}

/// Runs a 'flutter build [target]' in the given Flutter [projectDirectory].
///
/// Builds debug by default, but setting [debug] to false will give a release
/// build.
///
/// Other build flags can be passed via [flags].
Future<int> runFlutterBuild(
  String projectDirectory,
  String target, {
  bool debug = true,
  List<String> flags = const <String>[],
}) {
  return runFlutterCommand(
    projectDirectory,
    'build',
    <String>[
      target,
      if (debug) '--debug',
      ...flags,
    ],
  );
}

/// Runs an `xcodebuild` with the given arguments.
///
/// The [nativeProjectDirectory] must be the subdirectory of a Flutter project
/// containing the native project (e.g., `ios/` or `macos/`).
Future<int> runXcodeBuild(
  String nativeProjectDirectory, {
  String? sdk,
  String? destination,
  List<String> extraArguments = const <String>[],
}) {
  return runProcess(
    'xcodebuild',
    <String>[
      '-workspace',
      'Runner.xcworkspace',
      '-scheme',
      'Runner',
      if (sdk != null) ...<String>['-sdk', sdk],
      if (destination != null) ...<String>['-destination', destination],
      ...extraArguments,
    ],
    workingDirectory: nativeProjectDirectory,
  );
}

/// Runs Gradle build with the given arguments.
///
/// The [nativeProjectDirectory] must be the subdirectory of a Flutter project
/// containing the native project (e.g., `android/`).
Future<int> runGradleBuild(String nativeProjectDirectory, [String? command]) {
  return runProcess(
    './gradlew',
    <String>[
      if (command != null) command,
    ],
    workingDirectory: nativeProjectDirectory,
  );
}

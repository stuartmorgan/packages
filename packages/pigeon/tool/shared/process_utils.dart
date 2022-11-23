// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Process, stderr, stdout;

/// Attaches the `stdout` and `stdout` of [processFuture] to this process's
/// output streams.
Future<Process> _streamOutput(Future<Process> processFuture) async {
  final Process process = await processFuture;
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  return process;
}

/// Runs [command] with the given [arguments] and parameters.
///
/// If [streamOutput] is true, `stdout` and `stderr` will be forwarded from
/// the subprocess.
///
/// If [logFailure] is true, the command and its output will be logged if the
/// process exits with anything but 0.
Future<int> runProcess(String command, List<String> arguments,
    {String? workingDirectory,
    bool streamOutput = true,
    bool logFailure = false,
    bool runInShell = false}) async {
  final Future<Process> future = Process.start(
    command,
    arguments,
    workingDirectory: workingDirectory,
    runInShell: runInShell,
  );
  final Process process = await (streamOutput ? _streamOutput(future) : future);
  final int exitCode = await process.exitCode;
  if (exitCode != 0 && logFailure) {
    // ignore: avoid_print
    print('$command $arguments failed:');
    process.stdout.pipe(stdout);
    process.stderr.pipe(stderr);
  }
  return exitCode;
}

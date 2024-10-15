// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package io.flutter.plugins.videoplayer;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

public interface FlutterEngineListener {
  void onAttachedToEngine(@NonNull FlutterPlugin.FlutterPluginBinding binding);

  void onDetachedFromEngine(@NonNull FlutterPlugin.FlutterPluginBinding binding);
}

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.videoplayer;

import androidx.annotation.NonNull;
import io.flutter.FlutterInjector;
import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugins.videoplayer.Messages.AndroidVideoPlayerApi;

/** Android platform implementation of the VideoPlayerPlugin. */
public class VideoPlayerPlugin implements FlutterPlugin, AndroidVideoPlayerApi {
  private static final String TAG = "VideoPlayerPlugin";
  private final @NonNull FlutterState.Wrapper flutterState = new FlutterState.Wrapper(null);

  /** Register this with the v2 embedding for the plugin to respond to lifecycle callbacks. */
  public VideoPlayerPlugin() {}

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    if (flutterState.state != null && flutterState.state.engineListener != null) {
      flutterState.state.engineListener.onAttachedToEngine(binding);
    }

    final FlutterInjector injector = FlutterInjector.instance();
    flutterState.state =
        new FlutterState(
            binding.getApplicationContext(),
            binding.getBinaryMessenger(),
            injector.flutterLoader()::getLookupKeyForAsset,
            injector.flutterLoader()::getLookupKeyForAsset,
            binding.getTextureRegistry());
    AndroidVideoPlayerApi.setUp(binding.getBinaryMessenger(), this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    if (flutterState.state == null) {
      Log.wtf(TAG, "Detached from the engine before registering to it.");
    }
    if (flutterState.state != null && flutterState.state.engineListener != null) {
      flutterState.state.engineListener.onDetachedFromEngine(binding);
    }
    AndroidVideoPlayerApi.setUp(binding.getBinaryMessenger(), null);
    flutterState.state = null;
  }

  public void initialize(@NonNull String transferKey) {
    VideoPlayerGlobalTransfer transfer = VideoPlayerGlobalTransfer.getInstance();
    transfer.state.put(transferKey, flutterState);
  }
}

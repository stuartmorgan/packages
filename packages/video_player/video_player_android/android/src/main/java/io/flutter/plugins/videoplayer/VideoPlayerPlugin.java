// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.videoplayer;

import android.util.LongSparseArray;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.FlutterInjector;
import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.videoplayer.Messages.AndroidVideoPlayerApi;
import io.flutter.view.TextureRegistry;
import java.util.Map;

/** Android platform implementation of the VideoPlayerPlugin. */
public class VideoPlayerPlugin implements FlutterPlugin, AndroidVideoPlayerApi {
  private static final String TAG = "VideoPlayerPlugin";
  private final @NonNull FlutterState.Wrapper flutterState = new FlutterState.Wrapper(null);
  private final VideoPlayerOptions options = new VideoPlayerOptions();

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

  public @NonNull Long create(
      @NonNull String uri,
      @NonNull Map<String, String> httpHeaders,
      @Nullable String formatHint,
      @NonNull String transferKey) {
    TextureRegistry.SurfaceProducer handle =
        flutterState.state.textureRegistry.createSurfaceProducer();
    EventChannel eventChannel =
        new EventChannel(
            flutterState.state.binaryMessenger, "flutter.io/videoPlayer/videoEvents" + handle.id());

    final VideoAsset videoAsset;
    if (uri.startsWith("asset://")) {
      videoAsset = VideoAsset.fromAssetUrl(uri);
    } else if (uri.startsWith("rtsp://")) {
      videoAsset = VideoAsset.fromRtspUrl(uri);
    } else {
      VideoAsset.StreamingFormat streamingFormat = VideoAsset.StreamingFormat.UNKNOWN;
      if (formatHint != null) {
        switch (formatHint) {
          case "ss":
            streamingFormat = VideoAsset.StreamingFormat.SMOOTH;
            break;
          case "dash":
            streamingFormat = VideoAsset.StreamingFormat.DYNAMIC_ADAPTIVE;
            break;
          case "hls":
            streamingFormat = VideoAsset.StreamingFormat.HTTP_LIVE;
            break;
        }
      }
      videoAsset = VideoAsset.fromRemoteUrl(uri, streamingFormat, httpHeaders);
    }
    VideoPlayerGlobalTransfer transfer = VideoPlayerGlobalTransfer.getInstance();
    transfer.players.put(
        transferKey,
        VideoPlayer.create(
            flutterState.state.applicationContext,
            VideoPlayerEventCallbacks.bindTo(eventChannel),
            handle,
            videoAsset,
            options));

    return handle.id();
  }

  @Override
  public void setMixWithOthers(@NonNull Boolean mixWithOthers) {
    options.mixWithOthers = mixWithOthers;
  }
}

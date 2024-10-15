// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package io.flutter.plugins.videoplayer;

import android.content.Context;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.view.TextureRegistry;

public class FlutterState {
  public final Context applicationContext;
  public final BinaryMessenger binaryMessenger;
  public final KeyForAssetFn keyForAsset;
  public final KeyForAssetAndPackageName keyForAssetAndPackageName;
  public final TextureRegistry textureRegistry;
  public @Nullable FlutterEngineListener engineListener;

  public interface KeyForAssetFn {
    @NonNull
    String get(@NonNull String asset);
  }

  public interface KeyForAssetAndPackageName {
    @NonNull
    String get(@NonNull String asset, @NonNull String packageName);
  }

  FlutterState(
      Context applicationContext,
      BinaryMessenger messenger,
      KeyForAssetFn keyForAsset,
      KeyForAssetAndPackageName keyForAssetAndPackageName,
      TextureRegistry textureRegistry) {
    this.applicationContext = applicationContext;
    this.binaryMessenger = messenger;
    this.keyForAsset = keyForAsset;
    this.keyForAssetAndPackageName = keyForAssetAndPackageName;
    this.textureRegistry = textureRegistry;
  }

  // TODO(stuartmorgan): Replace this with a callback from Java to Dart; for now
  //  this is a hack to allow nulling it out on the Dart side from
  //  onDetachedFromEngine.
  public static class Wrapper {
    public @Nullable FlutterState state;

    public Wrapper(@Nullable FlutterState state) {
      this.state = state;
    }
  }
}

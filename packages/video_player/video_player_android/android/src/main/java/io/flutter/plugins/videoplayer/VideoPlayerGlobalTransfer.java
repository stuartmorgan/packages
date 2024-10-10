package io.flutter.plugins.videoplayer;

import androidx.annotation.NonNull;
import java.util.HashMap;
import java.util.Map;

// Temp hack to get access to VideoPlay objects from Dart.
public class VideoPlayerGlobalTransfer {
  public @NonNull Map<String, VideoPlayer> players = new HashMap<>();
  private static final VideoPlayerGlobalTransfer instance = new VideoPlayerGlobalTransfer();

  @NonNull
  public static VideoPlayerGlobalTransfer getInstance() {
    return instance;
  }
}

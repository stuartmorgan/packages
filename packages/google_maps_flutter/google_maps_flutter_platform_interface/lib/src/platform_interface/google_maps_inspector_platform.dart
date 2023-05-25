// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../google_maps_flutter_platform_interface.dart';

/// The interface that platform-specific implementations of
/// `google_maps_flutter` can extend to support state inpsection in tests.
abstract base class GoogleMapsInspectorPlatform {
  /// The instance of [GoogleMapsInspectorPlatform], if any.
  ///
  /// Platform implementations should set this with their own platform-specific
  /// class that extends [GoogleMapsInspectorPlatform] in their
  /// implementation of [GoogleMapsFlutterPlatform.enableDebugInspection].
  static GoogleMapsInspectorPlatform? instance;

  /// Returns the minimum and maxmimum zoom level settings.
  Future<MinMaxZoomPreference> getMinMaxZoomLevels({required int mapId}) {
    throw UnimplementedError('getMinMaxZoomLevels() has not been implemented.');
  }

  /// Returns true if the compass is enabled.
  Future<bool> isCompassEnabled({required int mapId}) {
    throw UnimplementedError('isCompassEnabled() has not been implemented.');
  }

  /// Returns true if lite mode is enabled.
  Future<bool> isLiteModeEnabled({required int mapId}) {
    throw UnimplementedError('isLiteModeEnabled() has not been implemented.');
  }

  /// Returns true if the map toolbar is enabled.
  Future<bool> isMapToolbarEnabled({required int mapId}) {
    throw UnimplementedError('isMapToolbarEnabled() has not been implemented.');
  }

  /// Returns true if the "my location" button is enabled.
  Future<bool> isMyLocationButtonEnabled({required int mapId}) {
    throw UnimplementedError(
        'isMyLocationButtonEnabled() has not been implemented.');
  }

  /// Returns true if the traffic overlay is enabled.
  Future<bool> isTrafficEnabled({required int mapId}) {
    throw UnimplementedError('isTrafficEnabled() has not been implemented.');
  }

  /// Returns true if the building layer is enabled.
  Future<bool> areBuildingsEnabled({required int mapId}) {
    throw UnimplementedError('areBuildingsEnabled() has not been implemented.');
  }

  /// Returns true if rotate gestures are enabled.
  Future<bool> areRotateGesturesEnabled({required int mapId}) {
    throw UnimplementedError(
        'areRotateGesturesEnabled() has not been implemented.');
  }

  /// Returns true if scroll gestures are enabled.
  Future<bool> areScrollGesturesEnabled({required int mapId}) {
    throw UnimplementedError(
        'areScrollGesturesEnabled() has not been implemented.');
  }

  /// Returns true if tilt gestures are enabled.
  Future<bool> areTiltGesturesEnabled({required int mapId}) {
    throw UnimplementedError(
        'areTiltGesturesEnabled() has not been implemented.');
  }

  /// Returns true if zoom controls are enabled.
  Future<bool> areZoomControlsEnabled({required int mapId}) {
    throw UnimplementedError(
        'areZoomControlsEnabled() has not been implemented.');
  }

  /// Returns true if zoom gestures are enabled.
  Future<bool> areZoomGesturesEnabled({required int mapId}) {
    throw UnimplementedError(
        'areZoomGesturesEnabled() has not been implemented.');
  }

  /// Returns information about the tile overlay with the given ID.
  ///
  /// The returned object will be synthesized from platform data, so will not
  /// be the same Dart object as the original [TileOverlay] provided to the
  /// platform interface with that ID, and not all fields (e.g.,
  /// [TileOverlay.tileProvider]) will be populated.
  Future<TileOverlay?> getTileOverlayInfo(TileOverlayId tileOverlayId,
      {required int mapId}) {
    throw UnimplementedError('getTileOverlayInfo() has not been implemented.');
  }
}

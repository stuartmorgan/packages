// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

// TODO(stuartmorgan): Eliminate this in favor of the platform interface
// VideoOptions class if/when we end up creating one.
class PassedVideoOptions {
  PassedVideoOptions({required this.preferredCameraDevice, this.maxDuration});

  final CameraDevice preferredCameraDevice;
  final Duration? maxDuration;
}

final class MockImagePickerPlatform extends ImagePickerPlatform {
  // Mock return values.
  LostDataResponse? lostDataResponse;
  LostData? legacyLostDataResponse;

  // Captured values passed by callers.
  ImageSource? source;
  ImagePickerOptions? imageOptions;
  MultiImagePickerOptions? multiImageOptions;
  PassedVideoOptions? videoOptions;

  @override
  Future<XFile?> getImageFromSource({
    required ImageSource source,
    ImagePickerOptions options = const ImagePickerOptions(),
  }) async {
    this.source = source;
    imageOptions = options;
    return null;
  }

  @override
  Future<List<XFile>> getMultiImageWithOptions({
    MultiImagePickerOptions options = const MultiImagePickerOptions(),
  }) async {
    multiImageOptions = options;
    return <XFile>[];
  }

  @override
  Future<XFile?> getVideo({
    required ImageSource source,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    Duration? maxDuration,
  }) async {
    this.source = source;
    videoOptions = PassedVideoOptions(
        preferredCameraDevice: preferredCameraDevice, maxDuration: maxDuration);
    return null;
  }

  @override
  Future<LostDataResponse> getLostData() async {
    return lostDataResponse!;
  }

  // Deprecated versions.

  @override
  Future<PickedFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    this.source = source;
    imageOptions = ImagePickerOptions(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
        preferredCameraDevice: preferredCameraDevice);
    return null;
  }

  @override
  Future<List<PickedFile>?> pickMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    multiImageOptions = MultiImagePickerOptions(
        imageOptions: ImageOptions(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: imageQuality));
    return null;
  }

  @override
  Future<PickedFile?> pickVideo({
    required ImageSource source,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    Duration? maxDuration,
  }) async {
    this.source = source;
    videoOptions = PassedVideoOptions(
        preferredCameraDevice: preferredCameraDevice, maxDuration: maxDuration);
    return null;
  }

  @override
  Future<LostData> retrieveLostData() async {
    return legacyLostDataResponse!;
  }
}

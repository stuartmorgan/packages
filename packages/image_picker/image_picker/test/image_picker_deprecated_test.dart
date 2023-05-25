// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: deprecated_member_use_from_same_package

// This file preserves the tests for the deprecated methods as they were before
// the migration. See image_picker_test.dart for the current tests.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import 'mock_image_picker_platform.dart';

void main() {
  group('ImagePicker', () {
    late MockImagePickerPlatform mockPlatform;

    setUp(() {
      mockPlatform = MockImagePickerPlatform();
      ImagePickerPlatform.instance = mockPlatform;
    });

    group('getImage', () {
      test('passes the camera source correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getImage(source: ImageSource.camera);

        expect(mockPlatform.source, ImageSource.camera);
      });

      test('passes the gallery source correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getImage(source: ImageSource.gallery);

        expect(mockPlatform.source, ImageSource.gallery);
      });

      test('passes default resizing options', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getImage(source: ImageSource.gallery);

        expect(mockPlatform.imageOptions?.imageQuality, null);
        expect(mockPlatform.imageOptions?.maxWidth, null);
        expect(mockPlatform.imageOptions?.imageQuality, null);
      });

      test('passes the width and height arguments correctly', () async {
        const double maxWidth = 10.0;
        const double maxHeight = 20.0;

        final ImagePicker picker = ImagePicker();
        await picker.getImage(
            source: ImageSource.camera,
            maxWidth: maxWidth,
            maxHeight: maxHeight);

        expect(mockPlatform.imageOptions?.maxWidth, maxWidth);
        expect(mockPlatform.imageOptions?.maxHeight, maxHeight);
      });

      test('passes image quality correctly', () async {
        const int quality = 70;

        final ImagePicker picker = ImagePicker();
        await picker.getImage(
            source: ImageSource.camera, imageQuality: quality);

        expect(mockPlatform.imageOptions?.imageQuality, quality);
      });

      test('handles a null image file response gracefully', () async {
        final ImagePicker picker = ImagePicker();

        expect(await picker.getImage(source: ImageSource.gallery), isNull);
        expect(await picker.getImage(source: ImageSource.camera), isNull);
      });

      test('camera position defaults to back', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getImage(source: ImageSource.camera);

        expect(mockPlatform.imageOptions?.preferredCameraDevice,
            CameraDevice.rear);
      });

      test('camera position can set to front', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getImage(
            source: ImageSource.camera,
            preferredCameraDevice: CameraDevice.front);

        expect(mockPlatform.imageOptions?.preferredCameraDevice,
            CameraDevice.front);
      });
    });

    group('getVideo', () {
      test('passes the camera source correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getVideo(source: ImageSource.camera);

        expect(mockPlatform.source, ImageSource.camera);
      });

      test('passes the gallery source correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getVideo(source: ImageSource.gallery);

        expect(mockPlatform.source, ImageSource.gallery);
      });

      test('passes null default duration', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getVideo(source: ImageSource.camera);

        expect(mockPlatform.videoOptions?.maxDuration, null);
      });

      test('passes the duration argument correctly', () async {
        const int durationSeconds = 10;

        final ImagePicker picker = ImagePicker();
        await picker.getVideo(
            source: ImageSource.camera,
            maxDuration: const Duration(seconds: durationSeconds));

        expect(
            mockPlatform.videoOptions?.maxDuration?.inSeconds, durationSeconds);
      });

      test('handles a null video file response gracefully', () async {
        final ImagePicker picker = ImagePicker();

        expect(await picker.getVideo(source: ImageSource.gallery), isNull);
        expect(await picker.getVideo(source: ImageSource.camera), isNull);
      });

      test('camera position defaults to back', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getVideo(source: ImageSource.camera);

        expect(mockPlatform.videoOptions?.preferredCameraDevice,
            CameraDevice.rear);
      });

      test('camera position can set to front', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getVideo(
            source: ImageSource.camera,
            preferredCameraDevice: CameraDevice.front);

        expect(mockPlatform.videoOptions?.preferredCameraDevice,
            CameraDevice.front);
      });
    });

    group('getLostData', () {
      test('gets success response', () async {
        final ImagePicker picker = ImagePicker();
        mockPlatform.legacyLostDataResponse = LostData(
            file: PickedFile('/example/path'), type: RetrieveType.image);

        final LostData response = await picker.getLostData();

        expect(response.type, RetrieveType.image);
        expect(response.file!.path, '/example/path');
      });

      test('gets error response', () async {
        final ImagePicker picker = ImagePicker();
        mockPlatform.legacyLostDataResponse = LostData(
            exception: PlatformException(
                code: 'test_error_code', message: 'test_error_message'),
            type: RetrieveType.video);

        final LostData response = await picker.getLostData();

        expect(response.type, RetrieveType.video);
        expect(response.exception!.code, 'test_error_code');
        expect(response.exception!.message, 'test_error_message');
      });
    });

    group('getMultiImage', () {
      test('passes default resizing options', () async {
        final ImagePicker picker = ImagePicker();
        await picker.getMultiImage();

        expect(mockPlatform.multiImageOptions?.imageOptions.imageQuality, null);
        expect(mockPlatform.multiImageOptions?.imageOptions.maxWidth, null);
        expect(mockPlatform.multiImageOptions?.imageOptions.maxHeight, null);
      });

      test('passes the width and height arguments correctly', () async {
        const double maxWidth = 10.0;
        const double maxHeight = 20.0;

        final ImagePicker picker = ImagePicker();
        await picker.getMultiImage(maxWidth: maxWidth, maxHeight: maxHeight);

        expect(mockPlatform.multiImageOptions?.imageOptions.maxWidth, maxWidth);
        expect(
            mockPlatform.multiImageOptions?.imageOptions.maxHeight, maxHeight);
      });

      test('passes image quality correctly', () async {
        const int quality = 70;

        final ImagePicker picker = ImagePicker();
        await picker.getMultiImage(imageQuality: quality);

        expect(
            mockPlatform.multiImageOptions?.imageOptions.imageQuality, quality);
      });

      test('handles a null image file response gracefully', () async {
        final ImagePicker picker = ImagePicker();

        expect(await picker.getMultiImage(), isNull);
        expect(await picker.getMultiImage(), isNull);
      });
    });
  });
}

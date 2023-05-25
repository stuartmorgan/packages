// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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

    group('pickImage', () {
      test('passes the camera source correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickImage(source: ImageSource.camera);

        expect(mockPlatform.source, ImageSource.camera);
      });

      test('passes the gallery source correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickImage(source: ImageSource.gallery);

        expect(mockPlatform.source, ImageSource.gallery);
      });

      test('passes default resizing options', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickImage(source: ImageSource.gallery);

        expect(mockPlatform.imageOptions?.imageQuality, null);
        expect(mockPlatform.imageOptions?.maxWidth, null);
        expect(mockPlatform.imageOptions?.imageQuality, null);
      });

      test('passes the width and height arguments correctly', () async {
        const double maxWidth = 10.0;
        const double maxHeight = 20.0;

        final ImagePicker picker = ImagePicker();
        await picker.pickImage(
            source: ImageSource.camera,
            maxWidth: maxWidth,
            maxHeight: maxHeight);

        expect(mockPlatform.imageOptions?.maxWidth, maxWidth);
        expect(mockPlatform.imageOptions?.maxHeight, maxHeight);
      });

      test('does not accept a negative width or height argument', () {
        final ImagePicker picker = ImagePicker();
        expect(
          () => picker.pickImage(source: ImageSource.camera, maxWidth: -1.0),
          throwsArgumentError,
        );

        expect(
          () => picker.pickImage(source: ImageSource.camera, maxHeight: -1.0),
          throwsArgumentError,
        );
      });

      test('passes image quality correctly', () async {
        const int quality = 70;

        final ImagePicker picker = ImagePicker();
        await picker.pickImage(
            source: ImageSource.camera, imageQuality: quality);

        expect(mockPlatform.imageOptions?.imageQuality, quality);
      });

      test('handles a null image file response gracefully', () async {
        final ImagePicker picker = ImagePicker();

        expect(await picker.pickImage(source: ImageSource.gallery), isNull);
        expect(await picker.pickImage(source: ImageSource.camera), isNull);
      });

      test('camera position defaults to back', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickImage(source: ImageSource.camera);

        expect(mockPlatform.imageOptions?.preferredCameraDevice,
            CameraDevice.rear);
      });

      test('camera position can set to front', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickImage(
            source: ImageSource.camera,
            preferredCameraDevice: CameraDevice.front);

        expect(mockPlatform.imageOptions?.preferredCameraDevice,
            CameraDevice.front);
      });

      test('full metadata argument defaults to true', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickImage(source: ImageSource.gallery);

        expect(mockPlatform.imageOptions?.requestFullMetadata, true);
      });

      test('passes the full metadata argument correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickImage(
          source: ImageSource.gallery,
          requestFullMetadata: false,
        );

        expect(mockPlatform.imageOptions?.requestFullMetadata, false);
      });
    });

    group('pickVideo', () {
      test('passes the camera source correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickVideo(source: ImageSource.camera);

        expect(mockPlatform.source, ImageSource.camera);
      });

      test('passes the gallery source correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickVideo(source: ImageSource.gallery);

        expect(mockPlatform.source, ImageSource.gallery);
      });

      test('passes null default duration', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickVideo(source: ImageSource.camera);

        expect(mockPlatform.videoOptions?.maxDuration, null);
      });

      test('passes the duration argument correctly', () async {
        const int durationSeconds = 10;

        final ImagePicker picker = ImagePicker();
        await picker.pickVideo(
            source: ImageSource.camera,
            maxDuration: const Duration(seconds: durationSeconds));

        expect(
            mockPlatform.videoOptions?.maxDuration?.inSeconds, durationSeconds);
      });

      test('handles a null video file response gracefully', () async {
        final ImagePicker picker = ImagePicker();

        expect(await picker.pickVideo(source: ImageSource.gallery), isNull);
        expect(await picker.pickVideo(source: ImageSource.camera), isNull);
      });

      test('camera position defaults to back', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickVideo(source: ImageSource.camera);

        expect(mockPlatform.videoOptions?.preferredCameraDevice,
            CameraDevice.rear);
      });

      test('camera position can set to front', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickVideo(
            source: ImageSource.camera,
            preferredCameraDevice: CameraDevice.front);

        expect(mockPlatform.videoOptions?.preferredCameraDevice,
            CameraDevice.front);
      });
    });

    group('retrieveLostData', () {
      test('retrieveLostData get success response', () async {
        final ImagePicker picker = ImagePicker();
        final XFile lostFile = XFile('/example/path');
        mockPlatform.lostDataResponse = LostDataResponse(
            file: lostFile, files: <XFile>[lostFile], type: RetrieveType.image);

        final LostDataResponse response = await picker.retrieveLostData();

        expect(response.type, RetrieveType.image);
        expect(response.file!.path, '/example/path');
      });

      test('retrieveLostData should successfully retrieve multiple files',
          () async {
        final ImagePicker picker = ImagePicker();
        final List<XFile> lostFiles = <XFile>[
          XFile('/example/path0'),
          XFile('/example/path1'),
        ];
        mockPlatform.lostDataResponse = LostDataResponse(
            file: lostFiles.last, files: lostFiles, type: RetrieveType.image);

        final LostDataResponse response = await picker.retrieveLostData();

        expect(response.type, RetrieveType.image);
        expect(response.file, isNotNull);
        expect(response.file!.path, '/example/path1');
        expect(response.files!.first.path, '/example/path0');
        expect(response.files!.length, 2);
      });

      test('retrieveLostData get error response', () async {
        final ImagePicker picker = ImagePicker();
        mockPlatform.lostDataResponse = LostDataResponse(
            exception: PlatformException(
                code: 'test_error_code', message: 'test_error_message'),
            type: RetrieveType.video);

        final LostDataResponse response = await picker.retrieveLostData();

        expect(response.type, RetrieveType.video);
        expect(response.exception!.code, 'test_error_code');
        expect(response.exception!.message, 'test_error_message');
      });
    });

    group('pickMultiImage', () {
      test('passes default resizing options', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickMultiImage();

        expect(mockPlatform.multiImageOptions?.imageOptions.imageQuality, null);
        expect(mockPlatform.multiImageOptions?.imageOptions.maxWidth, null);
        expect(mockPlatform.multiImageOptions?.imageOptions.maxHeight, null);
      });

      test('passes the width and height arguments correctly', () async {
        const double maxWidth = 10.0;
        const double maxHeight = 20.0;

        final ImagePicker picker = ImagePicker();
        await picker.pickMultiImage(maxWidth: maxWidth, maxHeight: maxHeight);

        expect(mockPlatform.multiImageOptions?.imageOptions.maxWidth, maxWidth);
        expect(
            mockPlatform.multiImageOptions?.imageOptions.maxHeight, maxHeight);
      });

      test('does not accept a negative width or height argument', () {
        final ImagePicker picker = ImagePicker();
        expect(
          () => picker.pickMultiImage(maxWidth: -1.0),
          throwsArgumentError,
        );

        expect(
          () => picker.pickMultiImage(maxHeight: -1.0),
          throwsArgumentError,
        );
      });

      test('passes image quality correctly', () async {
        const int quality = 70;

        final ImagePicker picker = ImagePicker();
        await picker.pickMultiImage(imageQuality: quality);

        expect(
            mockPlatform.multiImageOptions?.imageOptions.imageQuality, quality);
      });

      test('handles an empty image file response gracefully', () async {
        final ImagePicker picker = ImagePicker();

        expect(await picker.pickMultiImage(), isEmpty);
        expect(await picker.pickMultiImage(), isEmpty);
      });

      test('full metadata argument defaults to true', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickMultiImage();

        expect(mockPlatform.multiImageOptions?.imageOptions.requestFullMetadata,
            true);
      });

      test('passes the full metadata argument correctly', () async {
        final ImagePicker picker = ImagePicker();
        await picker.pickMultiImage(
          requestFullMetadata: false,
        );

        expect(mockPlatform.multiImageOptions?.imageOptions.requestFullMetadata,
            false);
      });
    });
  });
}

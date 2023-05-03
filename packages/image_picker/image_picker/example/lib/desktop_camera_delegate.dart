// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

/// An implementation of [ImagePickerCameraDelegate] using a minimal Flutter
/// UI and the "camera" plugin.
class DesktopCameraDelegate extends ImagePickerCameraDelegate {
  /// A callback to display a modal capture UI.
  ///
  /// This must be set before a photo or video request is handled.
  //
  // A production-quality implementation would likely use a separate window,
  // avoiding the interaction with the existing application's UI.
  void Function(Route<void> modalRoute)? displayCameraCapturePage;

  @override
  Future<XFile?> takePhoto(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) async {
    if (displayCameraCapturePage == null) {
      throw StateError('A displayCamera callback must be provided');
    }
    return _capture(_CaptureType.photo);
  }

  @override
  Future<XFile?> takeVideo(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) async {
    if (displayCameraCapturePage == null) {
      throw StateError('A displayCamera callback must be provided');
    }
    return _capture(_CaptureType.video);
  }

  Future<XFile?> _capture(_CaptureType type) {
    final Completer<XFile?> result = Completer<XFile?>();
    displayCameraCapturePage!(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return _CameraCaptureWidget(type, result);
        },
        fullscreenDialog: true));
    return result.future;
  }
}

enum _CaptureType { photo, video }

class _CameraCaptureWidget extends StatefulWidget {
  /// Default Constructor
  const _CameraCaptureWidget(this.type, this.captureResult);

  final _CaptureType type;
  final Completer<XFile?> captureResult;

  @override
  State<_CameraCaptureWidget> createState() {
    return _CameraCaptureWidgetState();
  }
}

class _CameraCaptureWidgetState extends State<_CameraCaptureWidget> {
  CameraController? controller;
  bool _recording = false;

  @override
  void initState() {
    super.initState();
    availableCameras().then((List<CameraDescription> cameras) {
      if (cameras.isNotEmpty) {
        _initializeCameraController(cameras.first);
      }
    }).onError((Object? error, StackTrace stackTrace) {
      if (error is CameraException) {
        showInSnackBar('Camera error ${error.code}\n${error.description}');
      } else {
        showInSnackBar('Camera error $error');
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool cameraInitialized = controller?.value.isInitialized ?? false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.type == _CaptureType.photo ? 'Take Photo' : 'Record Video'),
      ),
      body: WillPopScope(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: cameraInitialized
                      ? CameraPreview(controller!)
                      : const Text('No camera available'),
                ),
              ),
            ),
            if (cameraInitialized) _captureControlRowWidget(),
          ],
        ),
        onWillPop: () async {
          if (!widget.captureResult.isCompleted) {
            widget.captureResult.complete(null);
          }
          return true;
        },
      ),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    final CameraController? cameraController = controller;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (widget.type == _CaptureType.photo)
          IconButton(
            icon: const Icon(Icons.camera_alt),
            color: Colors.blue,
            onPressed:
                cameraController != null && cameraController.value.isInitialized
                    ? onTakePictureButtonPressed
                    : null,
          )
        else ...<Widget>[
          IconButton(
            icon: const Icon(Icons.videocam),
            color: Colors.blue,
            onPressed: cameraController != null &&
                    cameraController.value.isInitialized &&
                    !_recording
                ? onVideoRecordButtonPressed
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            color: Colors.red,
            onPressed: cameraController != null &&
                    cameraController.value.isInitialized &&
                    _recording
                ? onStopButtonPressed
                : null,
          ),
        ],
      ],
    );
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    cameraController.addListener(() {
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
      if (cameraController.value.isRecordingVideo != _recording) {
        setState(() {
          _recording = cameraController.value.isRecordingVideo;
        });
      }
    });

    await cameraController.initialize().then((_) {
      setState(() {
        controller = cameraController;
      });
    });
  }

  void onTakePictureButtonPressed() {
    takePicture();
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording();
  }

  void onStopButtonPressed() {
    stopVideoRecording();
  }

  void onCancelButtonPressed() {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    widget.captureResult.complete(null);
  }

  Future<void> startVideoRecording() async {
    try {
      await controller?.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<void> stopVideoRecording() async {
    try {
      final XFile? video = await controller?.stopVideoRecording();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      widget.captureResult.complete(video);
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  Future<void> takePicture() async {
    final CameraController cameraController = controller!;
    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return;
    }

    try {
      final XFile file = await cameraController.takePicture();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      widget.captureResult.complete(file);
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void _showCameraException(CameraException e) {
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

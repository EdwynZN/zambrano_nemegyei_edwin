import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_app/model/qr_features.dart';
import 'package:qr_app/presentation/controller/qr_response_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

final qrFeaturesProvider =
    AutoDisposeAsyncNotifierProvider<_FeaturesNotifer, QrFeatures>(
  _FeaturesNotifer.new,
  dependencies: [qrControllerProvider],
);

class _FeaturesNotifer extends AutoDisposeAsyncNotifier<QrFeatures> {
  @override
  FutureOr<QrFeatures> build() async {
    final controller = ref.watch(qrControllerProvider);
    final systemFeatures = await controller.getSystemFeatures();
    bool? hasFlash = systemFeatures.hasFlash;
    CameraType? camera;
    if (hasFlash) {
      hasFlash = await controller.getFlashStatus();
    }
    if (systemFeatures.hasBackCamera || systemFeatures.hasFrontCamera) {
      final cameraInfo = await controller.getCameraInfo();
      camera = CameraType(
        camera: _fromCameraFacing(cameraInfo),
        hasBoth: systemFeatures.hasBackCamera && systemFeatures.hasFrontCamera,
      );
    }
    return QrFeatures(
      flash: hasFlash,
      camera: camera,
    );
  }

  Camera _fromCameraFacing(CameraFacing cameraInfo) => switch (cameraInfo) {
        CameraFacing.front => Camera.front,
        CameraFacing.back || CameraFacing.unknown => Camera.back,
      };

  bool get _shouldSkip => state.maybeWhen(
        skipError: true,
        data: (data) => data.flash == null,
        error: (error, stackTrace) => false,
        orElse: () => true,
      );

  Future<void> toggleFlash() async {
    if (_shouldSkip) {
      return;
    }
    final controller = ref.read(qrControllerProvider);
    state = const AsyncLoading<QrFeatures>().copyWithPrevious(state);
    final future = await AsyncValue.guard(() async {
      await controller.toggleFlash();
      return controller.getFlashStatus();
    });
    state = future.maybeWhen(
      data: (data) {
        final previous = state.value!;
        return AsyncData(
          previous.copyWith(flash: data),
        );
      },
      error: (e, s) => AsyncError<QrFeatures>(e, s).copyWithPrevious(state),
      orElse: () => state,
    );
  }

  Future<void> toggleCamera() async {
    if (_shouldSkip) {
      return;
    }
    final controller = ref.read(qrControllerProvider);
    state = const AsyncLoading<QrFeatures>().copyWithPrevious(state);
    final future = await AsyncValue.guard(controller.flipCamera);
    state = future.maybeWhen(
      data: (data) {
        final previous = state.value!;
        return AsyncData(
          previous.copyWith.camera!(camera: _fromCameraFacing(data)),
        );
      },
      error: (e, s) => AsyncError<QrFeatures>(e, s).copyWithPrevious(state),
      orElse: () => state,
    );
  }

}

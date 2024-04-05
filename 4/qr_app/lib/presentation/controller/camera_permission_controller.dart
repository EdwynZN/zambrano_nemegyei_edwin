import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final cameraPermission = AsyncNotifierProvider<CameraNotifer, bool>(
  CameraNotifer.new,
);

class CameraNotifer extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  Future<void> askPermission() async {
    if (state.isLoading) {
      return;
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final status = await Permission.camera.request();
      return status.isGranted;
    });
  }
}

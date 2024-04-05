import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_features.freezed.dart';

enum Camera { front, back }

@freezed
class QrFeatures with _$QrFeatures {
  factory QrFeatures({
    final bool? flash,
    final CameraType? camera,
  }) = _QrFeatures;
	
}

@freezed
class CameraType with _$CameraType {
  factory CameraType({
    required final bool hasBoth,
    required final Camera camera,
  }) = _CameraType;
	
}
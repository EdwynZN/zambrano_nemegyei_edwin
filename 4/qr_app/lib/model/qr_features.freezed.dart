// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_features.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QrFeatures {
  bool? get flash => throw _privateConstructorUsedError;
  CameraType? get camera => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QrFeaturesCopyWith<QrFeatures> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrFeaturesCopyWith<$Res> {
  factory $QrFeaturesCopyWith(
          QrFeatures value, $Res Function(QrFeatures) then) =
      _$QrFeaturesCopyWithImpl<$Res, QrFeatures>;
  @useResult
  $Res call({bool? flash, CameraType? camera});

  $CameraTypeCopyWith<$Res>? get camera;
}

/// @nodoc
class _$QrFeaturesCopyWithImpl<$Res, $Val extends QrFeatures>
    implements $QrFeaturesCopyWith<$Res> {
  _$QrFeaturesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flash = freezed,
    Object? camera = freezed,
  }) {
    return _then(_value.copyWith(
      flash: freezed == flash
          ? _value.flash
          : flash // ignore: cast_nullable_to_non_nullable
              as bool?,
      camera: freezed == camera
          ? _value.camera
          : camera // ignore: cast_nullable_to_non_nullable
              as CameraType?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CameraTypeCopyWith<$Res>? get camera {
    if (_value.camera == null) {
      return null;
    }

    return $CameraTypeCopyWith<$Res>(_value.camera!, (value) {
      return _then(_value.copyWith(camera: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QrFeaturesImplCopyWith<$Res>
    implements $QrFeaturesCopyWith<$Res> {
  factory _$$QrFeaturesImplCopyWith(
          _$QrFeaturesImpl value, $Res Function(_$QrFeaturesImpl) then) =
      __$$QrFeaturesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? flash, CameraType? camera});

  @override
  $CameraTypeCopyWith<$Res>? get camera;
}

/// @nodoc
class __$$QrFeaturesImplCopyWithImpl<$Res>
    extends _$QrFeaturesCopyWithImpl<$Res, _$QrFeaturesImpl>
    implements _$$QrFeaturesImplCopyWith<$Res> {
  __$$QrFeaturesImplCopyWithImpl(
      _$QrFeaturesImpl _value, $Res Function(_$QrFeaturesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flash = freezed,
    Object? camera = freezed,
  }) {
    return _then(_$QrFeaturesImpl(
      flash: freezed == flash
          ? _value.flash
          : flash // ignore: cast_nullable_to_non_nullable
              as bool?,
      camera: freezed == camera
          ? _value.camera
          : camera // ignore: cast_nullable_to_non_nullable
              as CameraType?,
    ));
  }
}

/// @nodoc

class _$QrFeaturesImpl implements _QrFeatures {
  _$QrFeaturesImpl({this.flash, this.camera});

  @override
  final bool? flash;
  @override
  final CameraType? camera;

  @override
  String toString() {
    return 'QrFeatures(flash: $flash, camera: $camera)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrFeaturesImpl &&
            (identical(other.flash, flash) || other.flash == flash) &&
            (identical(other.camera, camera) || other.camera == camera));
  }

  @override
  int get hashCode => Object.hash(runtimeType, flash, camera);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QrFeaturesImplCopyWith<_$QrFeaturesImpl> get copyWith =>
      __$$QrFeaturesImplCopyWithImpl<_$QrFeaturesImpl>(this, _$identity);
}

abstract class _QrFeatures implements QrFeatures {
  factory _QrFeatures({final bool? flash, final CameraType? camera}) =
      _$QrFeaturesImpl;

  @override
  bool? get flash;
  @override
  CameraType? get camera;
  @override
  @JsonKey(ignore: true)
  _$$QrFeaturesImplCopyWith<_$QrFeaturesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CameraType {
  bool get hasBoth => throw _privateConstructorUsedError;
  Camera get camera => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CameraTypeCopyWith<CameraType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraTypeCopyWith<$Res> {
  factory $CameraTypeCopyWith(
          CameraType value, $Res Function(CameraType) then) =
      _$CameraTypeCopyWithImpl<$Res, CameraType>;
  @useResult
  $Res call({bool hasBoth, Camera camera});
}

/// @nodoc
class _$CameraTypeCopyWithImpl<$Res, $Val extends CameraType>
    implements $CameraTypeCopyWith<$Res> {
  _$CameraTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasBoth = null,
    Object? camera = null,
  }) {
    return _then(_value.copyWith(
      hasBoth: null == hasBoth
          ? _value.hasBoth
          : hasBoth // ignore: cast_nullable_to_non_nullable
              as bool,
      camera: null == camera
          ? _value.camera
          : camera // ignore: cast_nullable_to_non_nullable
              as Camera,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CameraTypeImplCopyWith<$Res>
    implements $CameraTypeCopyWith<$Res> {
  factory _$$CameraTypeImplCopyWith(
          _$CameraTypeImpl value, $Res Function(_$CameraTypeImpl) then) =
      __$$CameraTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasBoth, Camera camera});
}

/// @nodoc
class __$$CameraTypeImplCopyWithImpl<$Res>
    extends _$CameraTypeCopyWithImpl<$Res, _$CameraTypeImpl>
    implements _$$CameraTypeImplCopyWith<$Res> {
  __$$CameraTypeImplCopyWithImpl(
      _$CameraTypeImpl _value, $Res Function(_$CameraTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasBoth = null,
    Object? camera = null,
  }) {
    return _then(_$CameraTypeImpl(
      hasBoth: null == hasBoth
          ? _value.hasBoth
          : hasBoth // ignore: cast_nullable_to_non_nullable
              as bool,
      camera: null == camera
          ? _value.camera
          : camera // ignore: cast_nullable_to_non_nullable
              as Camera,
    ));
  }
}

/// @nodoc

class _$CameraTypeImpl implements _CameraType {
  _$CameraTypeImpl({required this.hasBoth, required this.camera});

  @override
  final bool hasBoth;
  @override
  final Camera camera;

  @override
  String toString() {
    return 'CameraType(hasBoth: $hasBoth, camera: $camera)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraTypeImpl &&
            (identical(other.hasBoth, hasBoth) || other.hasBoth == hasBoth) &&
            (identical(other.camera, camera) || other.camera == camera));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasBoth, camera);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraTypeImplCopyWith<_$CameraTypeImpl> get copyWith =>
      __$$CameraTypeImplCopyWithImpl<_$CameraTypeImpl>(this, _$identity);
}

abstract class _CameraType implements CameraType {
  factory _CameraType(
      {required final bool hasBoth,
      required final Camera camera}) = _$CameraTypeImpl;

  @override
  bool get hasBoth;
  @override
  Camera get camera;
  @override
  @JsonKey(ignore: true)
  _$$CameraTypeImplCopyWith<_$CameraTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) cache,
    required TResult Function(String message) file,
    required TResult Function(String message) audio,
    required TResult Function(String message) validation,
    required TResult Function(String message) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? cache,
    TResult? Function(String message)? file,
    TResult? Function(String message)? audio,
    TResult? Function(String message)? validation,
    TResult? Function(String message)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? cache,
    TResult Function(String message)? file,
    TResult Function(String message)? audio,
    TResult Function(String message)? validation,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cache,
    required TResult Function(FileFailure value) file,
    required TResult Function(AudioFailure value) audio,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnknownFailure value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(FileFailure value)? file,
    TResult? Function(AudioFailure value)? audio,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnknownFailure value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cache,
    TResult Function(FileFailure value)? file,
    TResult Function(AudioFailure value)? audio,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CacheFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$CacheFailureImplCopyWith(
    _$CacheFailureImpl value,
    $Res Function(_$CacheFailureImpl) then,
  ) = __$$CacheFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CacheFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$CacheFailureImpl>
    implements _$$CacheFailureImplCopyWith<$Res> {
  __$$CacheFailureImplCopyWithImpl(
    _$CacheFailureImpl _value,
    $Res Function(_$CacheFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$CacheFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CacheFailureImpl implements CacheFailure {
  const _$CacheFailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.cache(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      __$$CacheFailureImplCopyWithImpl<_$CacheFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) cache,
    required TResult Function(String message) file,
    required TResult Function(String message) audio,
    required TResult Function(String message) validation,
    required TResult Function(String message) unknown,
  }) {
    return cache(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? cache,
    TResult? Function(String message)? file,
    TResult? Function(String message)? audio,
    TResult? Function(String message)? validation,
    TResult? Function(String message)? unknown,
  }) {
    return cache?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? cache,
    TResult Function(String message)? file,
    TResult Function(String message)? audio,
    TResult Function(String message)? validation,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cache,
    required TResult Function(FileFailure value) file,
    required TResult Function(AudioFailure value) audio,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return cache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(FileFailure value)? file,
    TResult? Function(AudioFailure value)? audio,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return cache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cache,
    TResult Function(FileFailure value)? file,
    TResult Function(AudioFailure value)? audio,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(this);
    }
    return orElse();
  }
}

abstract class CacheFailure implements Failure {
  const factory CacheFailure({required final String message}) =
      _$CacheFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FileFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$FileFailureImplCopyWith(
    _$FileFailureImpl value,
    $Res Function(_$FileFailureImpl) then,
  ) = __$$FileFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FileFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$FileFailureImpl>
    implements _$$FileFailureImplCopyWith<$Res> {
  __$$FileFailureImplCopyWithImpl(
    _$FileFailureImpl _value,
    $Res Function(_$FileFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$FileFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FileFailureImpl implements FileFailure {
  const _$FileFailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.file(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FileFailureImplCopyWith<_$FileFailureImpl> get copyWith =>
      __$$FileFailureImplCopyWithImpl<_$FileFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) cache,
    required TResult Function(String message) file,
    required TResult Function(String message) audio,
    required TResult Function(String message) validation,
    required TResult Function(String message) unknown,
  }) {
    return file(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? cache,
    TResult? Function(String message)? file,
    TResult? Function(String message)? audio,
    TResult? Function(String message)? validation,
    TResult? Function(String message)? unknown,
  }) {
    return file?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? cache,
    TResult Function(String message)? file,
    TResult Function(String message)? audio,
    TResult Function(String message)? validation,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cache,
    required TResult Function(FileFailure value) file,
    required TResult Function(AudioFailure value) audio,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return file(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(FileFailure value)? file,
    TResult? Function(AudioFailure value)? audio,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return file?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cache,
    TResult Function(FileFailure value)? file,
    TResult Function(AudioFailure value)? audio,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(this);
    }
    return orElse();
  }
}

abstract class FileFailure implements Failure {
  const factory FileFailure({required final String message}) =
      _$FileFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FileFailureImplCopyWith<_$FileFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AudioFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AudioFailureImplCopyWith(
    _$AudioFailureImpl value,
    $Res Function(_$AudioFailureImpl) then,
  ) = __$$AudioFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AudioFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AudioFailureImpl>
    implements _$$AudioFailureImplCopyWith<$Res> {
  __$$AudioFailureImplCopyWithImpl(
    _$AudioFailureImpl _value,
    $Res Function(_$AudioFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AudioFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AudioFailureImpl implements AudioFailure {
  const _$AudioFailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.audio(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioFailureImplCopyWith<_$AudioFailureImpl> get copyWith =>
      __$$AudioFailureImplCopyWithImpl<_$AudioFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) cache,
    required TResult Function(String message) file,
    required TResult Function(String message) audio,
    required TResult Function(String message) validation,
    required TResult Function(String message) unknown,
  }) {
    return audio(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? cache,
    TResult? Function(String message)? file,
    TResult? Function(String message)? audio,
    TResult? Function(String message)? validation,
    TResult? Function(String message)? unknown,
  }) {
    return audio?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? cache,
    TResult Function(String message)? file,
    TResult Function(String message)? audio,
    TResult Function(String message)? validation,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (audio != null) {
      return audio(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cache,
    required TResult Function(FileFailure value) file,
    required TResult Function(AudioFailure value) audio,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return audio(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(FileFailure value)? file,
    TResult? Function(AudioFailure value)? audio,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return audio?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cache,
    TResult Function(FileFailure value)? file,
    TResult Function(AudioFailure value)? audio,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (audio != null) {
      return audio(this);
    }
    return orElse();
  }
}

abstract class AudioFailure implements Failure {
  const factory AudioFailure({required final String message}) =
      _$AudioFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioFailureImplCopyWith<_$AudioFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(
    _$ValidationFailureImpl value,
    $Res Function(_$ValidationFailureImpl) then,
  ) = __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(
    _$ValidationFailureImpl _value,
    $Res Function(_$ValidationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ValidationFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ValidationFailureImpl implements ValidationFailure {
  const _$ValidationFailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.validation(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) cache,
    required TResult Function(String message) file,
    required TResult Function(String message) audio,
    required TResult Function(String message) validation,
    required TResult Function(String message) unknown,
  }) {
    return validation(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? cache,
    TResult? Function(String message)? file,
    TResult? Function(String message)? audio,
    TResult? Function(String message)? validation,
    TResult? Function(String message)? unknown,
  }) {
    return validation?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? cache,
    TResult Function(String message)? file,
    TResult Function(String message)? audio,
    TResult Function(String message)? validation,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cache,
    required TResult Function(FileFailure value) file,
    required TResult Function(AudioFailure value) audio,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(FileFailure value)? file,
    TResult? Function(AudioFailure value)? audio,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cache,
    TResult Function(FileFailure value)? file,
    TResult Function(AudioFailure value)? audio,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure implements Failure {
  const factory ValidationFailure({required final String message}) =
      _$ValidationFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(
    _$UnknownFailureImpl value,
    $Res Function(_$UnknownFailureImpl) then,
  ) = __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
    _$UnknownFailureImpl _value,
    $Res Function(_$UnknownFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UnknownFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) cache,
    required TResult Function(String message) file,
    required TResult Function(String message) audio,
    required TResult Function(String message) validation,
    required TResult Function(String message) unknown,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? cache,
    TResult? Function(String message)? file,
    TResult? Function(String message)? audio,
    TResult? Function(String message)? validation,
    TResult? Function(String message)? unknown,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? cache,
    TResult Function(String message)? file,
    TResult Function(String message)? audio,
    TResult Function(String message)? validation,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CacheFailure value) cache,
    required TResult Function(FileFailure value) file,
    required TResult Function(AudioFailure value) audio,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(FileFailure value)? file,
    TResult? Function(AudioFailure value)? audio,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CacheFailure value)? cache,
    TResult Function(FileFailure value)? file,
    TResult Function(AudioFailure value)? audio,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure implements Failure {
  const factory UnknownFailure({required final String message}) =
      _$UnknownFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sound_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SoundsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Sound> get sounds => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of SoundsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SoundsStateCopyWith<SoundsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoundsStateCopyWith<$Res> {
  factory $SoundsStateCopyWith(
    SoundsState value,
    $Res Function(SoundsState) then,
  ) = _$SoundsStateCopyWithImpl<$Res, SoundsState>;
  @useResult
  $Res call({bool isLoading, List<Sound> sounds, String? error});
}

/// @nodoc
class _$SoundsStateCopyWithImpl<$Res, $Val extends SoundsState>
    implements $SoundsStateCopyWith<$Res> {
  _$SoundsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SoundsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? sounds = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            sounds: null == sounds
                ? _value.sounds
                : sounds // ignore: cast_nullable_to_non_nullable
                      as List<Sound>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SoundsStateImplCopyWith<$Res>
    implements $SoundsStateCopyWith<$Res> {
  factory _$$SoundsStateImplCopyWith(
    _$SoundsStateImpl value,
    $Res Function(_$SoundsStateImpl) then,
  ) = __$$SoundsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<Sound> sounds, String? error});
}

/// @nodoc
class __$$SoundsStateImplCopyWithImpl<$Res>
    extends _$SoundsStateCopyWithImpl<$Res, _$SoundsStateImpl>
    implements _$$SoundsStateImplCopyWith<$Res> {
  __$$SoundsStateImplCopyWithImpl(
    _$SoundsStateImpl _value,
    $Res Function(_$SoundsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SoundsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? sounds = null,
    Object? error = freezed,
  }) {
    return _then(
      _$SoundsStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        sounds: null == sounds
            ? _value._sounds
            : sounds // ignore: cast_nullable_to_non_nullable
                  as List<Sound>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SoundsStateImpl implements _SoundsState {
  const _$SoundsStateImpl({
    this.isLoading = false,
    final List<Sound> sounds = const [],
    this.error,
  }) : _sounds = sounds;

  @override
  @JsonKey()
  final bool isLoading;
  final List<Sound> _sounds;
  @override
  @JsonKey()
  List<Sound> get sounds {
    if (_sounds is EqualUnmodifiableListView) return _sounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sounds);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'SoundsState(isLoading: $isLoading, sounds: $sounds, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoundsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._sounds, _sounds) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    const DeepCollectionEquality().hash(_sounds),
    error,
  );

  /// Create a copy of SoundsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SoundsStateImplCopyWith<_$SoundsStateImpl> get copyWith =>
      __$$SoundsStateImplCopyWithImpl<_$SoundsStateImpl>(this, _$identity);
}

abstract class _SoundsState implements SoundsState {
  const factory _SoundsState({
    final bool isLoading,
    final List<Sound> sounds,
    final String? error,
  }) = _$SoundsStateImpl;

  @override
  bool get isLoading;
  @override
  List<Sound> get sounds;
  @override
  String? get error;

  /// Create a copy of SoundsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SoundsStateImplCopyWith<_$SoundsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'login_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoginControllerStateTearOff {
  const _$LoginControllerStateTearOff();

  _LoginControllerState call(String? roomID) {
    return _LoginControllerState(
      roomID,
    );
  }
}

/// @nodoc
const $LoginControllerState = _$LoginControllerStateTearOff();

/// @nodoc
mixin _$LoginControllerState {
  String? get roomID => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginControllerStateCopyWith<LoginControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginControllerStateCopyWith<$Res> {
  factory $LoginControllerStateCopyWith(LoginControllerState value,
          $Res Function(LoginControllerState) then) =
      _$LoginControllerStateCopyWithImpl<$Res>;
  $Res call({String? roomID});
}

/// @nodoc
class _$LoginControllerStateCopyWithImpl<$Res>
    implements $LoginControllerStateCopyWith<$Res> {
  _$LoginControllerStateCopyWithImpl(this._value, this._then);

  final LoginControllerState _value;
  // ignore: unused_field
  final $Res Function(LoginControllerState) _then;

  @override
  $Res call({
    Object? roomID = freezed,
  }) {
    return _then(_value.copyWith(
      roomID: roomID == freezed
          ? _value.roomID
          : roomID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$LoginControllerStateCopyWith<$Res>
    implements $LoginControllerStateCopyWith<$Res> {
  factory _$LoginControllerStateCopyWith(_LoginControllerState value,
          $Res Function(_LoginControllerState) then) =
      __$LoginControllerStateCopyWithImpl<$Res>;
  @override
  $Res call({String? roomID});
}

/// @nodoc
class __$LoginControllerStateCopyWithImpl<$Res>
    extends _$LoginControllerStateCopyWithImpl<$Res>
    implements _$LoginControllerStateCopyWith<$Res> {
  __$LoginControllerStateCopyWithImpl(
      _LoginControllerState _value, $Res Function(_LoginControllerState) _then)
      : super(_value, (v) => _then(v as _LoginControllerState));

  @override
  _LoginControllerState get _value => super._value as _LoginControllerState;

  @override
  $Res call({
    Object? roomID = freezed,
  }) {
    return _then(_LoginControllerState(
      roomID == freezed
          ? _value.roomID
          : roomID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_LoginControllerState implements _LoginControllerState {
  const _$_LoginControllerState(this.roomID);

  @override
  final String? roomID;

  @override
  String toString() {
    return 'LoginControllerState(roomID: $roomID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoginControllerState &&
            (identical(other.roomID, roomID) ||
                const DeepCollectionEquality().equals(other.roomID, roomID)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(roomID);

  @JsonKey(ignore: true)
  @override
  _$LoginControllerStateCopyWith<_LoginControllerState> get copyWith =>
      __$LoginControllerStateCopyWithImpl<_LoginControllerState>(
          this, _$identity);
}

abstract class _LoginControllerState implements LoginControllerState {
  const factory _LoginControllerState(String? roomID) = _$_LoginControllerState;

  @override
  String? get roomID => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoginControllerStateCopyWith<_LoginControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

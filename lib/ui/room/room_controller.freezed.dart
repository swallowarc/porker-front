// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'room_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RoomControllerStateTearOff {
  const _$RoomControllerStateTearOff();

  _RoomControllerState call(String? roomID) {
    return _RoomControllerState(
      roomID,
    );
  }
}

/// @nodoc
const $RoomControllerState = _$RoomControllerStateTearOff();

/// @nodoc
mixin _$RoomControllerState {
  String? get roomID => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoomControllerStateCopyWith<RoomControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomControllerStateCopyWith<$Res> {
  factory $RoomControllerStateCopyWith(
          RoomControllerState value, $Res Function(RoomControllerState) then) =
      _$RoomControllerStateCopyWithImpl<$Res>;
  $Res call({String? roomID});
}

/// @nodoc
class _$RoomControllerStateCopyWithImpl<$Res>
    implements $RoomControllerStateCopyWith<$Res> {
  _$RoomControllerStateCopyWithImpl(this._value, this._then);

  final RoomControllerState _value;
  // ignore: unused_field
  final $Res Function(RoomControllerState) _then;

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
abstract class _$RoomControllerStateCopyWith<$Res>
    implements $RoomControllerStateCopyWith<$Res> {
  factory _$RoomControllerStateCopyWith(_RoomControllerState value,
          $Res Function(_RoomControllerState) then) =
      __$RoomControllerStateCopyWithImpl<$Res>;
  @override
  $Res call({String? roomID});
}

/// @nodoc
class __$RoomControllerStateCopyWithImpl<$Res>
    extends _$RoomControllerStateCopyWithImpl<$Res>
    implements _$RoomControllerStateCopyWith<$Res> {
  __$RoomControllerStateCopyWithImpl(
      _RoomControllerState _value, $Res Function(_RoomControllerState) _then)
      : super(_value, (v) => _then(v as _RoomControllerState));

  @override
  _RoomControllerState get _value => super._value as _RoomControllerState;

  @override
  $Res call({
    Object? roomID = freezed,
  }) {
    return _then(_RoomControllerState(
      roomID == freezed
          ? _value.roomID
          : roomID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_RoomControllerState implements _RoomControllerState {
  const _$_RoomControllerState(this.roomID);

  @override
  final String? roomID;

  @override
  String toString() {
    return 'RoomControllerState(roomID: $roomID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoomControllerState &&
            (identical(other.roomID, roomID) ||
                const DeepCollectionEquality().equals(other.roomID, roomID)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(roomID);

  @JsonKey(ignore: true)
  @override
  _$RoomControllerStateCopyWith<_RoomControllerState> get copyWith =>
      __$RoomControllerStateCopyWithImpl<_RoomControllerState>(
          this, _$identity);
}

abstract class _RoomControllerState implements RoomControllerState {
  const factory _RoomControllerState(String? roomID) = _$_RoomControllerState;

  @override
  String? get roomID => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RoomControllerStateCopyWith<_RoomControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

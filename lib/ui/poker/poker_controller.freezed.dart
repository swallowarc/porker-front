// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'poker_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PokerControllerStateTearOff {
  const _$PokerControllerStateTearOff();

  _PokerControllerState call(
      {required String roomID,
      required String masterLoginID,
      required RoomState roomState,
      required List<Ballot> ballots}) {
    return _PokerControllerState(
      roomID: roomID,
      masterLoginID: masterLoginID,
      roomState: roomState,
      ballots: ballots,
    );
  }
}

/// @nodoc
const $PokerControllerState = _$PokerControllerStateTearOff();

/// @nodoc
mixin _$PokerControllerState {
  String get roomID => throw _privateConstructorUsedError;
  String get masterLoginID => throw _privateConstructorUsedError;
  RoomState get roomState => throw _privateConstructorUsedError;
  List<Ballot> get ballots => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PokerControllerStateCopyWith<PokerControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokerControllerStateCopyWith<$Res> {
  factory $PokerControllerStateCopyWith(PokerControllerState value,
          $Res Function(PokerControllerState) then) =
      _$PokerControllerStateCopyWithImpl<$Res>;
  $Res call(
      {String roomID,
      String masterLoginID,
      RoomState roomState,
      List<Ballot> ballots});
}

/// @nodoc
class _$PokerControllerStateCopyWithImpl<$Res>
    implements $PokerControllerStateCopyWith<$Res> {
  _$PokerControllerStateCopyWithImpl(this._value, this._then);

  final PokerControllerState _value;
  // ignore: unused_field
  final $Res Function(PokerControllerState) _then;

  @override
  $Res call({
    Object? roomID = freezed,
    Object? masterLoginID = freezed,
    Object? roomState = freezed,
    Object? ballots = freezed,
  }) {
    return _then(_value.copyWith(
      roomID: roomID == freezed
          ? _value.roomID
          : roomID // ignore: cast_nullable_to_non_nullable
              as String,
      masterLoginID: masterLoginID == freezed
          ? _value.masterLoginID
          : masterLoginID // ignore: cast_nullable_to_non_nullable
              as String,
      roomState: roomState == freezed
          ? _value.roomState
          : roomState // ignore: cast_nullable_to_non_nullable
              as RoomState,
      ballots: ballots == freezed
          ? _value.ballots
          : ballots // ignore: cast_nullable_to_non_nullable
              as List<Ballot>,
    ));
  }
}

/// @nodoc
abstract class _$PokerControllerStateCopyWith<$Res>
    implements $PokerControllerStateCopyWith<$Res> {
  factory _$PokerControllerStateCopyWith(_PokerControllerState value,
          $Res Function(_PokerControllerState) then) =
      __$PokerControllerStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String roomID,
      String masterLoginID,
      RoomState roomState,
      List<Ballot> ballots});
}

/// @nodoc
class __$PokerControllerStateCopyWithImpl<$Res>
    extends _$PokerControllerStateCopyWithImpl<$Res>
    implements _$PokerControllerStateCopyWith<$Res> {
  __$PokerControllerStateCopyWithImpl(
      _PokerControllerState _value, $Res Function(_PokerControllerState) _then)
      : super(_value, (v) => _then(v as _PokerControllerState));

  @override
  _PokerControllerState get _value => super._value as _PokerControllerState;

  @override
  $Res call({
    Object? roomID = freezed,
    Object? masterLoginID = freezed,
    Object? roomState = freezed,
    Object? ballots = freezed,
  }) {
    return _then(_PokerControllerState(
      roomID: roomID == freezed
          ? _value.roomID
          : roomID // ignore: cast_nullable_to_non_nullable
              as String,
      masterLoginID: masterLoginID == freezed
          ? _value.masterLoginID
          : masterLoginID // ignore: cast_nullable_to_non_nullable
              as String,
      roomState: roomState == freezed
          ? _value.roomState
          : roomState // ignore: cast_nullable_to_non_nullable
              as RoomState,
      ballots: ballots == freezed
          ? _value.ballots
          : ballots // ignore: cast_nullable_to_non_nullable
              as List<Ballot>,
    ));
  }
}

/// @nodoc

class _$_PokerControllerState implements _PokerControllerState {
  const _$_PokerControllerState(
      {required this.roomID,
      required this.masterLoginID,
      required this.roomState,
      required this.ballots});

  @override
  final String roomID;
  @override
  final String masterLoginID;
  @override
  final RoomState roomState;
  @override
  final List<Ballot> ballots;

  @override
  String toString() {
    return 'PokerControllerState(roomID: $roomID, masterLoginID: $masterLoginID, roomState: $roomState, ballots: $ballots)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PokerControllerState &&
            (identical(other.roomID, roomID) ||
                const DeepCollectionEquality().equals(other.roomID, roomID)) &&
            (identical(other.masterLoginID, masterLoginID) ||
                const DeepCollectionEquality()
                    .equals(other.masterLoginID, masterLoginID)) &&
            (identical(other.roomState, roomState) ||
                const DeepCollectionEquality()
                    .equals(other.roomState, roomState)) &&
            (identical(other.ballots, ballots) ||
                const DeepCollectionEquality().equals(other.ballots, ballots)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(roomID) ^
      const DeepCollectionEquality().hash(masterLoginID) ^
      const DeepCollectionEquality().hash(roomState) ^
      const DeepCollectionEquality().hash(ballots);

  @JsonKey(ignore: true)
  @override
  _$PokerControllerStateCopyWith<_PokerControllerState> get copyWith =>
      __$PokerControllerStateCopyWithImpl<_PokerControllerState>(
          this, _$identity);
}

abstract class _PokerControllerState implements PokerControllerState {
  const factory _PokerControllerState(
      {required String roomID,
      required String masterLoginID,
      required RoomState roomState,
      required List<Ballot> ballots}) = _$_PokerControllerState;

  @override
  String get roomID => throw _privateConstructorUsedError;
  @override
  String get masterLoginID => throw _privateConstructorUsedError;
  @override
  RoomState get roomState => throw _privateConstructorUsedError;
  @override
  List<Ballot> get ballots => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PokerControllerStateCopyWith<_PokerControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

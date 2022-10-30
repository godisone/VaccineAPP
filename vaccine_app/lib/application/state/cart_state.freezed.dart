// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CartStateTearOff {
  const _$CartStateTearOff();

  _CartState call({Cart? cartModel, bool isLoading = false}) {
    return _CartState(
      cartModel: cartModel,
      isLoading: isLoading,
    );
  }
}

/// @nodoc
const $CartState = _$CartStateTearOff();

/// @nodoc
mixin _$CartState {
  Cart? get cartModel => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartStateCopyWith<CartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res>;
  $Res call({Cart? cartModel, bool isLoading});

  $CartCopyWith<$Res>? get cartModel;
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res> implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  final CartState _value;
  // ignore: unused_field
  final $Res Function(CartState) _then;

  @override
  $Res call({
    Object? cartModel = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      cartModel: cartModel == freezed
          ? _value.cartModel
          : cartModel // ignore: cast_nullable_to_non_nullable
              as Cart?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $CartCopyWith<$Res>? get cartModel {
    if (_value.cartModel == null) {
      return null;
    }

    return $CartCopyWith<$Res>(_value.cartModel!, (value) {
      return _then(_value.copyWith(cartModel: value));
    });
  }
}

/// @nodoc
abstract class _$CartStateCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory _$CartStateCopyWith(
          _CartState value, $Res Function(_CartState) then) =
      __$CartStateCopyWithImpl<$Res>;
  @override
  $Res call({Cart? cartModel, bool isLoading});

  @override
  $CartCopyWith<$Res>? get cartModel;
}

/// @nodoc
class __$CartStateCopyWithImpl<$Res> extends _$CartStateCopyWithImpl<$Res>
    implements _$CartStateCopyWith<$Res> {
  __$CartStateCopyWithImpl(_CartState _value, $Res Function(_CartState) _then)
      : super(_value, (v) => _then(v as _CartState));

  @override
  _CartState get _value => super._value as _CartState;

  @override
  $Res call({
    Object? cartModel = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_CartState(
      cartModel: cartModel == freezed
          ? _value.cartModel
          : cartModel // ignore: cast_nullable_to_non_nullable
              as Cart?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CartState implements _CartState {
  const _$_CartState({this.cartModel, this.isLoading = false});

  @override
  final Cart? cartModel;
  @JsonKey()
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'CartState(cartModel: $cartModel, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CartState &&
            const DeepCollectionEquality().equals(other.cartModel, cartModel) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(cartModel),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$CartStateCopyWith<_CartState> get copyWith =>
      __$CartStateCopyWithImpl<_CartState>(this, _$identity);
}

abstract class _CartState implements CartState {
  const factory _CartState({Cart? cartModel, bool isLoading}) = _$_CartState;

  @override
  Cart? get cartModel;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$CartStateCopyWith<_CartState> get copyWith =>
      throw _privateConstructorUsedError;
}

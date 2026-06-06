// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'film_with_user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FilmWithUserData {

 Film get film; FavoriteMovie? get userData;
/// Create a copy of FilmWithUserData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilmWithUserDataCopyWith<FilmWithUserData> get copyWith => _$FilmWithUserDataCopyWithImpl<FilmWithUserData>(this as FilmWithUserData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilmWithUserData&&(identical(other.film, film) || other.film == film)&&(identical(other.userData, userData) || other.userData == userData));
}


@override
int get hashCode => Object.hash(runtimeType,film,userData);

@override
String toString() {
  return 'FilmWithUserData(film: $film, userData: $userData)';
}


}

/// @nodoc
abstract mixin class $FilmWithUserDataCopyWith<$Res>  {
  factory $FilmWithUserDataCopyWith(FilmWithUserData value, $Res Function(FilmWithUserData) _then) = _$FilmWithUserDataCopyWithImpl;
@useResult
$Res call({
 Film film, FavoriteMovie? userData
});


$FilmCopyWith<$Res> get film;$FavoriteMovieCopyWith<$Res>? get userData;

}
/// @nodoc
class _$FilmWithUserDataCopyWithImpl<$Res>
    implements $FilmWithUserDataCopyWith<$Res> {
  _$FilmWithUserDataCopyWithImpl(this._self, this._then);

  final FilmWithUserData _self;
  final $Res Function(FilmWithUserData) _then;

/// Create a copy of FilmWithUserData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? film = null,Object? userData = freezed,}) {
  return _then(_self.copyWith(
film: null == film ? _self.film : film // ignore: cast_nullable_to_non_nullable
as Film,userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as FavoriteMovie?,
  ));
}
/// Create a copy of FilmWithUserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilmCopyWith<$Res> get film {
  
  return $FilmCopyWith<$Res>(_self.film, (value) {
    return _then(_self.copyWith(film: value));
  });
}/// Create a copy of FilmWithUserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavoriteMovieCopyWith<$Res>? get userData {
    if (_self.userData == null) {
    return null;
  }

  return $FavoriteMovieCopyWith<$Res>(_self.userData!, (value) {
    return _then(_self.copyWith(userData: value));
  });
}
}


/// Adds pattern-matching-related methods to [FilmWithUserData].
extension FilmWithUserDataPatterns on FilmWithUserData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilmWithUserData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilmWithUserData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilmWithUserData value)  $default,){
final _that = this;
switch (_that) {
case _FilmWithUserData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilmWithUserData value)?  $default,){
final _that = this;
switch (_that) {
case _FilmWithUserData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Film film,  FavoriteMovie? userData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilmWithUserData() when $default != null:
return $default(_that.film,_that.userData);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Film film,  FavoriteMovie? userData)  $default,) {final _that = this;
switch (_that) {
case _FilmWithUserData():
return $default(_that.film,_that.userData);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Film film,  FavoriteMovie? userData)?  $default,) {final _that = this;
switch (_that) {
case _FilmWithUserData() when $default != null:
return $default(_that.film,_that.userData);case _:
  return null;

}
}

}

/// @nodoc


class _FilmWithUserData implements FilmWithUserData {
  const _FilmWithUserData({required this.film, this.userData});
  

@override final  Film film;
@override final  FavoriteMovie? userData;

/// Create a copy of FilmWithUserData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilmWithUserDataCopyWith<_FilmWithUserData> get copyWith => __$FilmWithUserDataCopyWithImpl<_FilmWithUserData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilmWithUserData&&(identical(other.film, film) || other.film == film)&&(identical(other.userData, userData) || other.userData == userData));
}


@override
int get hashCode => Object.hash(runtimeType,film,userData);

@override
String toString() {
  return 'FilmWithUserData(film: $film, userData: $userData)';
}


}

/// @nodoc
abstract mixin class _$FilmWithUserDataCopyWith<$Res> implements $FilmWithUserDataCopyWith<$Res> {
  factory _$FilmWithUserDataCopyWith(_FilmWithUserData value, $Res Function(_FilmWithUserData) _then) = __$FilmWithUserDataCopyWithImpl;
@override @useResult
$Res call({
 Film film, FavoriteMovie? userData
});


@override $FilmCopyWith<$Res> get film;@override $FavoriteMovieCopyWith<$Res>? get userData;

}
/// @nodoc
class __$FilmWithUserDataCopyWithImpl<$Res>
    implements _$FilmWithUserDataCopyWith<$Res> {
  __$FilmWithUserDataCopyWithImpl(this._self, this._then);

  final _FilmWithUserData _self;
  final $Res Function(_FilmWithUserData) _then;

/// Create a copy of FilmWithUserData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? film = null,Object? userData = freezed,}) {
  return _then(_FilmWithUserData(
film: null == film ? _self.film : film // ignore: cast_nullable_to_non_nullable
as Film,userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as FavoriteMovie?,
  ));
}

/// Create a copy of FilmWithUserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilmCopyWith<$Res> get film {
  
  return $FilmCopyWith<$Res>(_self.film, (value) {
    return _then(_self.copyWith(film: value));
  });
}/// Create a copy of FilmWithUserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FavoriteMovieCopyWith<$Res>? get userData {
    if (_self.userData == null) {
    return null;
  }

  return $FavoriteMovieCopyWith<$Res>(_self.userData!, (value) {
    return _then(_self.copyWith(userData: value));
  });
}
}

// dart format on

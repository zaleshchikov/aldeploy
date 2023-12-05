// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_struct.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CartStruct> _$cartStructSerializer = new _$CartStructSerializer();

class _$CartStructSerializer implements StructuredSerializer<CartStruct> {
  @override
  final Iterable<Type> types = const [CartStruct, _$CartStruct];
  @override
  final String wireName = 'CartStruct';

  @override
  Iterable<Object?> serialize(Serializers serializers, CartStruct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'firestoreUtilData',
      serializers.serialize(object.firestoreUtilData,
          specifiedType: const FullType(FirestoreUtilData)),
    ];
    Object? value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.count;
    if (value != null) {
      result
        ..add('count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  CartStruct deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CartStructBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'firestoreUtilData':
          result.firestoreUtilData = serializers.deserialize(value,
                  specifiedType: const FullType(FirestoreUtilData))!
              as FirestoreUtilData;
          break;
      }
    }

    return result.build();
  }
}

class _$CartStruct extends CartStruct {
  @override
  final int? code;
  @override
  final String? name;
  @override
  final int? price;
  @override
  final String? image;
  @override
  final int? count;
  @override
  final FirestoreUtilData firestoreUtilData;

  factory _$CartStruct([void Function(CartStructBuilder)? updates]) =>
      (new CartStructBuilder()..update(updates))._build();

  _$CartStruct._(
      {this.code,
      this.name,
      this.price,
      this.image,
      this.count,
      required this.firestoreUtilData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        firestoreUtilData, r'CartStruct', 'firestoreUtilData');
  }

  @override
  CartStruct rebuild(void Function(CartStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CartStructBuilder toBuilder() => new CartStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CartStruct &&
        code == other.code &&
        name == other.name &&
        price == other.price &&
        image == other.image &&
        count == other.count &&
        firestoreUtilData == other.firestoreUtilData;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, code.hashCode), name.hashCode), price.hashCode),
                image.hashCode),
            count.hashCode),
        firestoreUtilData.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CartStruct')
          ..add('code', code)
          ..add('name', name)
          ..add('price', price)
          ..add('image', image)
          ..add('count', count)
          ..add('firestoreUtilData', firestoreUtilData))
        .toString();
  }
}

class CartStructBuilder implements Builder<CartStruct, CartStructBuilder> {
  _$CartStruct? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  FirestoreUtilData? _firestoreUtilData;
  FirestoreUtilData? get firestoreUtilData => _$this._firestoreUtilData;
  set firestoreUtilData(FirestoreUtilData? firestoreUtilData) =>
      _$this._firestoreUtilData = firestoreUtilData;

  CartStructBuilder() {
    CartStruct._initializeBuilder(this);
  }

  CartStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _name = $v.name;
      _price = $v.price;
      _image = $v.image;
      _count = $v.count;
      _firestoreUtilData = $v.firestoreUtilData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CartStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CartStruct;
  }

  @override
  void update(void Function(CartStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CartStruct build() => _build();

  _$CartStruct _build() {
    final _$result = _$v ??
        new _$CartStruct._(
            code: code,
            name: name,
            price: price,
            image: image,
            count: count,
            firestoreUtilData: BuiltValueNullFieldError.checkNotNull(
                firestoreUtilData, r'CartStruct', 'firestoreUtilData'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

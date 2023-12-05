// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shops_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ShopsRecord> _$shopsRecordSerializer = new _$ShopsRecordSerializer();

class _$ShopsRecordSerializer implements StructuredSerializer<ShopsRecord> {
  @override
  final Iterable<Type> types = const [ShopsRecord, _$ShopsRecord];
  @override
  final String wireName = 'ShopsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ShopsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.shopId;
    if (value != null) {
      result
        ..add('shopId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.locaion;
    if (value != null) {
      result
        ..add('locaion')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(LatLng)));
    }
    value = object.shopName;
    if (value != null) {
      result
        ..add('shopName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.token;
    if (value != null) {
      result
        ..add('token')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  ShopsRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ShopsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'shopId':
          result.shopId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'locaion':
          result.locaion = serializers.deserialize(value,
              specifiedType: const FullType(LatLng)) as LatLng?;
          break;
        case 'shopName':
          result.shopName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$ShopsRecord extends ShopsRecord {
  @override
  final String? shopId;
  @override
  final LatLng? locaion;
  @override
  final String? shopName;
  @override
  final String? token;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ShopsRecord([void Function(ShopsRecordBuilder)? updates]) =>
      (new ShopsRecordBuilder()..update(updates))._build();

  _$ShopsRecord._(
      {this.shopId, this.locaion, this.shopName, this.token, this.ffRef})
      : super._();

  @override
  ShopsRecord rebuild(void Function(ShopsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShopsRecordBuilder toBuilder() => new ShopsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShopsRecord &&
        shopId == other.shopId &&
        locaion == other.locaion &&
        shopName == other.shopName &&
        token == other.token &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, shopId.hashCode), locaion.hashCode),
                shopName.hashCode),
            token.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ShopsRecord')
          ..add('shopId', shopId)
          ..add('locaion', locaion)
          ..add('shopName', shopName)
          ..add('token', token)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ShopsRecordBuilder implements Builder<ShopsRecord, ShopsRecordBuilder> {
  _$ShopsRecord? _$v;

  String? _shopId;
  String? get shopId => _$this._shopId;
  set shopId(String? shopId) => _$this._shopId = shopId;

  LatLng? _locaion;
  LatLng? get locaion => _$this._locaion;
  set locaion(LatLng? locaion) => _$this._locaion = locaion;

  String? _shopName;
  String? get shopName => _$this._shopName;
  set shopName(String? shopName) => _$this._shopName = shopName;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ShopsRecordBuilder() {
    ShopsRecord._initializeBuilder(this);
  }

  ShopsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _shopId = $v.shopId;
      _locaion = $v.locaion;
      _shopName = $v.shopName;
      _token = $v.token;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShopsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ShopsRecord;
  }

  @override
  void update(void Function(ShopsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShopsRecord build() => _build();

  _$ShopsRecord _build() {
    final _$result = _$v ??
        new _$ShopsRecord._(
            shopId: shopId,
            locaion: locaion,
            shopName: shopName,
            token: token,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

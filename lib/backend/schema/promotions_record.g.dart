// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotions_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PromotionsRecord> _$promotionsRecordSerializer =
    new _$PromotionsRecordSerializer();

class _$PromotionsRecordSerializer
    implements StructuredSerializer<PromotionsRecord> {
  @override
  final Iterable<Type> types = const [PromotionsRecord, _$PromotionsRecord];
  @override
  final String wireName = 'PromotionsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, PromotionsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.cover;
    if (value != null) {
      result
        ..add('cover')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
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
  PromotionsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PromotionsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'cover':
          result.cover = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
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

class _$PromotionsRecord extends PromotionsRecord {
  @override
  final String? cover;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$PromotionsRecord(
          [void Function(PromotionsRecordBuilder)? updates]) =>
      (new PromotionsRecordBuilder()..update(updates))._build();

  _$PromotionsRecord._({this.cover, this.title, this.description, this.ffRef})
      : super._();

  @override
  PromotionsRecord rebuild(void Function(PromotionsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PromotionsRecordBuilder toBuilder() =>
      new PromotionsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PromotionsRecord &&
        cover == other.cover &&
        title == other.title &&
        description == other.description &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, cover.hashCode), title.hashCode), description.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PromotionsRecord')
          ..add('cover', cover)
          ..add('title', title)
          ..add('description', description)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class PromotionsRecordBuilder
    implements Builder<PromotionsRecord, PromotionsRecordBuilder> {
  _$PromotionsRecord? _$v;

  String? _cover;
  String? get cover => _$this._cover;
  set cover(String? cover) => _$this._cover = cover;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  PromotionsRecordBuilder() {
    PromotionsRecord._initializeBuilder(this);
  }

  PromotionsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cover = $v.cover;
      _title = $v.title;
      _description = $v.description;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PromotionsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PromotionsRecord;
  }

  @override
  void update(void Function(PromotionsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PromotionsRecord build() => _build();

  _$PromotionsRecord _build() {
    final _$result = _$v ??
        new _$PromotionsRecord._(
            cover: cover, title: title, description: description, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

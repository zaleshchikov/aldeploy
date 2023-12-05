// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DeleteAccountRecord> _$deleteAccountRecordSerializer =
    new _$DeleteAccountRecordSerializer();

class _$DeleteAccountRecordSerializer
    implements StructuredSerializer<DeleteAccountRecord> {
  @override
  final Iterable<Type> types = const [
    DeleteAccountRecord,
    _$DeleteAccountRecord
  ];
  @override
  final String wireName = 'DeleteAccountRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, DeleteAccountRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
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
  DeleteAccountRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DeleteAccountRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
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

class _$DeleteAccountRecord extends DeleteAccountRecord {
  @override
  final DocumentReference<Object?>? user;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$DeleteAccountRecord(
          [void Function(DeleteAccountRecordBuilder)? updates]) =>
      (new DeleteAccountRecordBuilder()..update(updates))._build();

  _$DeleteAccountRecord._({this.user, this.ffRef}) : super._();

  @override
  DeleteAccountRecord rebuild(
          void Function(DeleteAccountRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteAccountRecordBuilder toBuilder() =>
      new DeleteAccountRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteAccountRecord &&
        user == other.user &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, user.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteAccountRecord')
          ..add('user', user)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class DeleteAccountRecordBuilder
    implements Builder<DeleteAccountRecord, DeleteAccountRecordBuilder> {
  _$DeleteAccountRecord? _$v;

  DocumentReference<Object?>? _user;
  DocumentReference<Object?>? get user => _$this._user;
  set user(DocumentReference<Object?>? user) => _$this._user = user;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  DeleteAccountRecordBuilder() {
    DeleteAccountRecord._initializeBuilder(this);
  }

  DeleteAccountRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteAccountRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeleteAccountRecord;
  }

  @override
  void update(void Function(DeleteAccountRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteAccountRecord build() => _build();

  _$DeleteAccountRecord _build() {
    final _$result =
        _$v ?? new _$DeleteAccountRecord._(user: user, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'delete_account_record.g.dart';

abstract class DeleteAccountRecord
    implements Built<DeleteAccountRecord, DeleteAccountRecordBuilder> {
  static Serializer<DeleteAccountRecord> get serializer =>
      _$deleteAccountRecordSerializer;

  DocumentReference? get user;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(DeleteAccountRecordBuilder builder) => builder;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('deleteAccount');

  static Stream<DeleteAccountRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<DeleteAccountRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  DeleteAccountRecord._();
  factory DeleteAccountRecord(
          [void Function(DeleteAccountRecordBuilder) updates]) =
      _$DeleteAccountRecord;

  static DeleteAccountRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createDeleteAccountRecordData({
  DocumentReference? user,
}) {
  final firestoreData = serializers.toFirestore(
    DeleteAccountRecord.serializer,
    DeleteAccountRecord(
      (d) => d..user = user,
    ),
  );

  return firestoreData;
}

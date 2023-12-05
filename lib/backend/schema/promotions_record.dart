import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'promotions_record.g.dart';

abstract class PromotionsRecord
    implements Built<PromotionsRecord, PromotionsRecordBuilder> {
  static Serializer<PromotionsRecord> get serializer =>
      _$promotionsRecordSerializer;

  String? get cover;

  String? get title;

  String? get description;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(PromotionsRecordBuilder builder) => builder
    ..cover = ''
    ..title = ''
    ..description = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('promotions');

  static Stream<PromotionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<PromotionsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  PromotionsRecord._();
  factory PromotionsRecord([void Function(PromotionsRecordBuilder) updates]) =
      _$PromotionsRecord;

  static PromotionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createPromotionsRecordData({
  String? cover,
  String? title,
  String? description,
}) {
  final firestoreData = serializers.toFirestore(
    PromotionsRecord.serializer,
    PromotionsRecord(
      (p) => p
        ..cover = cover
        ..title = title
        ..description = description,
    ),
  );

  return firestoreData;
}

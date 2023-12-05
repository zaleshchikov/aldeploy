import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'orders_record.g.dart';

abstract class OrdersRecord
    implements Built<OrdersRecord, OrdersRecordBuilder> {
  static Serializer<OrdersRecord> get serializer => _$ordersRecordSerializer;

  int? get id;

  String? get status;

  String? get typed;

  DateTime? get datetime;

  DocumentReference? get user;

  double? get summa;

  int? get count;

  String? get shop;

  bool? get push;

  @BuiltValueField(wireName: 'Products')
  BuiltList<CartStruct>? get products;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(OrdersRecordBuilder builder) => builder
    ..id = 0
    ..status = ''
    ..summa = 0.0
    ..count = 0
    ..shop = ''
    ..typed = ''
    ..push = false
    ..products = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<OrdersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  OrdersRecord._();
  factory OrdersRecord([void Function(OrdersRecordBuilder) updates]) =
      _$OrdersRecord;

  static OrdersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createOrdersRecordData({
  int? id,
  String? status,
  DateTime? datetime,
  DocumentReference? user,
  int? count,
  double? summa,
  String? shop,
  String? typed,
  bool? push,
}) {
  final firestoreData = serializers.toFirestore(
    OrdersRecord.serializer,
    OrdersRecord(
      (o) => o
        ..id = id
        ..status = status
        ..typed = typed
        ..datetime = datetime
        ..user = user
        ..count = count
        ..summa = summa
        ..shop = shop
        ..push = push
        ..products = null,
    ),
  );

  return firestoreData;
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate().toLocal();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date.toUtc());
}

class TimestampConverterWithNull
    implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverterWithNull();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate().toLocal();
  }

  @override
  Timestamp? toJson(DateTime? date) =>
      date == null ? null : Timestamp.fromDate(date.toUtc());
}

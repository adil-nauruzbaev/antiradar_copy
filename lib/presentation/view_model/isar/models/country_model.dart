// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:isar/isar.dart' as isar;
import 'package:isar/isar.dart';

part 'country_model.g.dart';

@isar.Collection()
class CountryModel {
  isar.Id id = isar.Isar.autoIncrement;

  final String country;
  final DateTime createdAt;

  final double? long;
  final double? lat;
  final String? type;
  final double? speed;
  @Index(unique: true, replace: true)
  final String? uid;

  CountryModel({
    required this.country,
    required this.createdAt,
    this.long,
    this.lat,
    this.type,
    this.speed,
    this.uid,
  });

  factory CountryModel.fromFirestore(
      firestore.DocumentSnapshot<Map<String, dynamic>> doc, String country) {
    final data = doc.data()!;
    // print('$data\n');
    return CountryModel(
      uid: doc.id,
      country: country,
      createdAt: (data['created_at'] as firestore.Timestamp).toDate(),
      long: double.tryParse((data['long'] ?? '0').toString()),
      lat: double.tryParse((data['lat'] ?? '0').toString()),
      type: data['type'] as String?,
      speed: double.tryParse((data['speed'] ?? '0').toString()),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'created_at': firestore.Timestamp.fromDate(createdAt),
      'long': long,
      'lat': lat,
      'type': type,
      'speed': speed,
    };
  }

  @override
  bool operator ==(covariant CountryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.country == country &&
        other.createdAt == createdAt &&
        other.long == long &&
        other.lat == lat &&
        other.type == type &&
        other.speed == speed &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        country.hashCode ^
        createdAt.hashCode ^
        long.hashCode ^
        lat.hashCode ^
        type.hashCode ^
        speed.hashCode ^
        uid.hashCode;
  }
}

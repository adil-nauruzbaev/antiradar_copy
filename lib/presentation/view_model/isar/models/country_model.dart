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

  CountryModel({
    required this.country,
    required this.createdAt,
    this.long,
    this.lat,
    this.type,
    this.speed,
  });

  factory CountryModel.fromFirestore(
      firestore.DocumentSnapshot<Map<String, dynamic>> doc, String country) {
    final data = doc.data()!;
    return CountryModel(
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
      'long': long,
      'lat': lat,
      'type': type,
      'speed': speed,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:isar/isar.dart' as isar;
import 'package:isar/isar.dart';

part 'argentina_model.g.dart';

@isar.Collection()
class ArgentinaModel {
  isar.Id id = isar.Isar.autoIncrement;

  late double long;
  late double lat;
  late String type;
  late String speed;

  ArgentinaModel();

  factory ArgentinaModel.fromFirestore(
      firestore.DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ArgentinaModel()
      ..long = data['long'] as double
      ..lat = data['lat'] as double
      ..type = data['type'] as String
      ..speed = data['speed'] as String;
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

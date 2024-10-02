// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart' as isar;
import 'package:isar/isar.dart';

part 'user_model.g.dart';

@isar.Collection()
class UserModel {
  isar.Id? id = isar.Isar.autoIncrement;
  final String? country;
  final DateTime createdAt;
  final String email;
  final DateTime? expiredAt;
  final DateTime? subAt;
  final bool subscription;
  UserModel({
    this.id,
    this.country,
    required this.createdAt,
    required this.email,
    this.expiredAt,
    this.subAt,
    required this.subscription,
  });

  UserModel copyWith({
    isar.Id? id,
    String? country,
    DateTime? createdAt,
    String? email,
    DateTime? expiredAt,
    DateTime? subAt,
    bool? subscription,
  }) {
    return UserModel(
      id: id ?? this.id,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      expiredAt: expiredAt ?? this.expiredAt,
      subAt: subAt ?? this.subAt,
      subscription: subscription ?? this.subscription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'created_at': createdAt.millisecondsSinceEpoch,
      'email': email,
      'expired_at': expiredAt?.millisecondsSinceEpoch,
      'sub_at': subAt?.millisecondsSinceEpoch,
      'subscription': subscription,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      country: map['country'] as String?,
      createdAt: (map['created_at'] as Timestamp).toDate(),
      email: map['email'] as String,
      expiredAt: map['expired_at'] != null
          ? (map['expired_at'] as Timestamp).toDate()
          : null,
      subAt:
          map['sub_at'] != null ? (map['sub_at'] as Timestamp).toDate() : null,
      subscription: map['subscription'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, country: $country, createdAt: $createdAt, email: $email, expiredAt: $expiredAt, subAt: $subAt, subscription: $subscription)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.country == country &&
        other.createdAt == createdAt &&
        other.email == email &&
        other.expiredAt == expiredAt &&
        other.subAt == subAt &&
        other.subscription == subscription;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        country.hashCode ^
        createdAt.hashCode ^
        email.hashCode ^
        expiredAt.hashCode ^
        subAt.hashCode ^
        subscription.hashCode;
  }
}

// UserModel({
  //   required this.email,
  //   required this.subscription,
  //   required this.country,
  //   required this.createdAt,
  //   this.expiredAt,
  //   this.subAt,
  // });

  // factory UserModel.fromFirestore(
  //     firestore.DocumentSnapshot<Map<String, dynamic>> doc) {
  //   final data = doc.data()!;
  //   return UserModel(
  //     country: data['country'],
  //     createdAt: DateTime.fromMicrosecondsSinceEpoch(data['created_at']),
  //     email: data['email'],
  //     expiredAt: DateTime.fromMicrosecondsSinceEpoch(data['expired_at']),
  //     subAt: DateTime.fromMicrosecondsSinceEpoch(data['sub_at']),
  //     subscription: data['subscription'],
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     'country': country,
  //     'createdAt': createdAt,
  //     'email': email,
  //     'expiredAt': expiredAt,
  //   };
  // }

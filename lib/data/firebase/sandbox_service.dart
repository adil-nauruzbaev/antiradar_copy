import 'package:antiradar/presentation/view_model/radar/models/sandbox_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sandboxProvider = Provider((ref) => SandboxService());

final selectedSpeedProvider = StateProvider<int?>((ref) => null);

class SandboxService {
  final CollectionReference _sandboxCollection = FirebaseFirestore.instance.collection('sandbox');

  Future<void> addSandboxData(SandboxModel data) async {
    try {
      await _sandboxCollection.add(data.toMap());
    } catch (e) {
      print('Failed to add data: $e');
    }
  }
  Future<List<SandboxModel>> getAllSandboxData() async {
    // Предполагается, что у вас есть логика для получения данных из базы данных, например Firestore или Isar
    final querySnapshot = await FirebaseFirestore.instance.collection('sandbox').get();
    
    return querySnapshot.docs.map((doc) {
      return SandboxModel(
        country: doc['country'],
        lat: doc['lat'],
        long: doc['long'],
        speed: doc['speed'],
        type: doc['type'],
      );
    }).toList();
  }
}
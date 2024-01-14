import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addBuilding(String binaAdi, String hasarDurumu, double lat, double long) async {
    await _firestore.collection('binalar').add({
      'binaAdi': binaAdi,
      'hasarDurumu': hasarDurumu,
      'latitude': lat,
      'longitude': long,
    });
  }

  
  static Future<List<Map<String, dynamic>>> getBuildings() async {
    List<Map<String, dynamic>> buildings = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('buildings').get();
      buildings = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Hata: $e');
    }
    return buildings;
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'firebase_service.dart';

class BinaEklemeSayfasi extends StatefulWidget {
  final LatLng secilenKonum;
  final Function(String, String) onBinaEklendi;

  BinaEklemeSayfasi({required this.secilenKonum, required this.onBinaEklendi});

  @override
  _BinaEklemeSayfasiState createState() => _BinaEklemeSayfasiState();
}

class _BinaEklemeSayfasiState extends State<BinaEklemeSayfasi> {
  String binaAdi = '';
  String hasarDurumu = 'Hafif';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bina Ekleme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bina Adı:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  binaAdi = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Bina Adı',
              ),
            ),
            SizedBox(height: 16),
            Text('Hasar Durumu:'),
            DropdownButton<String>(
              value: hasarDurumu,
              onChanged: (String? newValue) {
                setState(() {
                  hasarDurumu = newValue!;
                });
              },
              items: <String>['Hafif', 'Orta', 'Ağır']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Hasar Durumu Seçin'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FirebaseService.addBuilding(binaAdi, hasarDurumu, widget.secilenKonum.latitude, widget.secilenKonum.longitude);
                widget.onBinaEklendi(binaAdi, hasarDurumu);
                Navigator.of(context).pop(); 
              },
              child: Text('Bina Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}

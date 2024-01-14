import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HaritaSayfasi extends StatefulWidget {
  @override
  _HaritaSayfasiState createState() => _HaritaSayfasiState();
}

class _HaritaSayfasiState extends State<HaritaSayfasi> {
  late GoogleMapController _controller;
  Set<Polygon> _polygons = {};
  Set<Marker> _markers = {};
  List<LatLng> _selectedLocations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harita'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(38.3321, 38.3420),  // Battalgazi'nin koordinatları
          zoom: 13,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        polygons: _polygons,
        markers: _markers,
        onTap: _onMapTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedLocations.isNotEmpty) {
            _showBuildingSelectionDialog();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Lütfen en az bir konum seçin.'),
              ),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showBuildingSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bina Seçimi'),
          content: Column(
            children: [
              for (int i = 0; i < _selectedLocations.length; i++)
                ListTile(
                  title: Text('Konum $i'),
                  onTap: () {
                    if (_selectedLocations.length > i) {
                      _showMarkerDialog(_selectedLocations[i]);
                    }
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMarkerDialog(LatLng selectedLocation) async {
    String binaAdi = '';
    String hasarDurumu = 'Hafif';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bina Ekleme'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bina Adı:'),
              TextField(
                onChanged: (value) {
                  binaAdi = value;
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
                  hasarDurumu = newValue!;
                },
                items: <String>['Hafif', 'Orta', 'Ağır']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _addBuildingPolygon(binaAdi, hasarDurumu, selectedLocation);
                  Navigator.of(context).pop();
                },
                child: Text('Bina Ekle'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addBuildingPolygon(String binaAdi, String hasarDurumu, LatLng konum) {
    List<LatLng> polygonPoints = _calculatePolygonPoints(konum);

    Polygon polygon = Polygon(
      polygonId: PolygonId(binaAdi),
      points: polygonPoints,
      fillColor: _getPolygonFillColor(hasarDurumu),
    );

    Marker marker = Marker(
      markerId: MarkerId(binaAdi),
      position: konum,
      infoWindow: InfoWindow(title: binaAdi),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        _getMarkerColor(hasarDurumu),
      ),
    );

    setState(() {
      _polygons.add(polygon);
      _markers.add(marker);
      _selectedLocations.clear();
    });

    FirebaseService.addBuilding(binaAdi, hasarDurumu, konum.latitude, konum.longitude);
  }

  List<LatLng> _calculatePolygonPoints(LatLng konum) {
    return [
      LatLng(konum.latitude + 0.001, konum.longitude - 0.001),
      LatLng(konum.latitude - 0.001, konum.longitude - 0.001),
      LatLng(konum.latitude - 0.001, konum.longitude + 0.001),
      LatLng(konum.latitude + 0.001, konum.longitude + 0.001),
    ];
  }

  Color _getPolygonFillColor(String hasarDurumu) {
    switch (hasarDurumu) {
      case 'Hafif':
        return Colors.green.withOpacity(0.5);
      case 'Orta':
        return Colors.orange.withOpacity(0.5);
      case 'Ağır':
        return Colors.red.withOpacity(0.5);
      default:
        return Colors.blue.withOpacity(0.5);
    }
  }

  double _getMarkerColor(String hasarDurumu) {
    switch (hasarDurumu) {
      case 'Hafif':
        return BitmapDescriptor.hueGreen;
      case 'Orta':
        return BitmapDescriptor.hueOrange;
      case 'Ağır':
        return BitmapDescriptor.hueRed;
      default:
        return BitmapDescriptor.hueAzure;
    }
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocations.add(location);
    });
  }
}

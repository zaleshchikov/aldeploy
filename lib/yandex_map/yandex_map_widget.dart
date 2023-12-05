import 'package:alcoapp_main/backend/backend.dart';
import 'package:alcoapp_main/main.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class MapScreen extends StatefulWidget {

  double lat;
  double long;

  List<ShopsRecord?>? mapObjects;
  MapScreen(this.mapObjects, this.lat, this.long);
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _mapController;


  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  List<MapObject> mapObjects = [];

  @override
  Widget build(BuildContext context) {

    for( var item in widget.mapObjects!){
      print(item!.shopName);
      mapObjects.add(
        new PlacemarkMapObject(
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                'assets/images/Group_19.png',
              ),
              scale: 0.5,
            ),

          ),
          mapId: MapObjectId('${item!.shopName}'),
          point: Point(latitude: item.locaion!.latitude, longitude: item.locaion!.longitude),
          opacity: 1,

          ));
    }

    return YandexMap(
      onMapCreated: (controller) async {
        _mapController = controller;
        // приближаем вид карты ближе к Европе
        await _mapController.moveCamera(
          CameraUpdate.newCameraPosition(
             CameraPosition(
              target: Point(
                latitude: widget.lat,
                longitude: widget.long,
              ),
              zoom: 12,
            ),
          ),
        );
      },
      mapObjects: mapObjects,
    );
  }
}

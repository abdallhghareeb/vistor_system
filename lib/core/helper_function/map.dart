

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<String> getStreetText(LatLng latLng)async{
  String des = '';
  List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude
      ,latLng.longitude);


  if (placemarks.isNotEmpty) {
    des = placemarks[0].street??"";
  }
  return des;
}
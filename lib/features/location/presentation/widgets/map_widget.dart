import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../provider/location_provider.dart';
import 'marker_widget.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  CameraPosition? currentPos;
  bool _isMapReady = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocationProvider>(context, listen: true);

    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            provider.setDataController(controller);
            Future.delayed(const Duration(milliseconds: 800), () {
              setState(() {
                _isMapReady = true;
              });
              if (provider.lat != null && provider.lng != null) {
                provider.setMarker(context);
              }
            });
          },
          markers: provider.markers,
          zoomControlsEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(provider.lat ?? 24.7136, provider.lng ?? 46.6753), // الرياض كموقع افتراضي
            zoom: 14.0, // تخفيض الزوم قليلاً
          ),
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
        ),

        // عنصر MarkerWidget مخفي ولكن جاهز للاستخدام
        Positioned(
          left: -1000, // إبعاده خارج الشاشة
          child: MarkerWidget(markerKey: provider.markerKey),
        ),
      ],
    );
  }
}
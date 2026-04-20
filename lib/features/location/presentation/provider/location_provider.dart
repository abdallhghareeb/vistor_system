import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/dialog/snack_bar.dart';
import '../../../../core/helper_function/loading.dart';
import '../../../../core/helper_function/location.dart';
import '../../../../core/helper_function/map.dart';
import '../../../../core/helper_function/navigation.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../../../settings/presentation/provider/settings_provider.dart';

class LocationProvider extends ChangeNotifier {
  bool expanded = false;
  CameraPosition? currentPos;
  GoogleMapController? controller;
  double? lat, lng;
  String description = '';
  Set<Marker> markers = {};
  bool _isCreatingMarker = false;
  void resetData() {
    currentPos = null;
    controller = null;
    description = '';
    expanded = false;
    markers.clear();
    notifyListeners();
  }

  Future getDescription() async {
    description = await getStreetText(LatLng(lat ?? 0, lng ?? 0));
    notifyListeners();
  }

  void setDataController(GoogleMapController controller) {
    this.controller = controller;
  }

  void setData(LatLng latLng, BuildContext context) {
    lat = latLng.latitude;
    lng = latLng.longitude;
    setMarker(context);
  }

  bool isSaveWidget = false;

  void isSaveToggle() {
    isSaveWidget = !isSaveWidget;
    notifyListeners();
  }

  void rebuild() {
    notifyListeners();
  }

  BuildContext? globalContext;

  Future<void> setMarker(BuildContext context) async {
    if (_isCreatingMarker) return;

    _isCreatingMarker = true;
    LatLng latLng = LatLng(lat ?? 0, lng ?? 0);

    try {
      if (controller != null) {
        await controller!.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
      }
      markers.clear();
      await Future.delayed(const Duration(milliseconds: 100));
      final icon = await widgetToBitmap();

      final marker = Marker(
        markerId: const MarkerId('custom'),
        position: latLng,
        icon: icon,
        anchor: const Offset(0.5, 0.5),
      );
      markers.add(marker);
      await getDescription();
    } catch (e) {
      debugPrint("Error creating custom marker: $e");
      markers.add(
        Marker(
          markerId: const MarkerId('default'),
          position: latLng,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    } finally {
      _isCreatingMarker = false;
      notifyListeners();
    }
  }

  GlobalKey markerKey = GlobalKey();

  Future<BitmapDescriptor> widgetToBitmap() async {
    await Future.delayed(const Duration(milliseconds: 100));
    await WidgetsBinding.instance.endOfFrame;
    await Future.delayed(const Duration(milliseconds: 50));
    final boundary = markerKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      throw Exception("Widget boundary not found");
    }
    for (int i = 0; i < 3; i++) {
      try {
        final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
        final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

        if (byteData != null) {
          final Uint8List pngBytes = byteData.buffer.asUint8List();
          return BitmapDescriptor.bytes(pngBytes);
        }

        await Future.delayed(const Duration(milliseconds: 50));
      } catch (e) {
        if (i == 2) rethrow;
        await Future.delayed(const Duration(milliseconds: 50));
      }
    }

    throw Exception("Failed to create marker after multiple attempts");
  }

  void triggerExtend() {
    if (expanded) {
      disAbleExtend();
    } else {
      enableExtend();
    }
  }

  void enableExtend() {
    expanded = true;
    notifyListeners();
  }

  void disAbleExtend() {
    expanded = false;
    notifyListeners();
  }

  bool? didInsideZone(){
    if(lat!=null && lng!=null){
      SettingsProvider settingsProvider =Provider.of(Constants.globalContext(),listen: false);
      bool insideAnyZone = settingsProvider.zones.any((z) {
        return isInsideZone(
          myLat: lat??0, myLng: lng??0, zoneLat: z.latitude.toDouble(),
          zoneLng: z.longitude.toDouble(), radiusInMeters: z.radius.toDouble(),
        );
      });

      if(insideAnyZone){
        return true;
      }else{
        return false;
      }
    }else{
      return null;
    }
  }

  bool isInsideZone({
    required double myLat,
    required double myLng,
    required double zoneLat,
    required double zoneLng,
    required double radiusInMeters,
  }) {
    final distance = calculateDistanceInMeters(myLat, myLng, zoneLat, zoneLng);
    return distance <= radiusInMeters;
  }

  double _degToRad(double deg) => deg * (pi / 180);

  double calculateDistanceInMeters(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000;
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) + cos(_degToRad(lat1)) * cos(_degToRad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  void getCurrentLocation({bool fromSplash=false})async{
    if(!fromSplash)loading();
    LatLng latLng= await determinePosition();
    if(!fromSplash) navPop();
    if(isMockLocation){
      showToast(color: Color(0xffEC5454),LanguageProvider.translate("error", "try_again_gps"),
          title:LanguageProvider.translate("error", "fake_gps"), );
    }else {
      setData(latLng,Constants.globalContext());
    }
  }
}
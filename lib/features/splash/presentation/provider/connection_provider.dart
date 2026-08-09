// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/constants/constants.dart';
// import '../../../main/presentation/provider/main_page_provider.dart';
//
// class ConnectivityProvider extends ChangeNotifier {
//   final Connectivity _connectivity = Connectivity();
//   bool _hasConnection = true;
//
//   bool get hasConnection => _hasConnection;
//   void init() {
//     _connectivity.onConnectivityChanged.listen((results) {
//       final connected = !results.contains(ConnectivityResult.none);
//       _updateConnection(connected);
//     });
//
//     checkConnection();
//   }
//
//   Future<void> checkConnection() async {
//     final result = await _connectivity.checkConnectivity();
//     final connected = !result.contains(ConnectivityResult.none);
//     _updateConnection(connected);
//   }
//
//   void _updateConnection(bool connected) {
//     if (_hasConnection != connected) {
//       _hasConnection = connected;
//       MainProvider mainProvider= Provider.of<MainProvider>(Constants.globalContext(),listen: false);
//       mainProvider.changeInternetStatus();
//       notifyListeners();
//     }
//   }
//
//
//
//   bool isGpsEnabled = false;
//   Timer? _timer;
//
//   void startListening() {
//     _checkGps();
//
//     _timer ??= Timer.periodic(
//       const Duration(seconds: 1),
//           (_) => _checkGps(),
//     );
//   }
//
//   void stopListening() {
//     _timer?.cancel();
//     _timer = null;
//   }
//
//   Future<void> _checkGps() async {
//     final enabled = await Geolocator.isLocationServiceEnabled();
//     if (enabled != isGpsEnabled) {
//       isGpsEnabled = enabled;
//       MainProvider mainProvider= Provider.of<MainProvider>(Constants.globalContext(),listen: false);
//       mainProvider.changeGpsStatus();
//
//       notifyListeners();
//     }
//   }
//
//   @override
//   void dispose() {
//     stopListening();
//     super.dispose();
//   }
//
//
// }
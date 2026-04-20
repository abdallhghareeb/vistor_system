import 'package:flutter/material.dart';
import '../widgets/bottom_location_sheet_widget.dart';
import '../widgets/map_widget.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key,});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const MapWidget(),
        floatingActionButton: const BottomMapSheetWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

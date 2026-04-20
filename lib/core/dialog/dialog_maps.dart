import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

openDialogMapsSheet(double lat, double long) async {
  try {
    final coords = Coords(lat, long);
    const title = "Order Address";
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: Constants.globalContext(),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Wrap(
            children: <Widget>[
              for (var map in availableMaps)
                ListTile(
                  onTap: () => map.showMarker(coords: coords, title: title),
                  title: Text(map.mapName),
                  leading: SvgPicture.asset(map.icon, height: 10.h, width: 10.h),
                ),
            ],
          ),
        );
      },
    );
  } catch (e) {}
}

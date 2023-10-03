
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:flutter_tahaddi/localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../localizations.dart';

class LocationClass{
  Future<Map?> permission(context) async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      Map value=await defaultLocation();
      return value;
    } else if (status.isDenied) {
      Map value=await defaultLocation();
      return value;
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(AppLocalizations.of(context)!.locationPermission),
            content: Text(AppLocalizations.of(context)!
                .thislocationPicturesUploadImage),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(AppLocalizations.of(context)!.deny),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context)!.setting),
                  onPressed: () {
                    Navigator.of(context).pop();
                    openAppSettings();
                  }),
            ],
          ));
    }
    return null;
  }
  Future<Map> defaultLocation() async {
    late Map address;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
       address= await getAddressFromLatLng(LatLng(value.latitude,value.longitude));
    });

    return address;
  }
  Future<Map> getAddressFromLatLng(LatLng lac) async {
      List<Placemark> p =
      await placemarkFromCoordinates(lac.latitude, lac.longitude);
      Placemark placeMark = p[0];
      String? administrativeArea = placeMark.administrativeArea;
      String? country = placeMark.country;
      print("$administrativeArea$country");
      Map address = {
        "country": country,
        "city": administrativeArea,
      };
      return address;

  }
}
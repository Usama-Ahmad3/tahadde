import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/modelClass/territory_model_class.dart';

import '../constant.dart';
import '../homeFile/routingConstant.dart';
import '../homeFile/utility.dart';
import '../modelClass/territory_model_class.dart';
import '../network/network_calls.dart';
import 'location_class.dart';

class PermissionPrimingScreen extends StatefulWidget {
  const PermissionPrimingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PermissionPrimingScreenState();
  }
}

class _PermissionPrimingScreenState extends State<PermissionPrimingScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String _mobileImage;
  final NetworkCalls _networkCalls = NetworkCalls();
  TerritoryModelClass? _territoryData;
  bool _isLoading = true;
  loadTerritories() async {
    await _networkCalls.getTerritory(
      onSuccess: (territoryInfo) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _territoryData = territoryInfo;
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _mobileImage = 'images/android_screen.png';
    } else {
      _mobileImage = 'images/ios_screen.png';
    }
    loadTerritories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        top: true,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: appThemeColor,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Platform.isAndroid
                      ? const SizedBox(
                          height: 15,
                        )
                      : const SizedBox(),
                  TextButton(
                    child: const Text(
                      "Skip",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: appThemeColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.selectLocation);
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      _mobileImage,
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .55,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const BottomContent()
                ],
              ),
      ),
      bottomNavigationBar: Material(
        color: const Color(0XFF25A163),
        child: InkWell(
          onTap: () async {
            var address = await LocationClass().permission(context);
            bool status = false;
            if (_territoryData!.countries![0].name == address!["country"]) {
              _territoryData!.countries![0].cities!.forEach((element) async {
                if (element.name == address["city"]) {
                  status = true;
                  await _networkCalls.saveKeys(
                      "country", _territoryData!.countries![0].name.toString());
                  await _networkCalls.saveKeys("arabicCountry",
                      _territoryData!.countries![0].arabicName.toString());
                  await _networkCalls.saveKeys("city", element.name.toString());
                  await _networkCalls.saveKeys(
                      "arabicCity", element.arabicName.toString());
                  await _networkCalls.saveKeys("cityId", element.id.toString());
                  await _networkCalls.saveKeys(
                      "lat", element.latitude.toString());
                  await _networkCalls.saveKeys(
                      "long", element.longitude.toString());
                }
              });
            }
            if (status) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.playerHome, (r) => false);
            } else {
              Navigator.pushNamed(context, RouteNames.selectLocation);
            }
          },
          splashColor: Colors.black,
          child: Container(
            height: Platform.isAndroid ? 50 : 60,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 15),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: appThemeColor,
                    )
                  : const Text(
                      "Allow",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomContent extends StatelessWidget {
  final bool? isLocationPermission;
  const BottomContent({super.key, this.isLocationPermission});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Location",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: appThemeColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Please enable location access so we could provide you accurate results of latest news.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 13,
              color: appThemeColor,
            ),
          ),
        ],
      ),
    );
  }
}

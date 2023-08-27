import 'dart:async';
// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../localizations.dart';

class ConnectivityStatus extends StatefulWidget {
  final Widget child;
  ConnectivityStatus({required this.child});
  @override
  State<StatefulWidget> createState() {
    return _ConnectivityStatusState();
  }
}

class _ConnectivityStatusState extends State<ConnectivityStatus> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final ValueNotifier<bool> _isOnline = ValueNotifier<bool>(true);
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  _updateConnectivityStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _isOnline.value = false;
    } else if (result != ConnectivityResult.none && !_isOnline.value) {
      _isOnline.value = true;
    }
  }

  Future initConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectivityStatus(result);
  }

//  @override
//  void dispose() {
//    super.dispose();
//    _connectivitySubscription.cancel();
//  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ValueListenableBuilder(
      valueListenable: _isOnline,
      builder: (context, value, child) {
        return Column(
          children: [
            Expanded(child: widget.child
            ),
            Visibility(
              visible: !value,
              child: Container(
                width: double.maxFinite,
                height: 25,
                color: Colors.black,
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.noInternetConnection,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
      child: widget.child,
    ));
  }
}

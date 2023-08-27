import 'package:flutter/material.dart';
// import 'package:flutter_tahaddi/constant.dart';
import 'dart:async';
import 'dart:math';
// import 'package:google_maps_webservice/places.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

// class GoogleSearchPage extends PlacesAutocompleteWidget {
//   GoogleSearchPage()
//       : super(
//           apiKey: kGoogleApiKey,
//           sessionToken: Uuid().generateV4(),
//           language: "en",
//           components: [Component(Component.country, "are")],
//         );
//
//   @override
//   _GoogleSearchPageState createState() => _GoogleSearchPageState();
// }

// class _GoogleSearchPageState extends PlacesAutocompleteState {
//   final homeScaffoldKey = GlobalKey<ScaffoldState>();
//   final searchScaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
//     final body = PlacesAutocompleteResult(
//       onTap: (p) {
//         displayPrediction(p, searchScaffoldKey.currentState);
//       },
//       logo: Row(
//         children: [FlutterLogo()],
//         mainAxisAlignment: MainAxisAlignment.center,
//       ),
//     );
//     return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
//   }
//
//   Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
//     if (p != null) {
//       // get detail (lat/lng)
//       PlacesDetailsResponse detail =
//           await _places.getDetailsByPlaceId(p.placeId);
//       final lat = detail.result.geometry.location.lat;
//       final lng = detail.result.geometry.location.lng;
//       scaffold.showSnackBar(
//         SnackBar(content: Text("${p.description} - $lat/$lng")),
//       );
//     }
//   }
//
//   Future<void> _handlePressButton() async {
//     // show input autocomplete with selected mode
//     // then get the Prediction selected
//     Prediction p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: kGoogleApiKey,
//       onError: onError,
//       mode: Mode.fullscreen,
//       language: "en",
//       components: [Component(Component.country, "are")],
//     );
//
//     displayPrediction(p, homeScaffoldKey.currentState);
//   }
//
//   void onError(PlacesAutocompleteResponse response) {
//     homeScaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(response.errorMessage)),
//     );
//   }
//
//   @override
//   void onResponseError(PlacesAutocompleteResponse response) {
//     super.onResponseError(response);
//     searchScaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(response.errorMessage)),
//     );
//   }
//
//   @override
//   void onResponse(PlacesAutocompleteResponse response) {
//     super.onResponse(response);
//     if (response != null && response.predictions.isNotEmpty) {
//       searchScaffoldKey.currentState.showSnackBar(
//         SnackBar(content: Text("Got answer")),
//       );
//     }
//   }
// }

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}

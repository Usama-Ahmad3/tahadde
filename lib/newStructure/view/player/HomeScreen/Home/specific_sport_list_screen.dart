import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';

import '../../../../../constant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';

class SpecificSportsListScreen extends StatefulWidget {
  final Map? detail;

  const SpecificSportsListScreen({Key? key, this.detail}) : super(key: key);

  @override
  State<SpecificSportsListScreen> createState() =>
      _SpecificSportsListScreenState();
}

class _SpecificSportsListScreenState extends State<SpecificSportsListScreen> {
  // ignore: prefer_final_fields
  NetworkCalls _networkCalls = NetworkCalls();

  bool _isLoading = true;
  var _bookPitchData;

  loadVenues() async {
    await _networkCalls.bookpitch(
      urldetail: widget.detail!["slug"],
      onSuccess: (pitchInfo) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _bookPitchData = pitchInfo;
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
    loadVenues();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: appBar (language: AppLocalizations.of(context).locale,  onTap: (){
        //   Navigator.pop(context);
        // },title:widget.detail["slug"]  ),
        body: SafeArea(
      top: true,
      right: false,
      bottom: false,
      left: false,
      child: Column(
        children: [
          Material(
              elevation: 5,
              child: Stack(
                children: [
                  Container(
                    height: 180,
                    width: size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        cachedNetworkImage(
                            cuisineImageUrl:
                                widget.detail!["bannerImage"],
                            height: 150,
                            width: size.width,
                            imageFit: BoxFit.fill,
                            errorFit: BoxFit.fitHeight),
                        Text(
                          '${widget.detail!["sportName"]}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "poppins"),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: AppLocalizations.of(context)!.locale == "en"
                        ? 5.0
                        : null,
                    right: AppLocalizations.of(context)!.locale == "en"
                        ? null
                        : 5.0,
                    top: 5.0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: Color(0xFF25A163), shape: BoxShape.circle),
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        elevation: 2.0,
                        fillColor: const Color(0xFF25A163),
                        padding: const EdgeInsets.all(5.0),
                        shape: const CircleBorder(),
                        child: const Icon(Icons.arrow_back_sharp,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
          _isLoading
              ? const Expanded(
                  child: Center(
                  child: CircularProgressIndicator(
                    color: appThemeColor,
                  ),
                ))
              : _bookPitchData.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                          itemCount: _bookPitchData.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: const EdgeInsets.only(top: 20),
                          separatorBuilder: (context, index) {
                            return fixedGap(height: 10.0);
                          },
                          itemBuilder: ((context, index) {
                            return venuesWidget(size.width, index);
                          })),
                    )
                  : Expanded(
                      child: Center(
                      child:
                          Text(AppLocalizations.of(context)!.noVenuesAvailable),
                    )),
        ],
      ),
    ));
  }

  Widget venuesWidget(double sizeWidth, int index) {
    return GestureDetector(
      onTap: () {
        Map<String, dynamic> detail = {
          "pitchId": _bookPitchData[index]["id"],
          "subPitchId": _bookPitchData[index]["pitchType"][0]
        };
        navigateToBookPitchDetail(detail);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Material(
            elevation: 5,
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: SizedBox(
              height: 250,
              width: sizeWidth,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: cachedNetworkImage(
                        cuisineImageUrl: _bookPitchData[index]["bookpitchfiles"]
                                    ["files"]
                                .isNotEmpty
                            ? _bookPitchData[index]["bookpitchfiles"]["files"]
                                [0]["filePath"]
                            : null,
                        height: 150,
                        width: sizeWidth,
                        imageFit: BoxFit.fitWidth,
                        errorFit: BoxFit.fitHeight),
                  ),
                  flaxibleGap(2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _bookPitchData[index]["name"],
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: appThemeColor),
                            ),
                            fixedGap(height: 5.0),
                            Text(AppLocalizations.of(context)!.showDirections,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF25A163))),
                          ],
                        ),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(50.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: appThemeColor,
                                borderRadius: BorderRadius.circular(50.0)),
                            child: cachedNetworkImage(
                              cuisineImageUrl: _bookPitchData[index]
                                          ["sports_types"] !=
                                      null
                                  ? _bookPitchData[index]["sport_image"] != null
                                      ? _bookPitchData[index]["sports_types"]
                                          ["sport_image"]["filePath"]
                                      : null
                                  : null,
                              height: 40,
                              width: 40,
                              color: Colors.white,
                              imageFit: BoxFit.fitWidth,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  flaxibleGap(2),
                ],
              ),
            )),
      ),
    );
  }

  void navigateToBookPitchDetail(Map detail) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => GroundDetail(detail: detail)));
  }
}

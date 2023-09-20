import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../drop_down_file.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../newStructure/view/owner/home_screens/home_page/document_screen_both.dart';

class SelectSport extends StatefulWidget {
  bool isBack = true;
  SelectSport({Key? key, required this.isBack}) : super(key: key);

  @override
  _SelectSportState createState() => _SelectSportState();
}

class _SelectSportState extends State<SelectSport> {
  bool _isLoading = true;
  int? indexItem;
  // List<String> _sportsImage=["images/sports/chess.png","images/sports/table_tennis.png","images/sports/batminton.png","images/sports/cricket.png","images/sports/football.png","images/sports/squash.png","images/sports/paddle.png","images/sports/swimming.png","images/sports/baseball.png"];
  final List<SportsList> _sportsList = [];
  final NetworkCalls _networkCalls = NetworkCalls();
  @override
  void initState() {
    super.initState();
    getSports();
  }

  getSports() {
    _networkCalls.sportsList(
        onSuccess: (detail) {
          for (int i = 0; i < detail.length; i++) {
            _sportsList.add(SportsList(
                name: detail[i]["sport_name"],
                nameArabic: detail[i]["sport_arabic_name"],
                slug: detail[i]["sport_slug"],
                image: detail[i]["sport_image"] == null
                    ? ""
                    : detail[i]["sport_image"]["filePath"]));
          }
          setState(() {
            _isLoading = false;
          });
        },
        onFailure: (detail) {},
        tokenExpire: () {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0XFFD6D6D6).withOpacity(.4),
        appBar: appBar(
            language: AppLocalizations.of(context)!.locale,
            title: AppLocalizations.of(context)!.typeofSports,
            onTap: () {
              Navigator.of(context).pop();
            },
            isBack: widget.isBack),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            indexItem != null
                ? navigateToDocuments(SportsModel(
                    sportsType: _sportsList[indexItem!].slug,
                    sportsImage: _sportsList[indexItem!].image,
                    sportsName: _sportsList[indexItem!].name,
                  ))
                : null;
          },
          child: Container(
            height: size.height * .09,
            color: indexItem != null ? const Color(0XFF25A163) : Colors.grey,
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context)!.continueW,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: appThemeColor,
                ),
              )
            : Column(
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        height: size.height * .005,
                        width: size.width * .19,
                        color: const Color(0XFF25A163),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: size.height * .005,
                        width: size.width * .19,
                        color: const Color(0XFF25A163),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: size.height * .005,
                        width: size.width * .19,
                        color: const Color(0XFF25A163),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: size.height * .005,
                        width: size.width * .19,
                        color: const Color(0XFFCBCBCB),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: size.height * .005,
                        width: size.width * .19,
                        color: const Color(0XFFCBCBCB),
                      ),
                    ],
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: CustomDropdown(
                      leadingIcon: false,
                      icon: Image.asset(
                        "assets/images/drop_down.png",
                        height: 8,
                      ),
                      onChange: (String value, int index) => setState(() {
                        indexItem = index;
                      }),
                      dropdownButtonStyle: const DropdownButtonStyle(
                        width: 170,
                        height: 45,
                        elevation: 1,
                        backgroundColor: Colors.white,
                        primaryColor: Colors.black87,
                      ),
                      dropdownStyle: DropdownStyle(
                        borderRadius: BorderRadius.circular(0),
                        elevation: 6,
                        padding: const EdgeInsets.all(5),
                      ),
                      items: _sportsList
                          .map(
                            (item) => DropdownItem(
                              value: item.name![0],
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        cachedNetworkImage(
                                            cuisineImageUrl: item.image,
                                            height: 20,
                                            width: 20,
                                            imageFit: BoxFit.fill),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(AppLocalizations.of(context)!
                                                    .locale ==
                                                "en"
                                            ? item.name.toString()
                                            : item.nameArabic!.toString()),
                                      ],
                                    ),
                                    const Divider()
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      child: Text(
                        AppLocalizations.of(context)!.selecttypeofSport,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void navigateToDocuments(SportsModel detail) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => DocumentScreen(detail: detail)));
  }
}

class SportsModel {
  final int? id;
  final String? venueType;
  final bool? isEdit;
  final String? sportsType;
  final String? sportsName;
  final String? sportsImage;
  DocumentModel? documentModel;
  PitchDetailModel? pitchDetailModel;
  SportsModel(
      {this.sportsType,
      this.documentModel,
      this.pitchDetailModel,
      this.sportsImage,
      this.sportsName,
      this.isEdit = false,
      this.id = 0,
      this.venueType = ""});
}

class DocumentModel {
  int? documentImageId;
  String? documentName;
  String? licenceNumber;
  String? expiryDate;
  String? address;
  double? lat;
  double? long;
  String? country;
  DocumentModel(
      {this.documentImageId,
      this.address,
      this.documentName,
      this.expiryDate,
      this.lat,
      this.long,
      this.licenceNumber,
      this.country});
}

class PitchDetailModel {
  List<dynamic>? pitchImageId;
  String? pitchName;
  String? pitchNameAr;
  String? description;
  String? descriptionAr;
  String? code;
  String? gamePlay;
  String? facility;
  PitchDetailModel(
      {this.pitchImageId,
      this.description,
      this.code,
      this.descriptionAr,
      this.facility,
      this.gamePlay,
      this.pitchName,
      this.pitchNameAr});
}

class SportsList {
  final String? name;
  final String? nameArabic;
  final String? image;
  final String? bannerImage;
  final String? slug;
  SportsList(
      {this.name, this.nameArabic, this.image, this.slug, this.bannerImage});
}

import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../constant.dart';
import '../../../../../drop_down_file.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';
import 'document_screen_both.dart';

class SelectSportScreen extends StatefulWidget {
  bool isBack = true;
  SelectSportScreen({Key? key, required this.isBack}) : super(key: key);

  @override
  State<SelectSportScreen> createState() => _SelectSportScreenState();
}

class _SelectSportScreenState extends State<SelectSportScreen> {
  bool _isLoading = true;
  int? indexItem;
  // List<String> _sportsImage=["images/sports/chess.png","images/sports/table_tennis.png","images/sports/batminton.png","images/sports/cricket.png","images/sports/football.png","images/sports/squash.png","images/sports/paddle.png","images/sports/swimming.png","images/sports/baseball.png"];
  final List<SportsList> _sportsList = [];
  final NetworkCalls _networkCalls = NetworkCalls();
  int selected = -1;
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
    return Scaffold(
      backgroundColor: MyAppState.mode == ThemeMode.light
          ? Colors.white
          : const Color(0xff686868),
      appBar: PreferredSize(
          preferredSize: Size(size.width, size.height * 0.105),
          child: AppBar(
            title: Text(
              AppLocalizations.of(context)!.documents,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            leadingWidth: size.width * 0.18,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: EdgeInsets.all(size.height * 0.008),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.close,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(size.width, 10),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
                child: Row(
                  children: [
                    Container(
                      height: size.height * .005,
                      width: size.width * .17,
                      color: const Color(0XFF25A163),
                    ),
                    flaxibleGap(1),
                    Container(
                      height: size.height * .005,
                      width: size.width * .17,
                      color: const Color(0XFF25A163),
                    ),
                    flaxibleGap(1),
                    Container(
                      height: size.height * .005,
                      width: size.width * .17,
                      color: const Color(0XFF25A163),
                    ),
                    flaxibleGap(1),
                    Container(
                      height: size.height * .005,
                      width: size.width * .17,
                      color: const Color(0XFFCBCBCB),
                    ),
                    flaxibleGap(1),
                    Container(
                      height: size.height * .005,
                      width: size.width * .17,
                      color: const Color(0XFFCBCBCB),
                    ),
                  ],
                ),
              ),
            ),
          )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        child: ButtonWidget(
          title: Text(AppLocalizations.of(context)!.continu),
          color: indexItem != null ? Colors.yellow : Colors.grey,
          onTaped: () {
            indexItem != null
                ? navigateToDocuments(SportsModel(
                    sportsType: _sportsList[indexItem!].slug,
                    sportsImage: _sportsList[indexItem!].image,
                    sportsName: _sportsList[indexItem!].name,
                  ))
                : null;
          },
          isLoading: _isLoading,
        ),
      ),
      body: _isLoading
          ? Container(
              color: Colors.black,
              child: Container(
                width: size.width,
                height: size.height,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
                decoration: BoxDecoration(
                    color: MyAppState.mode == ThemeMode.light
                        ? Colors.white
                        : const Color(0xff686868),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: appThemeColor,
                  ),
                ),
              ))
          : Container(
              color: Colors.black,
              child: Container(
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
                decoration: BoxDecoration(
                    color: MyAppState.mode == ThemeMode.light
                        ? Colors.white
                        : const Color(0xff686868),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(AppLocalizations.of(context)!.selecttypeofSport,
                          style: TextStyle(
                              color: MyAppState.mode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 15)),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      ...List.generate(
                          _sportsList.length,
                          (index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? selected == index
                                              ? Colors.yellow
                                              : Colors.grey.shade200
                                          : selected == index
                                              ? Colors.yellow
                                              : Colors.black12,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    onTap: () {
                                      indexItem = index;
                                      selected = index;
                                      setState(() {});
                                    },
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    shape: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: Text(
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? _sportsList[index].name.toString()
                                          : _sportsList[index]
                                              .nameArabic!
                                              .toString(),
                                      style: TextStyle(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? Colors.black
                                                  : selected == index
                                                      ? Colors.black
                                                      : Colors.white,
                                          fontSize: 14),
                                    ),
                                    leading: cachedNetworkImage(
                                        cuisineImageUrl:
                                            _sportsList[index].image,
                                        height: size.height * 0.05,
                                        width: size.width * 0.1,
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? Colors.black
                                                : selected == index
                                                    ? Colors.black
                                                    : Colors.white,
                                        imageFit: BoxFit.fill),
                                    trailing: Icon(
                                      AppLocalizations.of(context)!.locale ==
                                              'en'
                                          ? Icons.keyboard_arrow_right
                                          : Icons.keyboard_arrow_left,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? Colors.black
                                          : selected == index
                                              ? Colors.black
                                              : Colors.white,
                                    ),
                                  ),
                                ),
                              ))
                    ],
                  ),
                ),
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

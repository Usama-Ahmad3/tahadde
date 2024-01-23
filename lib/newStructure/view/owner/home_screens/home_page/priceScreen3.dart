import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/createSession4.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/select_sport0.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar_for_creating.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';
import '../../../../../player/loginSignup/signup.dart';
import '../../../player/HomeScreen/widgets/textFormField.dart';

// ignore: must_be_immutable
class PriceScreenView extends StatefulWidget {
  SportsModel detail;

  PriceScreenView({super.key, required this.detail});

  @override
  State<PriceScreenView> createState() => _PriceScreenViewState();
}

class _PriceScreenViewState extends State<PriceScreenView> {
  bool _internet = true;
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  bool _isVenueLoading = false;
  int pitchTypeIndex = 0;
  final _formKey = GlobalKey<FormState>();
  int indexItem = 1;
  String venuePrice = "0";
  String playerPrice = "0";
  String? subVenue;
  String? area;
  bool monVal = false;
  final _vanueController = TextEditingController();
  final _priceController = TextEditingController();
  final maxPlayers = TextEditingController();
  final _pricePerPlayer = TextEditingController();
  var focusNode = FocusNode();
  var pricePer = FocusNode();

  late OverlayEntry? overlayEntry;
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0,
        left: 0,
        child: const DoneButton(),
      );
    });
    overlayState.insert(overlayEntry!);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  privacyPolicy(String text) async {
    _networkCalls.privacyPolicy(
      onSuccess: (msg) {
        launchInBrowser(msg[text]);
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print(widget.detail.pitchDetailModel!.pitchImageId);
    if (Platform.isIOS) {
      focusNode.addListener(() {
        bool hasFocus = focusNode.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
    _isLoading = false;
  }

  @override
  void dispose() {
    _priceController.dispose();
    _pricePerPlayer.dispose();
    _vanueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: _isLoading
          ? Scaffold(
              appBar: appBarWidget(
                  sizeWidth: size.width,
                  sizeHeight: size.height,
                  context: context,
                  title: AppLocalizations.of(context)!.price,
                  back: true),
              body: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.appThemeColor,
                ),
              ),
            )
          : _internet
              ? Scaffold(
                  backgroundColor: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.darkTheme,
                  appBar: appBarForCreatingAcademy(
                    size,
                    context,
                    AppLocalizations.of(context)!.price,
                    true,
                    AppColors.appThemeColor,
                    AppColors.appThemeColor,
                    AppColors.appThemeColor,
                    const Color(0XFFCBCBCB),
                  ),
                  body: Container(
                    color: AppColors.black,
                    child: Container(
                      width: size.width,
                      height: size.height,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.033),
                      decoration: BoxDecoration(
                          color: MyAppState.mode == ThemeMode.light
                              ? AppColors.white
                              : AppColors.darkTheme,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                InkWell(
                                  onTap: () {
                                    print(widget
                                        .detail.pitchDetailModel!.pitchImageId);
                                  },
                                  child: Container(
                                    width: size.width,
                                    height: size.height * 0.06,
                                    decoration: BoxDecoration(
                                        color: AppColors.appThemeColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        cachedNetworkImage(
                                            cuisineImageUrl:
                                                widget.detail.sportsImage,
                                            height: 20,
                                            width: 20,
                                            imageFit: BoxFit.fill),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    'en'
                                                ? widget.detail.sportsName!
                                                : widget.detail.sportsNameArabic
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins")),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.pricePerPlayer,
                                  style: TextStyle(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.themeColor
                                          : AppColors.white),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                TextFieldWidget(
                                    controller: _pricePerPlayer,
                                    hintText: '',
                                    type: TextInputType.number,
                                    prefix: const Text(
                                      "Amount: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    suffix: const Text(
                                      " AED",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onSubmitted: (value) {
                                      // FocusScope.of(context).requestFocus(arabicFocus);
                                      return null;
                                    },
                                    onChanged: (value) {
                                      playerPrice = value;
                                      setState(() {});
                                      return '';
                                    },
                                    onValidate: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter amount";
                                      }
                                      return null;
                                    },
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    enableBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      autofocus: true,
                                      activeColor: AppColors.appThemeColor,
                                      value: monVal,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          monVal = value!;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: size.width * .7,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .iAgree,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    color: Color(0XFFADADAD),
                                                  ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " ${AppLocalizations.of(context)!.term} ",
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  privacyPolicy(
                                                      "terms_and_conditions_url");
                                                },
                                              style: const TextStyle(
                                                color: AppColors.barLineColor,
                                                fontSize: 15,
                                                // decoration: TextDecoration.underline
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .ofCompany,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    color: Color(0XFFADADAD),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                monVal && _pricePerPlayer.text.isNotEmpty
                                    ? ButtonWidget(
                                        onTaped: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            Map pitchTypeDetail = {
                                              "subpitchtypeName":
                                                  _vanueController.text,
                                              // "pitchtypeSlug":
                                              //     _pitchType[0].slug,
                                              "price_per_player": int.parse(
                                                  _pricePerPlayer.text),
                                            };
                                            Map academydetail = {
                                              'Academy_NameEnglish': widget
                                                  .detail
                                                  .pitchDetailModel!
                                                  .pitchName,
                                              "Academy_NameArabic": widget
                                                  .detail
                                                  .pitchDetailModel!
                                                  .pitchNameAr,
                                              'descriptionEnglish': widget
                                                  .detail
                                                  .pitchDetailModel!
                                                  .description,
                                              'descriptionArabic': widget
                                                  .detail
                                                  .pitchDetailModel!
                                                  .pitchNameAr,
                                              'Academy_Location': widget.detail
                                                  .documentModel!.address,
                                              'sport_slug':
                                                  widget.detail.sportsType,
                                              'Country': widget.detail
                                                  .documentModel!.country,
                                              'latitude':
                                                  "${widget.detail.documentModel!.lat}",
                                              'longitude':
                                                  "${widget.detail.documentModel!.long}",
                                              "facilitySlug": widget.detail
                                                  .pitchDetailModel!.facility,
                                              'gameplaySlug': widget.detail
                                                  .pitchDetailModel!.gamePlay,
                                              'academy_image': widget
                                                  .detail
                                                  .pitchDetailModel!
                                                  .pitchImageId,
                                            };
                                            Map document = {
                                              'Document_Name': widget.detail
                                                  .documentModel!.documentName,
                                              'License_Number': widget.detail
                                                  .documentModel!.licenceNumber,
                                              'Expiry_Date': widget.detail
                                                  .documentModel!.expiryDate,
                                              'file': widget.detail
                                                  .documentModel!.documentImage
                                            };
                                            Map price = {
                                              'Sub_Academy':
                                                  _vanueController.text,
                                              'Price': int.parse(
                                                  _pricePerPlayer.text)
                                            };
                                            Map newDetail = {
                                              "academydetail": academydetail,
                                              'document': [document],
                                              "price": [price],
                                              "images": widget
                                                  .detail
                                                  .pitchDetailModel!
                                                  .pitchImageId,
                                            };
                                            Map detail = {
                                              "sport_slug":
                                                  widget.detail.sportsType,
                                              "pitchName": widget.detail
                                                  .pitchDetailModel!.pitchName,
                                              "pitchNamearabic": widget
                                                  .detail
                                                  .pitchDetailModel!
                                                  .pitchNameAr,
                                              "pitchLocation": widget.detail
                                                  .documentModel?.address,
                                              "pitchDescription": widget
                                                  .detail
                                                  .pitchDetailModel!
                                                  .description,
                                              "pitchDescriptionarabic": widget
                                                  .detail
                                                  .pitchDetailModel!
                                                  .descriptionAr,
                                              "gameplaySlug": widget

                                                  ///indoor/outdoor
                                                  .detail
                                                  .pitchDetailModel!
                                                  .gamePlay,
                                              "facilitiesSlug": widget.detail
                                                  .pitchDetailModel!.facility,
                                              "pitchLatitude": widget
                                                  .detail.documentModel?.lat,
                                              "pitchLongitude": widget
                                                  .detail.documentModel?.long,
                                              "pitchdocId": widget
                                                  .detail
                                                  .documentModel!
                                                  .documentImageId,
                                              "document_code": widget.detail
                                                  .documentModel!.licenceNumber,
                                              "pitchtypeDetails": [
                                                pitchTypeDetail
                                              ],
                                              "document_name": widget.detail
                                                  .documentModel!.documentName,
                                              "documents_expiry_date": widget
                                                  .detail
                                                  .documentModel!
                                                  .expiryDate,
                                              "code": widget.detail
                                                  .pitchDetailModel!.code,
                                              "country": widget.detail
                                                  .documentModel!.country,
                                            };
                                            setState(() {
                                              _isVenueLoading = true;
                                            });
                                            navigateToSession(newDetail);
                                          }
                                        },
                                        title: Text(
                                          AppLocalizations.of(context)!.continu,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        isLoading: false)
                                    : ButtonWidget(
                                        color: const Color(0XFFBCBCBC),
                                        onTaped: () {},
                                        title: Text(
                                          AppLocalizations.of(context)!.continu,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        isLoading: _isLoading)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                )
              : Column(
                  children: [
                    Expanded(
                      child: InternetLoss(
                        onChange: () {
                          _networkCalls.checkInternetConnectivity(
                              onSuccess: (msg) {
                            _internet = msg;
                          });
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  int maxPlayer(String area) {
    String s = area.toLowerCase();
    int idx = s.indexOf("x");
    String areaValue = s.substring(0, idx).trim();
    int areaInt = int.parse(areaValue);
    // print((areaInt * 2).toString());
    return areaInt * 2;
  }

  void navigateToSession(Map data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CreateSessionScreen(academyData: data)));
    // Navigator.pushNamed(context, RouteNames.createSession, arguments: data);
  }
}

// TODO: Later Fixed
class AreaSlug {
  String name;
  String slug;
  AreaSlug({required this.name, required this.slug});
}

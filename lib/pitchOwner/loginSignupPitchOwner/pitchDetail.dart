import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:permission_handler/permission_handler.dart';

import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import 'select_sport.dart';

class PitchDetail extends StatefulWidget {
  final SportsModel detail;
  PitchDetail({required this.detail});
  @override
  _PitchDetailState createState() => _PitchDetailState();
}

class _PitchDetailState extends State<PitchDetail> {
  final _nameController = TextEditingController(text: '');
  final _descriptionArabic = TextEditingController(text: "");
  final _nameControllerArabic = TextEditingController(text: '');
  final _description = TextEditingController(text: '');
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String gamePlay = "";
  late String _facility;
  bool loading = false;
  bool internet = true;
  bool indoor = false;
  bool outdoor = false;
  final bool _isImageLoading = false;
  List<File> image = <File>[];
  late List<dynamic> pitch_Id;
  final NetworkCalls _networkCalls = NetworkCalls();
  // GoogleTranslator translator = GoogleTranslator();
  final focuss = FocusNode();
  final focusss = FocusNode();
  final codeFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  List<int> indexList = [];

  // void trans(String Text, String language, TextEditingController controler) {
  //   if (Text == "") {
  //     setState(() {
  //       controler.text = "";
  //     });
  //   } else {
  //     translator.translate(Text, to: language).then((value) {
  //       setState(() {
  //         controler.text = value.toString();
  //       });
  //     });
  //   }
  // }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.uploadprofilepicture),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child:
                        Text(AppLocalizations.of(context)!.choosefromlibrary),
                    onTap: () async {
                      var status = await Permission.photos.status;
                      if (status.isGranted) {
                        // ignore: use_build_context_synchronously
                        _openGallery(context);
                      } else if (status.isDenied) {
                        _openGallery(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .galleryPermission),
                                  content: Text(AppLocalizations.of(context)!
                                      .thisGalleryPicturesUploadImage),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(AppLocalizations.of(context)!
                                          .setting),
                                      onPressed: () => openAppSettings(),
                                    ),
                                  ],
                                ));
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.takephoto),
                    onTap: () async {
                      var status = await Permission.camera.status;
                      if (status.isGranted) {
                        _openCamera(context);
                      } else if (status.isDenied) {
                        _openCamera(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .cameraPermission),
                                  content: Text(AppLocalizations.of(context)!
                                      .thisPicturesUploadImage),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(AppLocalizations.of(context)!
                                          .setting),
                                      onPressed: () => openAppSettings(),
                                    ),
                                  ],
                                ));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar(
            title: AppLocalizations.of(context)!.pitchDetails,
            language: AppLocalizations.of(context)!.locale,
            onTap: () {
              Navigator.of(context).pop();
            }),
        bottomNavigationBar: image.isNotEmpty && indexList.isNotEmpty
            ? Material(
                color: const Color(0XFF25A163),
                child: InkWell(
                  onTap: () async {
                    // if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _facility = "";
                    for (int i = 0; i < indexList.length; i++) {
                      print(indexList);
                      _facility = "$_facility${facilitySlug[i]},";
                    }
                    _facility = _facility.substring(0, _facility.length - 1);
                    _facility = _facility.substring(0);
                    widget.detail.pitchDetailModel!.facility = _facility;
                    widget.detail.pitchDetailModel!.gamePlay = gamePlay;
                    setState(() {
                      loading = true;
                    });
                    var detail = {"profile_image": image, "type": "bookpitch"};
                    await _networkCalls.helperMultiImage(
                      pitchImage: detail,
                      onSuccess: (msg) {
                        widget.detail.pitchDetailModel!.pitchImageId = msg;
                        setState(() {
                          loading = false;
                        });

                        navigateToPriceScreen(widget.detail);
                      },
                      onFailure: (msg) {
                        showMessage(msg);
                        setState(() {
                          loading = false;
                        });
                      },
                      tokenExpire: () {
                        if (mounted) on401(context);
                        setState(() {
                          loading = false;
                        });
                      },
                    );
                    // }
                  },
                  splashColor: Colors.black,
                  child: Container(
                      height: sizeHeight * .104,
                      alignment: Alignment.center,
                      child: loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!.continueW,
                              style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white),
                            )),
                ),
              )
            : Container(
                height: sizeHeight * .104,
                color: const Color(0XFFBCBCBC),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.continueW,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white),
                )),
        body: SingleChildScrollView(
          child: SizedBox(
            width: sizeWidth,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFF25A163),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFF25A163),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFF25A163),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFFCBCBCB),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFFCBCBCB),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _isImageLoading
                        ? Container(
                            color: const Color(0XFF032040),
                            height: sizeHeight * .2,
                            width: sizeWidth,
                            child: Lottie.asset(
                              'assets/lottiefiles/profile.json',
                            ),
                          )
                        : SizedBox(
                            width: sizeWidth,
                            height: sizeHeight * .3,
                            child: image.isEmpty
                                ? GridView.count(
                                    crossAxisCount: 2,
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(6, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          index == 0
                                              ? _showChoiceDialog(context)
                                              : null;
                                        },
                                        child: _addVenue(),
                                      );
                                    }))
                                : GridView.count(
                                    crossAxisCount: 3,
                                    scrollDirection: Axis.vertical,
                                    children: List.generate(
                                        image.length < 6 ? 6 : image.length + 1,
                                        (index) {
                                      if (index == 0) {
                                        return GestureDetector(
                                          onTap: () {
                                            _showChoiceDialog(context);
                                          },
                                          child: _addVenue(),
                                        );
                                      } else if (image.length >= index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              _decideImageview(index - 1),
                                              _deleteVenue(index),
                                            ],
                                          ),
                                        );
                                      }

                                      return _addVenue();
                                    })),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: textField(
                        name: AppLocalizations.of(context)!.venueName,
                        controller: _nameController,
                        // onchange: (value) {
                        //   trans(value, "ar", _nameControllerArabic);
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseenterPitchName;
                          }
                          return '';
                        },
                        text: false,
                        text1: false,
                        submit: (value) =>
                            FocusScope.of(context).requestFocus(focusss),
                        onSaved: (value) => widget.detail.pitchDetailModel =
                            PitchDetailModel(pitchName: value!)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 40, left: 40, top: 10),
                    child: textField(
                        name: AppLocalizations.of(context)!.venueNameA,
                        controller: _nameControllerArabic,
                        text: false,
                        text1: false,
                        node: focusss,
                        submit: (value) =>
                            FocusScope.of(context).requestFocus(codeFocus),
                        onSaved: (value) => widget
                            .detail.pitchDetailModel!.pitchNameAr = value!),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 40, left: 40, top: 10),
                    child: textField(
                        name: AppLocalizations.of(context)!.code,
                        text: false,
                        text1: false,
                        node: codeFocus,
                        submit: (value) =>
                            FocusScope.of(context).requestFocus(focuss),
                        onSaved: (value) =>
                            widget.detail.pitchDetailModel!.code = value!),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40, top: 20, right: 40, bottom: 10),
                    child: Container(
                      alignment: AppLocalizations.of(context)!.locale == "en"
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                        AppLocalizations.of(context)!.descriptionS,
                        style: const TextStyle(
                          color: Color(0XFFADADAD),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      height: sizeHeight * .15,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0XFFA3A3A3))),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          controller: _description,
                          // onChanged: (value) {
                          //   trans(value, "ar", _descriptionArabic);
                          // },
                          focusNode: focuss,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseenterDescription;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            widget.detail.pitchDetailModel!.description =
                                value!;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          maxLength: 50,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40, top: 20, right: 40, bottom: 10),
                    child: Container(
                      alignment: AppLocalizations.of(context)!.locale == "en"
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                        AppLocalizations.of(context)!.descriptionA,
                        style: const TextStyle(
                          color: Color(0XFFADADAD),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      height: sizeHeight * .15,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0XFFA3A3A3))),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          controller: _descriptionArabic,
                          onSaved: (value) {
                            widget.detail.pitchDetailModel!.descriptionAr =
                                value!;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          maxLength: 50,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        flaxibleGap(
                          3,
                        ),
                        GestureDetector(
                          child: indoor
                              ? SizedBox(
                                  height: sizeHeight * .03,
                                  width: sizeWidth * .055,
                                  child: Image.asset(
                                    "assets/images/Rectangle.png",
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : SizedBox(
                                  height: sizeHeight * .03,
                                  width: sizeWidth * .055,
                                  child: Image.asset(
                                    "assets/images/uncheck.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(FocusNode());
                              indoor = !indoor;
                              if (indoor && outdoor) {
                                gamePlay = "both";
                              } else {
                                if (indoor) {
                                  gamePlay = "indoor";
                                } else {
                                  gamePlay = "";
                                }
                              }
                            });
                          },
                        ),
                        flaxibleGap(
                          1,
                        ),
                        Text(
                          AppLocalizations.of(context)!.indoor,
                          style: indoor
                              ? const TextStyle(
                                  fontSize: 12,
                                  color: appThemeColor,
                                  fontWeight: FontWeight.w600)
                              : const TextStyle(
                                  fontSize: 12,
                                  color: Color(0XFFADADAD),
                                ),
                        ),
                        flaxibleGap(
                          1,
                        ),
                        GestureDetector(
                          child: outdoor
                              ? SizedBox(
                                  height: sizeHeight * .03,
                                  width: sizeWidth * .055,
                                  child: Image.asset(
                                    "assets/images/Rectangle.png",
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : SizedBox(
                                  height: sizeHeight * .03,
                                  width: sizeWidth * .055,
                                  child: Image.asset(
                                    "assets/images/uncheck.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          onTap: () {
                            setState(() {
                              outdoor = !outdoor;
                              if (indoor && outdoor) {
                                gamePlay = "both";
                              } else {
                                if (outdoor) {
                                  gamePlay = "outdoor";
                                } else {
                                  gamePlay = "";
                                }
                              }
                            });
                          },
                        ),
                        flaxibleGap(
                          1,
                        ),
                        Text(
                          AppLocalizations.of(context)!.outdoor,
                          style: outdoor
                              ? const TextStyle(
                                  fontSize: 12,
                                  color: appThemeColor,
                                  fontWeight: FontWeight.w600)
                              : const TextStyle(
                                  fontSize: 12,
                                  color: Color(0XFFADADAD),
                                ),
                        ),
                        flaxibleGap(
                          3,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 10),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.chooseFacilitiesProvided,
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          // color: Color(0XFF25A163),
                          color: Color(0XFFADADAD),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 10),
                    child: SizedBox(
                      height: sizeHeight * .13,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: facility.length,
                          itemBuilder: (BuildContext context, int blockIdx) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (indexList.contains(blockIdx)) {
                                      indexList.remove(blockIdx);
                                    } else {
                                      indexList.add(blockIdx);
                                    }
                                  });
                                },
                                child: indexList.contains(blockIdx)
                                    ? Container(
                                        width: sizeWidth * .28,
                                        height: sizeWidth * .07,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFFA3A3A3)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0XFF25A163)
                                              .withOpacity(.3),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            flaxibleGap(
                                              2,
                                            ),
                                            Image.asset(
                                              facilityImageS[blockIdx],
                                              width: sizeWidth * .1,
                                              height: sizeWidth * .1,
                                              fit: BoxFit.fill,
                                            ),
                                            flaxibleGap(
                                              1,
                                            ),
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? Text(facility[blockIdx],
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        color:
                                                            Color(0XFF424242),
                                                        decoration:
                                                            TextDecoration
                                                                .none))
                                                : Text(facilityAr[blockIdx],
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        color:
                                                            Color(0XFF424242),
                                                        decoration:
                                                            TextDecoration
                                                                .none)),
                                            flaxibleGap(
                                              1,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: sizeWidth * .28,
                                        height: sizeWidth * .07,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFFA3A3A3)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            flaxibleGap(
                                              2,
                                            ),
                                            Image.asset(
                                              facilityImage[blockIdx],
                                              width: sizeWidth * .1,
                                              height: sizeWidth * .1,
                                              fit: BoxFit.fill,
                                            ),
                                            flaxibleGap(
                                              1,
                                            ),
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? Text(facility[blockIdx],
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        color:
                                                            Color(0XFF424242),
                                                        decoration:
                                                            TextDecoration
                                                                .none))
                                                : Text(facilityAr[blockIdx],
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        color:
                                                            Color(0XFF424242),
                                                        decoration:
                                                            TextDecoration
                                                                .none)),
                                            flaxibleGap(
                                              1,
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToPriceScreen(SportsModel detail) {
    Navigator.pushNamed(context, RouteNames.priceScreen, arguments: detail);
  }

  _openGallery(BuildContext context) async {
    Navigator.of(context).pop();
    var picture = await ImagePicker().pickMultiImage();
    setState(() {
      for (int i = 0; i < picture.length; i++) {
        File imageIndex = File(picture[i].path);
        image.add(imageIndex);
      }
    });
  }

  _openCamera(BuildContext context) async {
    Navigator.of(context).pop();
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      image.add(File(picture!.path));
    });
  }

  Widget _decideImageview(int index) {
    return Image.file(
      image[index],
      fit: BoxFit.cover,
    );
  }

  _addVenue() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: const Color(0XFFD4D4D4),
        width: 100,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            flaxibleGap(
              1,
            ),
            Image.asset(
              "assets/images/add_vanue.png",
              height: 25,
            ),
            flaxibleGap(
              1,
            ),
            Text(AppLocalizations.of(context)!.addPitchImage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0XFFB3B3B3),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins")),
            flaxibleGap(
              1,
            ),
          ],
        ),
      ),
    );
  }

  _deleteVenue(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          image.removeAt(index - 1);
        });
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            "assets/images/delete_image.png",
            height: 25,
          )),
    );
  }

  void onError(response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }
}

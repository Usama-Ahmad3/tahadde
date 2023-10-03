import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';
import '../signup.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _firstName = TextEditingController(text: '');
  final _lastName = TextEditingController(text: '');
  final _dob = TextEditingController();
  final focus = FocusNode();
  final focuss = FocusNode();
  String? playerPositionApi;
  final _phoneNumber = TextEditingController(text: '');
  final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
  File? myFile;
  bool isImageLoade = false;
  String? _curentlySelectedItem;
  String? _gender;
  var lastBookingDateApi;
  bool? _internet;
  File? image;
  var profile_Id;
  String? images;
  bool _isLoading = true;
  final ProfileDetail _detail = ProfileDetail();
  final NetworkCalls _networkCalls = NetworkCalls();
  final _formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  List<String> playerPostion = [];
  List<String> playerPostionSlug = [];
  OverlayEntry? overlayEntry;

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

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.uploadprofilepicture),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child:
                        Text(AppLocalizations.of(context)!.choosefromlibrary),
                    onTap: () async {
                      var status = await Permission.photos.status;
                      if (status.isGranted) {
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
                        // ignore: use_build_context_synchronously
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

  loadProfile() async {
    _networkCalls.getProfile(
      onSuccess: (msg) {
        if (mounted) {
          setState(() {
            _firstName.text = msg['first_name'] ?? '';
            _detail.countryCode = msg["countryCode"];
            _lastName.text = msg['last_name'] ?? '';
            _dob.text = msg['dob'] ?? '';
            _phoneNumber.text = msg['contact_number'] ?? '';
            images = msg['profile_pic'] == null
                ? ''
                : msg['profile_pic']['filePath'];
            _curentlySelectedItem = msg['playerPosition'] != ""
                ? msg['playerPosition']["name"]
                : "";
            _gender = msg['gender'];
            _networkCalls.playerPosition(
              onSuccess: (msg) {
                if (mounted) {
                  setState(() {
                    for (int i = 0; i < msg.length; i++) {
                      playerPostion.add(msg[i]["name"]);
                      playerPostionSlug.add(msg[i]["slug"]);
                    }
                    _isLoading = false;
                  });
                }
              },
              onFailure: (msg) {
                showMessage(msg);
              },
              tokenExpire: () {
                if (mounted) on401(context);
              },
            );
          });
        }
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
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      focuss.addListener(() {
        bool hasFocus = focuss.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }

    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  Future<DateTime?> slecteDtateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(seconds: 1)),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        locale: Locale(AppLocalizations.of(context)!.locale),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0XFF032040)),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            bottomNavigationBar: Material(
              color: const Color(0XFF25A163),
              child: Container(
                alignment: Alignment.center,
                height: sizeheight * .1,
                child: Text(
                  AppLocalizations.of(context)!.saveChanges,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            backgroundColor: const Color(0XFFF0F0F0),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0XFFFFFFFF),
                ),
              ),
              automaticallyImplyLeading: false,
              title: Text(
                AppLocalizations.of(context)!.editProfile,
                style: TextStyle(
                    fontSize: appHeaderFont,
                    color: const Color(0XFFFFFFFF),
                    fontFamily: AppLocalizations.of(context)!.locale == "en"
                        ? "Poppins"
                        : "VIP",
                    fontWeight: AppLocalizations.of(context)!.locale == "en"
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
              backgroundColor: const Color(0XFF032040),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: sizewidth * .05,
                    right: sizewidth * .05,
                    top: sizewidth * .04),
                child: Container(
                  height: sizeheight * .7,
                  color: const Color(0XFFFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: sizewidth * .03, right: sizewidth * .03),
                    child: Column(
                      children: <Widget>[
                        flaxibleGap(2),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Container(
                            height: sizeheight * .15,
                            width: sizeheight * .15,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        flaxibleGap(1),
                        Material(
                          color: Colors.white,
                          child: Text(
                            AppLocalizations.of(context)!.changePhoto,
                            style: const TextStyle(
                                color: Color(0XFFADADAD),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        flaxibleGap(2),
                        shimmer(width: sizewidth),
                        const SizedBox(
                          height: 10,
                        ),
                        shimmer(width: sizewidth),
                        const SizedBox(
                          height: 10,
                        ),
                        shimmer(width: sizewidth),
                        const SizedBox(
                          height: 10,
                        ),
                        shimmer(width: sizewidth),
                        const SizedBox(
                          height: 10,
                        ),
                        shimmer(width: sizewidth),
                        const SizedBox(
                          height: 10,
                        ),
                        shimmer(width: sizewidth),
                        flaxibleGap(13),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : _internet!
            ? Scaffold(
                bottomNavigationBar: Material(
                  color: const Color(0XFF25A163),
                  child: InkWell(
                    splashColor: Colors.black,
                    onTap: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        _internet = msg;
                        if (msg == true) {
                          // if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Map detail = {
                            "first_name": _detail.first_name,
                            "last_name": _detail.last_name,
                            "countryCode": _detail.countryCode,
                            "contact_number": _detail.contact_number,
                          };
                          if (_gender != null) {
                            detail["gender"] = _gender;
                          } else {
                            detail["gender"] = '';
                          }
                          if (lastBookingDateApi != null) {
                            detail["dob"] = lastBookingDateApi;
                          } else {
                            detail['dob'] = formatter.format(
                                (DateTime.parse('0000-00-00'.toString())));
                          }
                          if (profile_Id != null) {
                            detail["profile_pic_id"] = profile_Id;
                          } else {
                            detail["profile_pic_id"] = 0;
                          }
                          if (playerPositionApi != null) {
                            detail["playerPosition"] = playerPositionApi;
                          } else {
                            detail['playerPosition'] = '';
                          }
                          _networkCalls.editProfileNoPic(
                            profileDetail: detail,
                            onSuccess: (msg) {
                              Navigator.pop(context);
                              //navigateToProfile();
                            },
                            onFailure: (msg) {
                              showMessage(msg);
                            },
                            tokenExpire: () {
                              if (mounted) on401(context);
                            },
                          );
                          // }
                        } else {
                          // ignore: curly_braces_in_flow_control_structures
                          if (mounted) if (mounted) {
                            showMessage(AppLocalizations.of(context)!
                                .noInternetConnection);
                          }
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: sizeheight * .1,
                      child: Text(
                        AppLocalizations.of(context)!.saveChanges,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                backgroundColor: const Color(0XFFF0F0F0),
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  title: Text(
                    AppLocalizations.of(context)!.editProfile,
                    style: TextStyle(
                        fontSize: appHeaderFont,
                        color: const Color(0XFFFFFFFF),
                        fontFamily: AppLocalizations.of(context)!.locale == "en"
                            ? "Poppins"
                            : "VIP",
                        fontWeight: AppLocalizations.of(context)!.locale == "en"
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                  backgroundColor: const Color(0XFF032040),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: sizewidth * .05,
                        right: sizewidth * .05,
                        top: sizewidth * .04),
                    child: Container(
                      height: sizeheight * .7,
                      color: const Color(0XFFFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: sizewidth * .03, right: sizewidth * .03),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              flaxibleGap(2),
                              isImageLoade
                                  ? Container(
                                      height: sizeheight * .15,
                                      width: sizeheight * .15,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Lottie.asset(
                                        'assets/lottiefiles/image.json',
                                        height: sizeheight * .1,
                                        width: sizeheight * .1,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        _showChoiceDialog(context);
                                      },
                                      child: Container(
                                          height: sizeheight * .15,
                                          width: sizeheight * .15,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0XFF4F5C6A),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              child: _decideImageview())),
                                    ),
                              flaxibleGap(1),
                              Material(
                                color: Colors.white,
                                child: InkWell(
                                  splashColor: Colors.black,
                                  onTap: () {
                                    _showChoiceDialog(context);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.changePhoto,
                                    style: const TextStyle(
                                        color: Color(0XFFADADAD),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              flaxibleGap(2),
                              textField(
                                  submit: (value) {
                                    FocusScope.of(context).requestFocus(focus);
                                  },
                                  controller: _firstName,
                                  name: AppLocalizations.of(context)!.firstName,
                                  hint: AppLocalizations.of(context)!.firstName,
                                  text: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterFirstName;
                                    }
                                    return '';
                                  },
                                  onSaved: (value) {
                                    _detail.first_name = value ?? '';
                                  }),
                              textField(
                                  submit: (value) {
                                    FocusScope.of(context).requestFocus(focuss);
                                  },
                                  node: focus,
                                  controller: _lastName,
                                  name: AppLocalizations.of(context)!.lastName,
                                  hint: AppLocalizations.of(context)!.lastName,
                                  text: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterLastName;
                                    }
                                    return '';
                                  },
                                  onSaved: (value) {
                                    _detail.last_name = value ?? '';
                                  }),
                              SizedBox(
                                height: sizeheight * .078,
                                width: sizewidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Container(
                                            alignment: Alignment.bottomCenter,
                                            child: CountryCodePicker(
                                              onChanged: (value) {
                                                setState(() {
                                                  _detail.countryCode =
                                                      value.toString();
                                                });
                                              },

                                              initialSelection:
                                                  _detail.countryCode,
                                              favorite: const ['+971', 'ITU'],

                                              showCountryOnly: false,
                                              // optional. Shows only country name and flag when popup is closed.
                                              showOnlyCountryWhenClosed: false,
                                              // optional. aligns the flag and the Text left
                                              alignLeft: false,
                                            ),
                                          )
                                        : Container(),
                                    Expanded(
                                      child: Container(
                                        width: sizewidth * .5,
                                        alignment: Alignment.topCenter,
                                        child: textField(
                                            node: focuss,
                                            controller: _phoneNumber,
                                            name: AppLocalizations.of(context)!
                                                .phoneNumber,
                                            hint: AppLocalizations.of(context)!
                                                .phoneNumber,
                                            text: false,
                                            keybordType: false,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseenterPhoneNumber;
                                              }
                                              return '';
                                            },
                                            onSaved: (value) {
                                              _detail.contact_number =
                                                  value ?? '';
                                            }),
                                      ),
                                    ),
                                    AppLocalizations.of(context)!.locale == "ar"
                                        ? Container(
                                            alignment: Alignment.bottomCenter,
                                            child: CountryCodePicker(
                                              onChanged: (value) {
                                                setState(() {
                                                  _detail.countryCode =
                                                      value.toString();
                                                  // print(country+"ratnesh");
                                                });
                                              },
                                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                              initialSelection:
                                                  _detail.countryCode,
                                              favorite: const [
                                                '+971',
                                                'ITU',
                                              ],
                                              // optional. Shows only country name and flag
                                              showCountryOnly: false,
                                              // optional. Shows only country name and flag when popup is closed.
                                              showOnlyCountryWhenClosed: false,
                                              // optional. aligns the flag and the Text left
                                              alignLeft: false,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: sizeheight * .015,
                                    bottom: sizeheight * .01),
                                child: Row(
                                  children: [
                                    Text(
                                      lastBookingDateApi ??
                                          _dob.text ??
                                          AppLocalizations.of(context)!
                                              .choosedateofbirth,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                          color: Color(0XFF032040),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                    flaxibleGap(1),
                                    GestureDetector(
                                        onTap: () async {
                                          final selectDate =
                                              await slecteDtateTime(context);
                                          if (selectDate != null) {
                                            setState(() {
                                              lastBookingDateApi = formatter
                                                  .format((selectDate))
                                                  .toString();
                                            });
                                          }
                                          print(selectDate);
                                        },
                                        child: const Icon(Icons.calendar_today))
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                width: sizewidth,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: sizeheight * .07,
                                width: sizewidth,
                                child: Center(
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      height: 1,
                                      color: const Color(0XFF9F9F9F),
                                    ),
                                    iconEnabledColor: const Color(0XFF9B9B9B),
                                    focusColor: const Color(0XFF9B9B9B),
                                    isExpanded: true,
                                    value: _curentlySelectedItem,
                                    hint: Text(
                                      AppLocalizations.of(context)!
                                          .playerPosition,
                                      style: const TextStyle(
                                          color: Color(0XFFADADAD),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    items: playerPostion
                                        .map((value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    color: Color(0XFF032040),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _curentlySelectedItem = value;
                                        playerPositionApi = playerPostionSlug[
                                            playerPostion.indexOf(value!)];
                                        //month= value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              // AppLocalizations.of(context).locale == "en"
                              //     ? Container(
                              //         height: sizeheight * .07,
                              //         width: sizewidth,
                              //         child: Center(
                              //           child: DropdownButton<String>(
                              //             underline: Container(
                              //               height: 1,
                              //               color: Color(0XFF9F9F9F),
                              //             ),
                              //             iconEnabledColor: Color(0XFF9B9B9B),
                              //             focusColor: Color(0XFF9B9B9B),
                              //             isExpanded: true,
                              //             value: _gender,
                              //             hint: Text(
                              //               AppLocalizations.of(context).gender,
                              //               style: TextStyle(
                              //                   color: Color(0XFFADADAD),
                              //                   fontWeight: FontWeight.w500),
                              //             ),
                              //             items: genderEn
                              //                 .map((value) => DropdownMenuItem(
                              //                       child: Text(
                              //                         value,
                              //                         style: TextStyle(
                              //                             color:
                              //                                 Color(0XFF032040),
                              //                             fontWeight:
                              //                                 FontWeight.w600),
                              //                       ),
                              //                       value: value,
                              //                     ))
                              //                 .toList(),
                              //             onChanged: (String value) {
                              //               setState(() {
                              //                 _gender = value;
                              //               });
                              //             },
                              //           ),
                              //         ),
                              //       )
                              //     : Container(
                              //         height: sizeheight * .07,
                              //         width: sizewidth,
                              //         child: Center(
                              //           child: DropdownButton<String>(
                              //             underline: Container(
                              //               height: 1,
                              //               color: Color(0XFF9F9F9F),
                              //             ),
                              //             iconEnabledColor: Color(0XFF9B9B9B),
                              //             focusColor: Color(0XFF9B9B9B),
                              //             isExpanded: true,
                              //             value: _gender,
                              //             hint: Text(
                              //               AppLocalizations.of(context).gender,
                              //               style: TextStyle(
                              //                   color: Color(0XFFADADAD),
                              //                   fontWeight: FontWeight.w500),
                              //             ),
                              //             items: genderAr
                              //                 .map((value) => DropdownMenuItem(
                              //                       child: Text(
                              //                         value,
                              //                         style: TextStyle(
                              //                             color:
                              //                                 Color(0XFF032040),
                              //                             fontWeight:
                              //                                 FontWeight.w600),
                              //                       ),
                              //                       value: value,
                              //                     ))
                              //                 .toList(),
                              //             onChanged: (String value) {
                              //               setState(() {
                              //                 _gender = value;
                              //               });
                              //             },
                              //           ),
                              //         ),
                              //       ),
                              flaxibleGap(3),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadProfile();
                    } else {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  });
                },
              );
  }

  void navigateToProfile() {
    Navigator.pushReplacementNamed(context, RouteNames.profileDetail);
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
    setState(() {
      if (picture != null) {
        isImageLoade = true;
        image = File(picture.path);
        _detail.profile_image = image!;
        var detail = {"profile_image": _detail.profile_image, "type": "user"};
        _networkCalls.helperProfile(
          profileDetail: detail,
          onSuccess: (msg) {
            if (mounted) {
              setState(() {
                profile_Id = msg;
                isImageLoade = false;
              });
            }
          },
          onFailure: (msg) {
            showMessage(msg);
          },
          tokenExpire: () {
            if (mounted) on401(context);
          },
        );
      }
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 100, maxWidth: 100);
    setState(() {
      if (picture != null) {
        isImageLoade = true;
        image = File(picture.path);
        _detail.profile_image = image!;
        var detail = {"profile_image": _detail.profile_image, "type": "user"};
        _networkCalls.helperProfile(
          profileDetail: detail,
          onSuccess: (msg) {
            if (mounted) {
              setState(() {
                profile_Id = msg;
                isImageLoade = false;
              });
            }
          },
          onFailure: (msg) {
            showMessage(msg);
          },
          tokenExpire: () {
            if (mounted) on401(context);
          },
        );
      }
    });
    Navigator.of(context).pop();
  }

  Widget _decideImageview() {
    return image != null
        ? Image.file(
            image!,
            fit: BoxFit.cover,
          )
        : images == ''
            ? Image.asset(
                "assets/images/profile.png",
              )
            : cachedNetworkImage(
                cuisineImageUrl: images,
                placeholder: "assets/images/profile.png");
  }
}

class ProfileDetail {
  String? first_name;
  String? last_name;
  String? contact_number;
  String countryCode;
  String? dob;
  File? profile_image;
  int? profile_id;

  ProfileDetail(
      {this.first_name,
      this.last_name,
      this.contact_number,
      this.profile_image,
      this.profile_id,
      this.dob,
      this.countryCode = "+971"});
}

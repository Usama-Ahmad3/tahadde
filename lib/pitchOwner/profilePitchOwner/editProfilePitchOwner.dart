import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../player/loginSignup/signup.dart';

class EditProfilePitchOwner extends StatefulWidget {
  @override
  _EditProfilePitchOwnerState createState() => _EditProfilePitchOwnerState();
}

class _EditProfilePitchOwnerState extends State<EditProfilePitchOwner> {
  final _firstname = TextEditingController(text: '');
  final _lastname = TextEditingController(text: '');
  final _phoneNumber = TextEditingController(text: '');
  final _email = TextEditingController(text: '');
  final focus = FocusNode();
  final focuss = FocusNode();
  final focusss = FocusNode();
  late String _gender;
  late File myFile;
  late bool _internet;
  late String userName;
  File? image;
  bool isImageLoade = false;
  var profile_Id;
  String images = "";
  bool isLoading = true;
  late String token;
  late Map profileDetail;
  late SharedPreferences pref;
  bool monVal = false;
  final NetworkCalls _networkCalls = NetworkCalls();
  final ProfileDetail _detail = ProfileDetail();
  final _formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late OverlayEntry? overlayEntry;
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0,
        left: 0,
        child: DoneButton(),
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
                children: <Widget>[
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
    pref = await SharedPreferences.getInstance();
    token = pref.get("token").toString();
    if (token != null) {
      _networkCalls.getProfile(
        onSuccess: (msg) {
          setState(() {
            isLoading = false;
            _firstname.text = msg['first_name'] ?? '';
            userName = msg['first_name'] + " " + msg['last_name'];
            _lastname.text = msg['last_name'] ?? '';
            _phoneNumber.text = msg['contact_number'] ?? '';
            _email.text = msg['email'];
            _detail.countryCode = msg["countryCode"];
            _gender = msg['gender'] ?? '';
            images = msg['profile_pic'] == null
                ? ""
                : msg['profile_pic']['filePath'];
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
    } else {
      setState(() {
        //loading1 = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      focusss.addListener(() {
        bool hasFocus = focusss.hasFocus;
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
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: appThemeColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0XFF25A163),
              ),
            ),
          )
        : _internet
            ? Scaffold(
                key: scaffoldkey,
                bottomNavigationBar: Material(
                  color: const Color(0XFF25A163),
                  child: InkWell(
                    splashColor: Colors.black,
                    onTap: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        if (msg == true) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var detail = {
                              "first_name": _detail.first_name,
                              "last_name": _detail.last_name,
                              "email": _detail.email,
                              "countryCode": _detail.countryCode,
                              "contact_number": _detail.contact_number,
                              "gender": _gender,
                            };
                            if (profile_Id != null) {
                              detail["profile_pic_id"] = profile_Id.toString();
                            }
                            _networkCalls.editProfileNoPic(
                              profileDetail: detail,
                              onSuccess: (msg) {
                                // showMessage(msg, scaffoldkey);
                                navigateToProfile();
                              },
                              onFailure: (msg) {
                                showMessage(msg);
                              },
                              tokenExpire: () {
                                if (mounted) on401(context);
                              },
                            );
                          }
                        } else {
                          if (mounted) {
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
                        AppLocalizations.of(context)!.save,
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
                      height: sizeheight * .50,
                      color: const Color(0XFFFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: sizewidth * .03, right: sizewidth * .03),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              flaxibleGap(
                                2,
                              ),
                              Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      _showChoiceDialog(context);
                                    },
                                    child: isImageLoade
                                        ? Container(
                                            height: sizeheight * .13,
                                            width: sizeheight * .13,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                            child: Lottie.asset(
                                              'lottiefiles/image.json',
                                              height: sizeheight * .1,
                                              width: sizeheight * .1,
                                            ),
                                          )
                                        : Container(
                                            height: sizeheight * .13,
                                            width: sizeheight * .13,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0XFFF1F1F1),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              child: _decideImageview(),
                                            )),
                                  ),
                                  flaxibleGap(
                                    1,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: sizewidth * .5,
                                        alignment: Alignment.center,
                                        child: Text(
                                          userName ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Color(0XFF032040),
                                              fontSize: 16,
                                              height: 1,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          splashColor: Colors.black,
                                          onTap: () {
                                            _showChoiceDialog(context);
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Container(
                                              height: sizeheight * .035,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0XFF25A163)),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                "  ${AppLocalizations.of(context)!.uploadImage}  ",
                                                style: const TextStyle(
                                                    color: Color(0XFF25A163),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  flaxibleGap(
                                    3,
                                  ),
                                ],
                              ),
                              flaxibleGap(
                                2,
                              ),
                              textField(
                                  submit: (value) {
                                    FocusScope.of(context).requestFocus(focus);
                                  },
                                  controller: _firstname,
                                  name: AppLocalizations.of(context)!.firstName,
                                  hint: AppLocalizations.of(context)!.firstName,
                                  text: true,
                                  onSaved: (value) {
                                    _detail.first_name = value ?? '';
                                  }),
                              textField(
                                  submit: (value) {
                                    FocusScope.of(context).requestFocus(focuss);
                                  },
                                  node: focus,
                                  controller: _lastname,
                                  name: AppLocalizations.of(context)!.lastName,
                                  hint: AppLocalizations.of(context)!.lastName,
                                  text: true,
                                  onSaved: (value) {
                                    _detail.last_name = value ?? '';
                                  }),
                              textField(
                                  submit: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(focusss);
                                  },
                                  node: focuss,
                                  controller: _email,
                                  name: AppLocalizations.of(context)!.email,
                                  hint: AppLocalizations.of(context)!.email,
                                  text: false,
                                  text1: false,
                                  onSaved: (value) {
                                    _detail.email = value ?? '';
                                  }),
                              Container(
                                height: sizeheight * .075,
                                width: sizewidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Container(
                                            height: sizeheight * .15,
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
                                              favorite: const ['+971', 'ITU'],
                                              // optional. Shows only country name and flag
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
                                        width: sizewidth * .55,
                                        height: sizeheight * .15,
                                        alignment: Alignment.topCenter,
                                        child: textField(
                                            node: focusss,
                                            controller: _phoneNumber,
                                            name: AppLocalizations.of(context)!
                                                .phoneNumber,
                                            hint: AppLocalizations.of(context)!
                                                .phoneNumber,
                                            text: false,
                                            keybordType: false,
                                            onSaved: (value) {
                                              _detail.contact_number =
                                                  value ?? '';
                                            }),
                                      ),
                                    ),
                                    AppLocalizations.of(context)!.locale == "ar"
                                        ? flaxibleGap(
                                            1,
                                          )
                                        : Container(),
                                    AppLocalizations.of(context)!.locale == "ar"
                                        ? Container(
                                            height: sizeheight * .15,
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
                              flaxibleGap(
                                3,
                              ),
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
                    }
                  });
                },
              );
  }

  void navigateToProfile() {
    Navigator.pushReplacementNamed(context, RouteNames.homePitchOwner,
        arguments: 3);
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
    setState(() {
      if (picture != null) {
        isImageLoade = true;
        image = File(picture.path);
        _detail.profile_image = File(picture.path);
        var detail = {"profile_image": _detail.profile_image, "type": "user"};
        _networkCalls.helperProfile(
          profileDetail: detail,
          onSuccess: (msg) {
            setState(() {
              profile_Id = msg;
              isImageLoade = false;
            });
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
    final picture = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 100, maxWidth: 100);
    setState(() {
      if (picture != null) {
        isImageLoade = true;
        image = File(picture.path);
        _detail.profile_image = File(picture.path);
        var detail = {"profile_image": _detail.profile_image, "type": "user"};
        _networkCalls.helperProfile(
          profileDetail: detail,
          onSuccess: (msg) {
            setState(() {
              profile_Id = msg;
              isImageLoade = false;
            });
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
        : images == ""
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
  String? email;
  File? profile_image;
  int? profile_id;
  String? countryCode;

  ProfileDetail(
      {this.first_name,
      this.last_name,
      this.contact_number,
      this.profile_image,
      this.profile_id,
      this.countryCode = "+971",
      this.email});
}

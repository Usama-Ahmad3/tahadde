import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/textFormField.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/UtilsSignin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';
import '../../../../app_colors/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var firstNameController = TextEditingController();
  final _lastName = TextEditingController(text: '');
  final _dob = TextEditingController();
  final emailController = TextEditingController();
  final _phoneNumber = TextEditingController(text: '');
  final FocusNode lastFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
  bool isImageLoade = false;
  var lastBookingDateApi;
  bool _internet = true;
  bool isLoading = false;
  File? image;
  var profile_Id;
  String? images;
  String? countryCode;
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  List<String> playerPostion = [];
  List<String> playerPostionSlug = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    child: Text(
                      AppLocalizations.of(context)!.choosefromlibrary,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                    onTap: () async {
                      var status = await Permission.photos.status;
                      if (status.isGranted) {
                        _imagePicker(context, ImageSource.gallery);
                      } else if (status.isDenied) {
                        _imagePicker(context, ImageSource.gallery);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context)!
                                          .galleryPermission,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15)),
                                  content: Text(AppLocalizations.of(context)!
                                      .thisGalleryPicturesUploadImage),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        AppLocalizations.of(context)!.setting,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
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
                    child: Text(AppLocalizations.of(context)!.takephoto,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15)),
                    onTap: () async {
                      var status = await Permission.camera.status;
                      if (status.isGranted) {
                        _imagePicker(context, ImageSource.camera);
                      } else if (status.isDenied) {
                        // ignore: use_build_context_synchronously
                        _imagePicker(context, ImageSource.camera);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context)!
                                          .cameraPermission,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15)),
                                  content: Text(AppLocalizations.of(context)!
                                      .thisPicturesUploadImage),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.setting,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15)),
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
        // print('Profile$msg');
        if (mounted) {
          setState(() {
            firstNameController.text = msg['first_name'];
            countryCode = msg["countryCode"];
            _lastName.text = msg['last_name'];
            _dob.text = msg['dob'];
            emailController.text = msg['email'];
            _phoneNumber.text = msg['contact_number'];
            images = msg['profile_pic'] == null
                ? ''
                : msg['profile_pic']['filePath'];
            _networkCalls.playerPosition(
              onSuccess: (msg) {
                if (mounted) {
                  setState(() {
                    for (int i = 0; i < msg.length; i++) {
                      playerPostion.add(msg[i]["name"]);
                      playerPostionSlug.add(msg[i]["slug"]);
                    }
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
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        if (mounted) {
          setState(() {});
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
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    _lastName.dispose();
    _phoneNumber.dispose();
    emailController.dispose();
    _dob.dispose();
    lastFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return _internet
        ? Scaffold(
            backgroundColor: MyAppState.mode == ThemeMode.light
                ? AppColors.white
                : AppColors.darkTheme,
            appBar: appBarWidget(width, height, context,
                AppLocalizations.of(context)!.editProfile, true),
            body: DefaultTextStyle(
                style: TextStyle(
                    fontSize: height * 0.02,
                    color: MyAppState.mode == ThemeMode.light
                        ? AppColors.grey
                        : AppColors.white),
                child: Container(
                  color: AppColors.black,
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyAppState.mode == ThemeMode.light
                            ? AppColors.white
                            : AppColors.darkTheme,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06, vertical: height * 0.02),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.grey.shade400.withOpacity(0.7),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.amberAccent)),
                                  child: isImageLoade
                                      ? Container(
                                          width: 85,
                                          height: 85,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade400
                                                  .withOpacity(0.7),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.amberAccent)),
                                          child: Lottie.asset(
                                            'assets/lottiefiles/image.json',
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            _showChoiceDialog(context);
                                          },
                                          child: Container(
                                            width: 85,
                                            height: 85,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade400
                                                    .withOpacity(0.7),
                                                shape: BoxShape.circle,
                                                image: images != null
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                            images!),
                                                        fit: BoxFit.cover)
                                                    : const DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/profile.png"),
                                                        fit: BoxFit.cover),
                                                border: Border.all(
                                                  color:
                                                      AppColors.appThemeColor,
                                                )),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 15),

                              // upload photo text
                              Text(
                                AppLocalizations.of(context)!.uploadImage,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(
                                AppLocalizations.of(context)!.personalDetail,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? AppColors.black
                                                : AppColors.white),
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                AppLocalizations.of(context)!.firstName,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              SizedBox(
                                height: height * 0.062,
                                child: TextFieldWidget(
                                  controller: firstNameController,
                                  hintText:
                                      AppLocalizations.of(context)!.tahaddi,
                                  suffixIcon: Icons.edit_outlined,
                                  fillColor: Colors.transparent,
                                  suffixIconColor:
                                      MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  enableBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  onSubmitted: (value) {
                                    UtilsSign.focusChange(lastFocus, context);
                                    return null;
                                  },
                                  onValidate: (value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterFirstName;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                AppLocalizations.of(context)!.lastName,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              SizedBox(
                                height: height * 0.062,
                                child: TextFieldWidget(
                                  controller: _lastName,
                                  focus: lastFocus,
                                  hintText: AppLocalizations.of(context)!
                                      .pleaseenterLastName,
                                  suffixIcon: Icons.edit_outlined,
                                  fillColor: AppColors.transparent,
                                  suffixIconColor:
                                      MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  enableBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  onSubmitted: (value) {
                                    UtilsSign.focusChange(emailFocus, context);
                                    return null;
                                  },
                                  onValidate: (value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterLastName;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                AppLocalizations.of(context)!.email,
                                style: const TextStyle(),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              SizedBox(
                                height: height * 0.062,
                                child: TextFieldWidget(
                                  controller: emailController,
                                  focus: emailFocus,
                                  hintText: AppLocalizations.of(context)!
                                      .pleaseEnterEmail,
                                  suffixIcon: Icons.edit_outlined,
                                  fillColor: AppColors.transparent,
                                  suffixIconColor:
                                      MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  enableBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  onSubmitted: (value) {
                                    UtilsSign.focusChange(phoneFocus, context);
                                    return null;
                                  },
                                  onValidate: (value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseEnterEmail;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(AppLocalizations.of(context)!.dateofBirth),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * .015, bottom: height * .01),
                                child: Row(
                                  children: [
                                    Text(
                                      lastBookingDateApi ??
                                          _dob.text ??
                                          AppLocalizations.of(context)!
                                              .choosedateofbirth,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? AppColors.themeColor
                                                  : AppColors.white,
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
                                        child: Icon(Icons.calendar_today,
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.black
                                                : AppColors.white))
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                AppLocalizations.of(context)!.contacts,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppLocalizations.of(context)!.locale == "en"
                                      ? CountryCodePicker(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          textStyle: TextStyle(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.themeColor
                                                  : AppColors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                          onChanged: (value) {
                                            setState(() {
                                              countryCode = value.toString();
                                            });
                                          },
                                          initialSelection: countryCode,
                                          favorite: const [
                                            '+971',
                                            'ae',
                                          ],
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                          alignLeft: false,
                                        )
                                      : Container(),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      width: width * .5,
                                      alignment: Alignment.topCenter,
                                      child: textField(
                                        testAlignment:
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? true
                                                : false,
                                        // node: phoneFocus,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .pleaseenterPhoneNumber;
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _phoneNumber,
                                        node: phoneFocus,
                                        text: false,
                                        text1: true,
                                        keybordType: false,
                                        name: "",
                                        onchange: (value) {
                                          setState(() {});
                                        },
                                        onSaved: (value) {},
                                      ),
                                    ),
                                  ),
                                  AppLocalizations.of(context)!.locale == "ar"
                                      ? CountryCodePicker(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          textStyle: TextStyle(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.themeColor
                                                  : AppColors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          initialSelection: countryCode,
                                          favorite: const [
                                            '+971',
                                            'ae',
                                          ],
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                          alignLeft: false,
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              ButtonWidget(
                                  isLoading: isLoading,
                                  onTaped: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _networkCalls.checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        _internet = msg;
                                        if (msg == true) {
                                          Map detail = {
                                            "first_name":
                                                firstNameController.text,
                                            "last_name": _lastName.text,
                                            "countryCode": countryCode,
                                            "contact_number": _phoneNumber.text,
                                            "email": emailController.text
                                          };
                                          if (lastBookingDateApi != null) {
                                            detail["dob"] = lastBookingDateApi;
                                          } else {
                                            detail['dob'] = formatter.format(
                                                (DateTime.parse(
                                                    '0000-00-00'.toString())));
                                          }
                                          if (profile_Id != null) {
                                            detail["profile_pic_id"] =
                                                profile_Id;
                                          } else {
                                            detail["profile_pic_id"] = 0;
                                          }
                                          _networkCalls.editProfileNoPic(
                                            profileDetail: detail,
                                            onSuccess: (msg) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              showMessage(msg);
                                              Navigator.pop(context);
                                              // navigateToProfile();
                                            },
                                            onFailure: (msg) {
                                              showMessage(msg);
                                              setState(() {
                                                isLoading = false;
                                              });
                                            },
                                            tokenExpire: () {
                                              if (mounted) on401(context);
                                            },
                                          );
                                        } else {
                                          // ignore: curly_braces_in_flow_control_structures
                                          if (mounted) if (mounted) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            showMessage(
                                                AppLocalizations.of(context)!
                                                    .noInternetConnection);
                                          }
                                        }
                                      });
                                    }
                                  },
                                  title: Text(
                                    AppLocalizations.of(context)!.saveChanges,
                                    style: TextStyle(color: AppColors.black),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          )
        : InternetLoss(
            onChange: () {
              _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                _internet = msg;
                if (msg == true) {
                  loadProfile();
                } else {
                  if (mounted) {
                    setState(() {});
                  }
                }
              });
            },
          );
  }

  _imagePicker(BuildContext context, ImageSource source) async {
    var picture = await ImagePicker()
        .pickImage(source: source, maxHeight: 100, maxWidth: 100);
    setState(() {
      if (picture != null) {
        isImageLoade = true;
        image = File(picture.path);
        var detail = {"profile_image": image, "type": "user"};
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
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/playerHomeScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';
import '../modelClass/my_venue_list_model_class.dart';

typedef FormFieldValidator<T> = String? Function(T value);
typedef FormFieldSetter<T> = void Function(T newValue);
typedef GestureTapCallback = void Function();
typedef ValueChanged<T> = void Function(T value);

Widget searchbar(
    {required String hintText,
    int color = 0xFFFFFFF,
    int colorText = 0XFF7A7A7A,
    String icon = 'assets/images/Shape.png',
    double size = 14,
    FocusNode? node,
    bool enableText = true,
    ValueChanged<String>? onchange,
    TextEditingController? controller,
    FormFieldValidator<String?>? validator,
    FormFieldSetter<String?>? onSaved,
    ValueChanged<String>? submit,
    double textOpacity = 1.0,
    double opacity = 1.0}) {
  return Container(
    alignment: Alignment.center,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: Color(color).withOpacity(opacity),
    ),
    child: TextFormField(
      controller: controller,
      enabled: enableText,
      onChanged: onchange,
      validator: validator,
      onSaved: onSaved,
      focusNode: node,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: submit,
      style: TextStyle(
          color: Color(colorText).withOpacity(textOpacity),
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.all(0),
        hintStyle: TextStyle(fontSize: size, color: const Color(0XFF7A7A7A)),
        hintText: hintText,
        prefixIcon: GestureDetector(
          child: Image.asset(
            icon,
            color: const Color(0XFF9B9B9B),
          ),
          onTap: () {},
        ),
        border: InputBorder.none,
      ),
    ),
  );
}

Widget textField({
  String name = 'Email',
  bool focusAuto = false,
  String? hintText,
  double font = 12,
  TextEditingController? controller,
  bool keybordType = true,
  FocusNode? node,
  bool text = true,
  bool testAlignment = true,
  bool text1 = true,
  String hint = 'text',
  FormFieldValidator? validator,
  FormFieldSetter<String?>? onSaved,
  GestureTapCallback? onTap,
  ValueChanged<String>? submit,
  ValueChanged<String>? onchange,
}) {
  return TextFormField(
    autofocus: focusAuto,
    controller: controller,
    textAlign: testAlignment ? TextAlign.start : TextAlign.end,
    focusNode: node,
    textInputAction: keybordType ? TextInputAction.next : TextInputAction.done,
    onFieldSubmitted: submit,
    onTap: onTap,
    onChanged: onchange,
    validator: validator,
    onSaved: onSaved,
    keyboardType: text
        ? TextInputType.text
        : text1
            ? TextInputType.number
            : TextInputType.emailAddress,
    style: TextStyle(
        color: MyAppState.mode == ThemeMode.light ? Colors.black : Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12),
    decoration: InputDecoration(
      labelText: name,
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Color(0XFF032040), fontWeight: FontWeight.w500, fontSize: 10),
      contentPadding: const EdgeInsets.all(0),
      labelStyle: TextStyle(
          color: const Color(0XFFADADAD),
          fontSize: font,
          fontWeight: FontWeight.w500),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0XFF9F9F9F)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0XFF9F9F9F)),
      ),
    ),
  );
}

Widget button({required String name}) {
  return Container(
    alignment: Alignment.center,
    height: 45,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      //color: Color(color),
    ),
    child: Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
      //textAlign: TextAlign.right,
    ),
  );
}

bool isMail(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());

  return regex.hasMatch(email);
}

showMessage(
  String message,
) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      //timeInSecForIosWeb: 1,
      backgroundColor: Colors.white70,
      textColor: Colors.black,
      fontSize: 15.0);
}

showSucess(String message, scaffoldKey, {Duration? duration}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      //timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0);
}

Future<bool?> checkAuthorizaton() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? auth = (prefs.get("auth") ?? false) as bool?;
  return auth;
}

on401(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("role");
  prefs.remove("token");
  prefs.remove("auth");
  // ignore: use_build_context_synchronously
  // Navigator.pushNamedAndRemoveUntil(
  //     context, RouteNames.playerHome, (r) => false);
  // ignore: use_build_context_synchronously
  Navigator.push(
      context, MaterialPageRoute(builder: (_) => PlayerHomeScreen(index: 0)));
}

Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> makeMap(var url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget flaxibleGap(int value) {
  return Flexible(
    flex: value,
    child: Container(),
  );
}

Widget fixedGap({height, width}) {
  return SizedBox(
    height: height ?? 0.0,
    width: width ?? 0.0,
  );
}

Widget cachedNetworkImage(
    {double? height,
    double? width,
    String? cuisineImageUrl,
    String? placeholder,
    Color? color,
    BoxFit? errorFit,
    BoxFit? imageFit}) {
  return CachedNetworkImage(
    height: height ?? 0,
    width: width ?? 0,
    fadeInDuration: const Duration(seconds: 1),
    placeholderFadeInDuration: const Duration(milliseconds: 400),
    fadeInCurve: Curves.easeIn,
    imageUrl: cuisineImageUrl ?? "assets/images/T.png",
    color: color,
    placeholder: (context, str) {
      return Image.asset(
        placeholder ?? imgList[0],
        fit: errorFit ?? BoxFit.contain,
      );
    },
    fit: imageFit ?? BoxFit.contain,
    errorWidget: (context, url, error) => Image.asset(
      placeholder ?? imgList[0],
      fit: errorFit ?? BoxFit.contain,
    ),
  );
}

Widget buildAppBar(
    {bool backButton = false,
    String? language,
    String? title,
    double? height,
    double? width,
    GestureTapCallback? onTap}) {
  return Container(
    alignment: language == "en" ? Alignment.bottomLeft : Alignment.bottomRight,
    height: 150,
    width: width,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: language == "en"
            ? const AssetImage("assets/images/header.png")
            : const AssetImage("assets/images/arabicHeader.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(
          bottom: height! * .03, left: width! * .02, right: width * .02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          backButton
              ? IconButton(
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .03, vertical: 5),
            child: Text(
              title.toString(),
              style: TextStyle(
                  fontSize: appHeaderFont,
                  color: const Color(0XFFFFFFFF),
                  fontFamily: language == "en" ? "Poppins" : "VIP",
                  fontWeight:
                      language == "en" ? FontWeight.w600 : FontWeight.normal),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildViewMore(
    {bool onTapGesture = true,
    required String language,
    required String title,
    required String viewMore,
    required double width,
    required GestureTapCallback onTap,
    required Color titleColor,
    required Color viewMoreColor,
    required Color pathColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: titleColor),
      ),
      onTapGesture
          ? Row(
              children: <Widget>[
                GestureDetector(
                    onTap: onTap,
                    child: Text(viewMore,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: viewMoreColor))),
                Container(
                  width: width * .02,
                ),
              ],
            )
          : Container(),
    ],
  );
}

appBar(
    {required String language,
    GestureTapCallback? onTap,
    required String title,
    bool isBack = true}) {
  return AppBar(
    flexibleSpace: Image(
      image: language == "en"
          ? const AssetImage("assets/images/header.png")
          : const AssetImage("assets/images/arabicHeader.png"),
      fit: BoxFit.cover,
    ),
    leading: isBack
        ? IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0XFFFFFFFF),
              size: 20,
            ),
          )
        : null,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: const TextStyle(
          fontSize: 20,
          color: Color(0XFFFFFFFF),
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600),
    ),
  );
}

Widget shimmer({double? width}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: Container(
      width: width,
      height: 5.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
    ),
  );
}

buildMyVenue(MyVenueModelClass myVenue) {
  return Column(
    children: [
      Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0) //
                ),
          ),
          width: 160,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
            child: cachedNetworkImage(
                height: 120,
                width: 160,
                cuisineImageUrl: myVenue.pitchImage,
                errorFit: BoxFit.fitHeight),
          )),
      Container(
        height: 30,
        width: 160,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${myVenue.venueName}",
                style: const TextStyle(
                    color: Color(0XFF032040),
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    fontSize: 12)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(10),
                  child: cachedNetworkImage(
                    height: 20,
                    cuisineImageUrl: myVenue.sportImage ?? "",
                    color: appThemeColor,
                    imageFit: BoxFit.fitHeight,
                    errorFit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

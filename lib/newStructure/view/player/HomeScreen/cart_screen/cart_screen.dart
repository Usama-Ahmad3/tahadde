import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/academy_model.dart';
import 'package:flutter_tahaddi/modelClass/cart_model.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/bookAcademyScreens/enterYourDetailAcademy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int indexItem = 1;
  bool loading = true;
  final NetworkCalls _networkCalls = NetworkCalls();
  List<CartModel> cartModel = [];
  List<AcademyModel> _specificAcademy = [];

  getCartAcademies() async {
    await _networkCalls.getCartAcademy(
        onSuccess: (detail) {
          for (int i = 0; i < detail.length; i++) {
            cartModel.add(CartModel.fromJson(detail[i]));
          }
          loadVerifiedSpecific();
        },
        onFailure: (onFailure) {
          if (mounted) {
            on401(context);
            showMessage(AppLocalizations.of(context)!.loginRequired);
          }
        },
        tokenExpire: () {});
  }

  loadVerifiedSpecific() async {
    cartModel.forEach((element) async {
      await _networkCalls.loadVerifiedAcademies(
        sport: element.academy.toString(),
        onSuccess: (academyInfo) {
          List<AcademyModel> bookAcademy = [];
          for (int i = 0; i < academyInfo.length; i++) {
            bookAcademy.add(AcademyModel.fromJson(academyInfo[i]));
          }
          _specificAcademy.addAll(bookAcademy);
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              loading = false;
            });
          });
        },
        onFailure: (msg) {
          if (mounted) {
            setState(() {});
          }
        },
        tokenExpire: () {
          if (mounted) {
            print('load Specific');
            on401(context);
          }
        },
      );
    });
  }

  @override
  void initState() {
    getCartAcademies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarWidget(
        sizeWidth: width,
        sizeHeight: height,
        context: context,
        title: AppLocalizations.of(context)!.cart,
        back: false,
      ),
      body: loading
          ? Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.darkTheme,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.appThemeColor,
                ),
              ),
            )
          : Container(
              color: AppColors.black,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: MyAppState.mode == ThemeMode.light
                        ? AppColors.white
                        : AppColors.darkTheme,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.059),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        ListView.builder(
                          itemCount: cartModel.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final reversed = cartModel.reversed
                                .toList(); // reverse your list here
                            final reversedAcademy = _specificAcademy.reversed
                                .toList(); // reverse your list here
                            final item = reversed[index];
                            return Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Container(
                                height: height * 0.235,
                                width: width,
                                decoration: BoxDecoration(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? AppColors.grey200
                                        : AppColors.containerColorW12,
                                    borderRadius: BorderRadius.circular(13)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * .03),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${AppLocalizations.of(context)!.academyName}:",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF032040)
                                                          : AppColors.white),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                              .locale ==
                                                          'en'
                                                      ? reversedAcademy[index]
                                                          .academyNameEnglish
                                                          .toString()
                                                      : reversedAcademy[index]
                                                          .academyNameArabic
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF25A163)
                                                          : AppColors.grey),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: width * .78,
                                                  child: Text(
                                                    reversedAcademy[index]
                                                        .academyLocation
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? Color(0XFF9B9B9B)
                                                            : Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.03),
                                            child: Container(
                                                height: height * .14,
                                                width: height * .12,
                                                decoration: BoxDecoration(
                                                    color: Color(0XFF4F5C6A),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            height * 0.005)),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            height * 0.005),
                                                    child: cachedNetworkImage(
                                                        height: height * .1,
                                                        imageFit: BoxFit.fill,
                                                        cuisineImageUrl:
                                                            reversedAcademy[
                                                                        index]
                                                                    .academyImage![
                                                                0],
                                                        placeholder:
                                                            'assets/images/profile.png'))),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * .03),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context)!.bookedFor}:",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF032040)
                                                              : AppColors
                                                                  .white),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.083,
                                                    ),
                                                    Text(
                                                      item.bookedDate
                                                          .toString(),
                                                      // "${booking.playerCount} ${booking.playerCount!.toInt() == 1 ? AppLocalizations.of(context)!.player : AppLocalizations.of(context)!.players}",
                                                      style: TextStyle(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF25A163)
                                                              : AppColors.grey,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * .03),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context)!.bookedFor}:",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF032040)
                                                              : AppColors
                                                                  .white),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.083,
                                                    ),
                                                    Text(
                                                      "${item.playerCount} ${item.playerCount!.toInt() == 1 ? AppLocalizations.of(context)!.player : AppLocalizations.of(context)!.players}",
                                                      style: TextStyle(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF25A163)
                                                              : AppColors.grey,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * .03),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context)!.slot}:",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF032040)
                                                              : AppColors
                                                                  .white),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.2,
                                                    ),
                                                    Text(
                                                      "${item.session!.length} ${AppLocalizations.of(context)!.selected}",
                                                      style: TextStyle(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF25A163)
                                                              : AppColors.grey,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * .03),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context)!.price}:",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF032040)
                                                              : AppColors
                                                                  .white),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.2,
                                                    ),
                                                    Text(
                                                      item.price.toString(),
                                                      style: TextStyle(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF25A163)
                                                              : AppColors.grey,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.004,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: width * 0.025),
                                                    child: Container(
                                                      height: height * 0.035,
                                                      width: width * 0.23,
                                                      decoration: BoxDecoration(
                                                          color: MyAppState.mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors.grey
                                                                  .withOpacity(
                                                                      0.4)
                                                              : AppColors
                                                                  .containerColorW12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.fromBorderSide(
                                                              MyAppState.mode ==
                                                                      ThemeMode
                                                                          .light
                                                                  ? BorderSide
                                                                      .none
                                                                  : BorderSide(
                                                                      color: AppColors
                                                                          .white,
                                                                      width: 1))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                if (item.playerCount!
                                                                        .toInt() !=
                                                                    1) {
                                                                  item.playerCount =
                                                                      item.playerCount!
                                                                              .toInt() -
                                                                          1;
                                                                  var it = double.parse(item
                                                                          .pricePerPlayer
                                                                          .toString()) *
                                                                      item.playerCount!
                                                                          .toDouble();
                                                                  item.price =
                                                                      it;
                                                                  print(it);
                                                                  print(item
                                                                      .price);
                                                                }
                                                              });
                                                            },
                                                            child: const Icon(
                                                              FontAwesomeIcons
                                                                  .minus,
                                                              color: AppColors
                                                                  .appThemeColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          Text(
                                                            item.playerCount
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium,
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              item.playerCount! <
                                                                      22
                                                                  ? item.playerCount =
                                                                      cartModel[index]
                                                                              .playerCount! +
                                                                          1
                                                                  : null;
                                                              var it = double.parse(item
                                                                      .pricePerPlayer
                                                                      .toString()) *
                                                                  item.playerCount!
                                                                      .toDouble();
                                                              item.price = it;
                                                              print(item.price);
                                                              setState(() {});
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .appThemeColor,
                                                              size: height *
                                                                  0.035,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.08,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      List IdList = [];
                                                      item.session!
                                                          .forEach((element) {
                                                        IdList.add(element);
                                                      });
                                                      Map details = {
                                                        'cart_id': item.id,
                                                        'academyNameEnglish':
                                                            reversedAcademy[
                                                                    index]
                                                                .academyNameEnglish
                                                                .toString(),
                                                        'academyNameArabic':
                                                            reversedAcademy[
                                                                    index]
                                                                .academyNameArabic
                                                                .toString(),
                                                        "academy": item.academy,
                                                        "session": IdList,
                                                        "Sub_Academy":
                                                            item.subAcademy,
                                                        "price": item.price,
                                                        "location":
                                                            item.location,
                                                        "booked_date":
                                                            item.bookedDate,
                                                        "player_count":
                                                            item.playerCount,
                                                        'price_per_player':
                                                            item.pricePerPlayer
                                                      };
                                                      print(details);
                                                      navigateToEditAcademyDetail(
                                                          details);
                                                    },
                                                    child: Container(
                                                      height: height * 0.035,
                                                      width: width * 0.22,
                                                      decoration: BoxDecoration(
                                                          color: MyAppState.mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors
                                                                  .appThemeColor
                                                              : AppColors
                                                                  .appThemeColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.fromBorderSide(
                                                              MyAppState.mode ==
                                                                      ThemeMode
                                                                          .light
                                                                  ? BorderSide
                                                                      .none
                                                                  : BorderSide(
                                                                      color: AppColors
                                                                          .white,
                                                                      width:
                                                                          1))),
                                                      child: Center(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .proceed
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  navigateToEditAcademyDetail(detail) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EnterDetailAcademyScreen(detail: detail),
        ));
  }
}

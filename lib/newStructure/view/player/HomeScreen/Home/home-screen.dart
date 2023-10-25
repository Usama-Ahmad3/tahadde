import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/carousel.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/specific_sport_list_screen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/vanueList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../modelClass/territory_model_class.dart';
import '../../../../../network/network_calls.dart';
import '../../../../../pitchOwner/loginSignupPitchOwner/select_sport.dart';
import '../../../../app_colors/app_colors.dart';
import '../widgets/textFormField.dart';
import 'shimmerWidgets.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => HomeScreenViewState();
}

class HomeScreenViewState extends State<HomeScreenView> {
  List<TerritoryModelClass> territoryData = [];
  String? country;
  String? city;
  String? arabicCountry;
  String? arabicCity;
  bool? _internet;
  String sportName = '';
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  List<String> history = [];
  List<String>? showHistory = [];
  int isSelected = -1;

  // ignore: prefer_typing_uninitialized_variables
  var _bookPitchData;
  final List<SportsList> _sportsList = [];
  var searchController = TextEditingController();
  static bool searchFlag = false;
  var bookSpecific;

  getSports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showHistory = prefs.getStringList('history');
    _networkCalls.sportsList(onSuccess: (detail) {
      _sportsList.clear();
      for (int i = 0; i < detail.length; i++) {
        _sportsList.add(SportsList(
            name: detail[i]["sport_name"],
            nameArabic: detail[i]["sport_arabic_name"],
            slug: detail[i]["sport_slug"],
            bannerImage: detail[i]["banner_image"] == null
                ? ""
                : detail[i]["banner_image"]["filePath"],
            image: detail[i]["sport_image"] == null
                ? ""
                : detail[i]["sport_image"]["filePath"]));
      }
      setState(() {});
    }, onFailure: (detail) {
      setState(() {});
    }, tokenExpire: () {
      if (mounted) on401(context);
    });
  }

  loadTerritories() async {
    country = await _networkCalls.getKey("country");
    await _networkCalls.getTerritory(
      onSuccess: (territoryInfo) {
        if (mounted) {
          setState(() {
            territoryData = territoryInfo;
            _isLoading = false;
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

  OverlayEntry? overlayEntry;

  showOverlay(BuildContext context, double height, double width) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          top: height * 0.17,
          right: width * 0.22,
          left: width * 0.06,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        child: Text(
                          'Recent Search',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      CloseButton(
                        onPressed: () {
                          removeOverlay();
                        },
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      ...List.generate(
                          showHistory!.length > 2 ? 2 : showHistory!.length,
                          (index) => InkWell(
                                onTap: () async {
                                  searchController.text = showHistory![index];
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                      vertical: height * 0.004),
                                  child: Chip(
                                      avatar: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.transparent,
                                          child: Image.asset(
                                              'assets/images/T.png')),
                                      backgroundColor: Colors.transparent,
                                      elevation: 2,
                                      padding: const EdgeInsets.all(5),
                                      label: Text(
                                        showHistory![index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      )),
                                ),
                              )),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.016,
                  ),
                  Material(
                    child: Text(
                      AppLocalizations.of(context)!.search,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Wrap(
                    children: [
                      ...List.generate(
                        _bookPitchData.length,
                        (index) => _sportsList.isEmpty
                            ? const SizedBox.shrink()
                            : _sportsList.length > index
                                ? _sportsList[index]
                                        .name
                                        .toString()
                                        .toLowerCase()
                                        .contains(
                                            searchController.text.toLowerCase())
                                    ? InkWell(
                                        onTap: () async {
                                          Map detail = {
                                            "slug": _sportsList[index].slug,
                                            "bannerImage":
                                                _sportsList[index].bannerImage,
                                            "sportName":
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        "en"
                                                    ? _sportsList[index].name
                                                    : _sportsList[index]
                                                        .nameArabic
                                          };
                                          removeOverlay();
                                          searchFlag = false;
                                          searchController.clear();
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      SpecificSportsListScreen(
                                                        detail: detail,
                                                      )));
                                          setState(() {});
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          // history.add(
                                          //     _sportsList[index].name.toString());
                                          // prefs.setStringList('history', history);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.025,
                                              vertical: height * 0.01),
                                          child: Chip(
                                              avatar: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Image.network(
                                                      _sportsList[index]
                                                          .image
                                                          .toString())),
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 2,
                                              padding: const EdgeInsets.all(10),
                                              label: Text(
                                                _sportsList[index].name!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Colors.black),
                                              )),
                                        ),
                                      )
                                    : _bookPitchData[index]['name']
                                            .toString()
                                            .toLowerCase()
                                            .contains(searchController.text
                                                .toLowerCase())
                                        ? InkWell(
                                            onTap: () {
                                              dynamic detail = {
                                                "pitchId": _bookPitchData[index]
                                                        ["id"] ??
                                                    0,
                                                "subPitchId":
                                                    _bookPitchData[index]
                                                            ["pitchType"][0] ??
                                                        0
                                              };
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          GroundDetail(
                                                              detail: detail)));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.025,
                                                  vertical: height * 0.01),
                                              child: Chip(
                                                  avatar: CircleAvatar(
                                                      radius: 30,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: Image.network(
                                                          _bookPitchData[index][
                                                                      "bookpitchfiles"]
                                                                  ["files"][0]
                                                              ["filePath"])),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 2,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  label: Text(
                                                    _bookPitchData[index]
                                                        ['name']!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  )),
                                            ),
                                          )
                                        : Container()
                                : InkWell(
                                    onTap: () {
                                      dynamic detail = {
                                        "pitchId":
                                            _bookPitchData[index]["id"] ?? 0,
                                        "subPitchId": _bookPitchData[index]
                                                ["pitchType"][0] ??
                                            0
                                      };
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => GroundDetail(
                                                  detail: detail)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.025,
                                          vertical: height * 0.01),
                                      child: Chip(
                                          avatar: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Image.network(
                                                  _bookPitchData[index]
                                                              ["bookpitchfiles"]
                                                          ["files"][0]
                                                      ["filePath"])),
                                          backgroundColor: Colors.transparent,
                                          elevation: 2,
                                          padding: const EdgeInsets.all(10),
                                          label: Text(
                                            _bookPitchData[index]['name']!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.black),
                                          )),
                                    ),
                                  ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
    });
    overlayState.insert(overlayEntry!);
    Future.delayed(const Duration(seconds: 3), () {
      removeOverlay();
    });
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  getAddress() async {
    city = await _networkCalls.getKey("city");
    arabicCity = await _networkCalls.getKey("arabicCity");
    setState(() {});
  }

  loadVenues() async {
    await _networkCalls.bookpitch(
      urldetail: '',
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

  loadVenuesSpecific() async {
    await _networkCalls.bookpitch(
      urldetail: sportName,
      onSuccess: (pitchInfo) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            bookSpecific = pitchInfo;
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
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        getAddress();
        loadTerritories();
        getSports();
        loadVenues();
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchFlag = false;
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
        displacement: 200,
        onRefresh: () async {
          _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
            _internet = msg;
            if (msg == true) {
              if (mounted) {
                setState(() {
                  _isLoading = true;
                });
              }
              loadVenues();
              getAddress();
              getSports();
            } else {
              setState(() {});
            }
          });
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: const Color(0xff050505),
            appBar: AppBar(
              elevation: 2,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  SizedBox(
                      height: 40 * fem,
                      width: 40 * fem,
                      child: Image.asset(
                        'assets/images/T.png',
                        color: AppColors.white,
                      )),
                  SizedBox(
                    width: width * 0.001,
                  ),
                  Text(
                    AppLocalizations.of(context)!.tahaddi,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.25 * ffem / fem,
                          letterSpacing: -0.2 * fem,
                          color: const Color(0xffffffff),
                        ),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size(
                    width, searchFlag == true ? height * 0.044 : height * 0.01),
                child: searchFlag
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                height: height * 0.057,
                                width: width * 0.7,
                                child: TextFieldWidget(
                                    textColor: AppColors.white,
                                    controller: searchController,
                                    hintText:
                                        AppLocalizations.of(context)!.search,
                                    fillColor: Colors.white24,
                                    prefixIcon: Icons.search,
                                    suffixIcon: FontAwesomeIcons.close,
                                    searchTap: InkWell(
                                      onTap: () {
                                        removeOverlay();
                                        searchFlag = !searchFlag;
                                        searchController.clear();
                                        setState(() {});
                                      },
                                      child: Icon(FontAwesomeIcons.close),
                                    ),
                                    suffixIconColor: AppColors.white,
                                    searchTag: true,
                                    onChanged: (e) {
                                      setState(() {
                                        searchController.text.isEmpty
                                            ? removeOverlay()
                                            : showOverlay(
                                                context, height, width);
                                      });
                                      return null;
                                    },
                                    prefixIconColor: AppColors.grey,
                                    enableBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.2,
                                              top: height * 0.12,
                                              bottom: height * 0.089),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: height * 0.45,
                                                  decoration: BoxDecoration(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? AppColors
                                                              .containerColorB
                                                          : AppColors.darkTheme,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .filterBy,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.02,
                                                      ),
                                                      Wrap(
                                                        children: [
                                                          ...List.generate(
                                                              _sportsList
                                                                  .length,
                                                              (index) =>
                                                                  InkWell(
                                                                    onTap: () {
                                                                      if (isSelected ==
                                                                          index) {
                                                                        isSelected =
                                                                            -1;
                                                                      } else {
                                                                        isSelected =
                                                                            index;
                                                                        sportName = _sportsList[index]
                                                                            .slug
                                                                            .toString();
                                                                        loadVenuesSpecific();
                                                                      }
                                                                      Navigator.pop(
                                                                          context);
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              MediaQuery.of(context).size.width * 0.02),
                                                                      child: Chip(
                                                                          avatar: CircleAvatar(radius: 30, backgroundColor: isSelected == index ? AppColors.white : AppColors.grey, child: Image.network(_sportsList[index].image.toString())),
                                                                          backgroundColor: isSelected == index ? AppColors.appThemeColor : AppColors.black,
                                                                          elevation: 2,
                                                                          padding: const EdgeInsets.all(10),
                                                                          label: Text(
                                                                            _sportsList[index].name!,
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyMedium!.copyWith(color: isSelected == index ? AppColors.white : AppColors.white),
                                                                          )),
                                                                    ),
                                                                  ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: Container(
                                height: height * 0.05,
                                width: width * 0.12,
                                decoration: BoxDecoration(
                                    color: AppColors.appThemeColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Icon(
                                  Icons.list,
                                  color: AppColors.white,
                                  size: height * 0.044,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ///location
                    SizedBox(
                      width: 100 * fem,
                      height: 40 * fem,
                      child: territoryData.isNotEmpty
                          ? CupertinoPicker(
                              itemExtent: 20,
                              backgroundColor: AppColors.black,
                              looping: true,
                              useMagnifier: true,
                              magnification: 1,
                              onSelectedItemChanged: (e) {
                                showMessage('Tap To Select');
                              },
                              children: List.generate(
                                  territoryData[0].cities!.length, (index) {
                                return territoryData[0]
                                        .cities![index]!
                                        .isDisable as bool
                                    ? const SizedBox.shrink()
                                    : InkWell(
                                        onTap: () async {
                                          await _networkCalls.saveKeys(
                                              "country",
                                              territoryData[0]
                                                  .country!
                                                  .name
                                                  .toString());
                                          await _networkCalls.saveKeys(
                                              "arabicCountry",
                                              territoryData[0]
                                                  .country!
                                                  .nameArabic
                                                  .toString());
                                          await _networkCalls.saveKeys(
                                              "city",
                                              territoryData[0]
                                                  .cities![index]!
                                                  .city!
                                                  .name
                                                  .toString());
                                          await _networkCalls.saveKeys(
                                              "arabicCity",
                                              territoryData[0]
                                                  .cities![index]!
                                                  .city!
                                                  .nameArabic
                                                  .toString());
                                          await _networkCalls.saveKeys(
                                              "cityId",
                                              territoryData[0]
                                                  .cities![index]!
                                                  .city!
                                                  .id
                                                  .toString());
                                          await _networkCalls.saveKeys(
                                              "lat",
                                              territoryData[0]
                                                  .cities![index]!
                                                  .city!
                                                  .latitude
                                                  .toString());
                                          await _networkCalls.saveKeys(
                                              "long",
                                              territoryData[0]
                                                  .cities![index]!
                                                  .city!
                                                  .longitude
                                                  .toString());
                                          await getAddress();
                                          showMessage(
                                              '${territoryData[0].cities![index]!.city!.name.toString()} Selected');
                                        },
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? territoryData[0]
                                                    .cities![index]!
                                                    .city!
                                                    .name
                                                    .toString()
                                                : territoryData[0]
                                                    .cities![index]!
                                                    .city!
                                                    .nameArabic
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppColors.white),
                                          ),
                                        ),
                                      );
                              }))
                          : const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.appThemeColor,
                            )),
                    ),
                    InkWell(
                      onTap: () {
                        removeOverlay();
                        searchFlag = !searchFlag;
                        searchController.clear();
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: 23 * fem,
                        backgroundColor: Colors.white10,
                        child: Icon(
                          Icons.search,
                          color: AppColors.white,
                          size: 23 * fem,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        NavigateToNotification();
                      },
                      child: CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.white10,
                        child: Icon(
                          Icons.notifications_none,
                          color: AppColors.white,
                          size: 23,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            body: _isLoading
                ? ShimmerWidgets().buildShimmer(fem, context, _bookPitchData)
                : _internet!
                    ? LayoutBuilder(builder: (context, box) {
                        return CustomScrollView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                              SliverAppBar(
                                pinned: false,
                                expandedHeight: height * 0.32,
                                automaticallyImplyLeading: false,
                                stretch: true,
                                backgroundColor:
                                    Colors.transparent.withOpacity(0.0),
                                flexibleSpace: FlexibleSpaceBar(
                                  collapseMode: CollapseMode.none,
                                  background: Column(
                                    children: [
                                      ///category
                                      _sportsList.isEmpty
                                          ? const SizedBox.shrink()
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 13.0),
                                                child: Row(
                                                  children: [
                                                    ...List.generate(
                                                      _sportsList.length,
                                                      (index) => InkWell(
                                                        // onTap: () {
                                                        //   widget.isSelected = index;
                                                        //   Map detail = {
                                                        //     "slug": widget.sportsList[index].slug,
                                                        //     "bannerImage": widget.sportsList[index].bannerImage,
                                                        //     "sportName": AppLocalizations.of(context)!.locale == "en"
                                                        //         ? widget.sportsList[index].name
                                                        //         : widget.sportsList[index].nameArabic
                                                        //   };
                                                        //   Navigator.push(
                                                        //       context,
                                                        //       MaterialPageRoute(
                                                        //           builder: (context) =>
                                                        //               SpecificSportsListScreen(detail: detail)));
                                                        //   setState(() {});
                                                        // },
                                                        onTap: () {
                                                          if (isSelected ==
                                                              index) {
                                                            isSelected = -1;
                                                          } else {
                                                            isSelected = index;
                                                            sportName =
                                                                _sportsList[
                                                                        index]
                                                                    .slug
                                                                    .toString();
                                                            loadVenuesSpecific();
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.02),
                                                          child: Chip(
                                                              avatar: CircleAvatar(
                                                                  radius: 30,
                                                                  backgroundColor: isSelected == index
                                                                      ? AppColors
                                                                          .white
                                                                      : AppColors
                                                                          .grey,
                                                                  child: Image.network(
                                                                      _sportsList[
                                                                              index]
                                                                          .image
                                                                          .toString())),
                                                              backgroundColor:
                                                                  isSelected ==
                                                                          index
                                                                      ? AppColors
                                                                          .appThemeColor
                                                                      : AppColors
                                                                          .black,
                                                              elevation: 2,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              label: Text(
                                                                _sportsList[
                                                                        index]
                                                                    .name!,
                                                                style: TextStyle(
                                                                    color: isSelected ==
                                                                            index
                                                                        ? AppColors
                                                                            .white
                                                                        : AppColors
                                                                            .white),
                                                              )),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        height: height * 0.005,
                                      ),
                                      SizedBox(
                                        height: height * 0.2,
                                        width: width,
                                        child: Carousel(image: const [
                                          'https://tse1.mm.bing.net/th?id=OIP.PVOhIhZ2cfFJVWI3U9WG6AHaE7&pid=Api&P=0&h=220',
                                          'https://tse1.mm.bing.net/th?id=OIP.ptX0bcAkl4cTcMWe9JvyhgHaEK&pid=Api&P=0&h=220',
                                          'https://sp.yimg.com/ib/th?id=OIP.ioIpvjaAIPNY7QduhbyCnAHaE8&pid=Api&w=148&h=148&c=7&rs=1'
                                        ]),
                                      ),
                                      Material(
                                          color: AppColors.transparent,
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxHeight: height * 0.05,
                                                maxWidth: width),
                                            child: TabBar(
                                              indicatorSize:
                                                  TabBarIndicatorSize.label,
                                              unselectedLabelColor:
                                                  AppColors.grey,
                                              dividerColor: AppColors.red,
                                              isScrollable: true,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              tabAlignment: TabAlignment.center,
                                              // indicator: BoxDecoration(
                                              //   color: Color(0xff1d7e55),
                                              //   borderRadius: BorderRadius.circular(8),
                                              // ),
                                              // padding: EdgeInsets.symmetric(
                                              //     vertical: height * 0.004),
                                              tabs: [
                                                SizedBox(
                                                  width: width * 0.4,
                                                  child: Center(
                                                      child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .academyOnly,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: AppColors
                                                                .white),
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: width * 0.4,
                                                  child: Center(
                                                      child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .innovative,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: AppColors
                                                                .white),
                                                  )),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: ConstrainedBox(
                                  constraints:
                                      BoxConstraints(maxHeight: box.maxHeight),
                                  child: TabBarView(children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          isSelected != -1
                                              ? bookSpecific != null &&
                                                      bookSpecific.isNotEmpty
                                                  ? VanueList(
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .academy,
                                                      bookPitchData:
                                                          bookSpecific,
                                                      searchflag: searchFlag)
                                                  : VanueList(
                                                      text:
                                                          AppLocalizations
                                                                  .of(context)!
                                                              .academy,
                                                      bookPitchData:
                                                          bookSpecific,
                                                      empty: true,
                                                      searchflag: searchFlag)
                                              : _bookPitchData != null
                                                  ? VanueList(
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .academy,
                                                      bookPitchData:
                                                          _bookPitchData,
                                                      searchflag: searchFlag)
                                                  : const SizedBox.shrink()
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ///category
                                          // _sportsList.isEmpty
                                          //     ? const SizedBox.shrink()
                                          //     : SportList(
                                          //         isSelected: isSelected,
                                          //         sportsList: _sportsList,
                                          //       ),
                                          isSelected != -1
                                              ? bookSpecific != null &&
                                                      bookSpecific.isNotEmpty
                                                  ? VanueList(
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .innovative,
                                                      bookPitchData:
                                                          bookSpecific,
                                                      searchflag: searchFlag)
                                                  : VanueList(
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .innovative,
                                                      bookPitchData:
                                                          bookSpecific,
                                                      empty: true,
                                                      searchflag: searchFlag)
                                              : _bookPitchData != null
                                                  ? VanueList(
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .innovative,
                                                      bookPitchData:
                                                          _bookPitchData,
                                                      searchflag: searchFlag)
                                                  : const SizedBox.shrink()
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ]);
                      })
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height,
                              child: InternetLoss(
                                onChange: () {
                                  _networkCalls.checkInternetConnectivity(
                                      onSuccess: (msg) {
                                    _internet = msg;
                                    if (msg == true) {
                                      if (mounted) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                      }
                                      loadVenues();
                                      getAddress();
                                      getSports();
                                    } else {
                                      setState(() {});
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ));
  }

  navigateToProfile() {
    Navigator.pushNamed(context, RouteNames.profileDetail);
  }

  void navigateToBookPitchDetail(Map detail) {
    Navigator.pushNamed(context, RouteNames.venueDetailScreen,
        arguments: detail);
  }

  // ignore: non_constant_identifier_names
  void NavigateToNotification() {
    Navigator.pushNamed(context, RouteNames.notificationScreen);
  }
}

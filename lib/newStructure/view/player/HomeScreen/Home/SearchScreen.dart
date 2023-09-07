import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/textFormField.dart';
import 'package:flutter_tahaddi/walkThrough/walkThrough.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';
import '../../../../../pitchOwner/loginSignupPitchOwner/select_sport.dart';
import 'sportList.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchController = TextEditingController();
  int isSelected = 0;
  final List<SportsList> _sportsList = [];
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _internet = true;
  bool _isLoading = true;

  getSports() async {
    _networkCalls.sportsList(onSuccess: (detail) {
      _sportsList.clear();
      _isLoading = false;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        getSports();
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
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _internet
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * 0.07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.tahaddi.toString(),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white),
                            ),
                            Text(
                              AppLocalizations.of(context)!.morning,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            NavigateToNotification();
                          },
                          child: const CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.white10,
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 23,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: height * 0.062,
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!.search,
                                fillColor: Colors.white24,
                                prefixIcon: Icon(Icons.search),
                                prefixIconColor: Colors.grey,
                                enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onChanged: (e) {
                              setState(() {});
                            },
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WalkThroughScreen()));
                        },
                        child: Container(
                          height: height * 0.062,
                          width: width * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            Icons.list,
                            color: Colors.white,
                            size: height * 0.044,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: Container(
                      height: height - 224,
                      width: width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.065,
                            vertical: height * 0.028),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.search,
                                style: TextStyle(fontSize: height * 0.025),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Wrap(
                                      children: [
                                        ...List.generate(
                                          _sportsList.length,
                                          (index) => _sportsList.isEmpty
                                              ? const SizedBox.shrink()
                                              : _sportsList[index]
                                                      .name
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(searchController
                                                          .text
                                                          .toLowerCase())
                                                  ? InkWell(
                                                      onTap: () {
                                                        isSelected = index;
                                                        Map detail = {
                                                          "slug":
                                                              _sportsList[index]
                                                                  .slug,
                                                          "bannerImage":
                                                              _sportsList[index]
                                                                  .bannerImage,
                                                          "sportName": AppLocalizations.of(
                                                                          context)!
                                                                      .locale ==
                                                                  "en"
                                                              ? _sportsList[
                                                                      index]
                                                                  .name
                                                              : _sportsList[
                                                                      index]
                                                                  .nameArabic
                                                        };
                                                        Navigator.pushNamed(
                                                            context,
                                                            RouteNames
                                                                .specificSportsScreen,
                                                            arguments: detail);
                                                        setState(() {});
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.025,
                                                                vertical:
                                                                    height *
                                                                        0.01),
                                                        child: Chip(
                                                            avatar: CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor:
                                                                    isSelected ==
                                                                            index
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .transparent,
                                                                child: Image.network(
                                                                    _sportsList[
                                                                            index]
                                                                        .image
                                                                        .toString())),
                                                            backgroundColor:
                                                                isSelected ==
                                                                        index
                                                                    ? const Color(
                                                                        0xff7b61ff)
                                                                    : Colors
                                                                        .transparent,
                                                            elevation: 2,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            label: Text(
                                                              _sportsList[index]
                                                                  .name!,
                                                              style: TextStyle(
                                                                  color: isSelected ==
                                                                          index
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                            )),
                                                      ),
                                                    )
                                                  : Container(),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
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
    );
  }

  // ignore: non_constant_identifier_names
  void NavigateToNotification() {
    Navigator.pushNamed(context, RouteNames.notificationScreen);
  }
}

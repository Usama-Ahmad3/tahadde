import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/academy_list.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/innovative_list.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../homeFile/routingConstant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../main.dart';
import '../../../../../../network/network_calls.dart';
import '../../../../../app_colors/app_colors.dart';
import '../../../../../utils/utils.dart';

class ViewMoreBookAcademyInnovativeScreen extends StatefulWidget {
  bool academyInnovative;

  ViewMoreBookAcademyInnovativeScreen(
      {super.key, required this.academyInnovative,});

  @override
  _ViewMoreBookAcademyInnovativeScreenState createState() =>
      _ViewMoreBookAcademyInnovativeScreenState();
}

class _ViewMoreBookAcademyInnovativeScreenState
    extends State<ViewMoreBookAcademyInnovativeScreen> {
  final NetworkCalls _networkCalls = NetworkCalls();
  var bookPitchData;
  bool _isLoading = true;
  bool _internet = true;
  var _academyModel;

  loadAcademies() async {
    await _networkCalls.loadVerifiedAcademies(
      sport: '',
      onSuccess: (academies) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            print('hi');
            _academyModel = academies;
            print('ok');
            print(_academyModel);
            print('kok');
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
        if (mounted) {
          print('loadVenues');
          on401(context);
        }
      },
    );
  }

  loadAllInnovative() async {
    await _networkCalls.allInnovative(
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            // _isLoading = false;
            _academyModel = event;
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

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        if (mounted) {
          widget.academyInnovative ? loadAcademies() : loadAllInnovative();
        }
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
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;
    return _isLoading
        ? _buildShimmer(sizeWidth, sizeHeight)
        : _internet
            ? Scaffold(
                backgroundColor: AppColors.black,
                appBar: appBarWidget(
                    sizeWidth: sizeWidth,
                    sizeHeight: sizeHeight,
                    context: context,
                    title: widget.academyInnovative
                        ? AppLocalizations.of(context)!.academy
                        : AppLocalizations.of(context)!.innovative,
                    back: true),
                body: _academyModel != null
                    ? widget.academyInnovative
                        ? AcademyList(
                            text: AppLocalizations.of(context)!.academy,
                            academyDetail: _academyModel,
                            tagForView: false,
                          )
                        : InnovativeList(
                            ///Just Remove To Proceed
                            // empty: true,
                            text: AppLocalizations.of(context)!.innovative,
                            tagForView: false,
                            empty: false,
                            innovativeDetail: _academyModel,
                          )
                    : widget.academyInnovative
                        ? AcademyList(
                            text: AppLocalizations.of(context)!.academy,
                            academyDetail: _academyModel,
                            tagForView: false,
                            empty: true,
                          )
                        : InnovativeList(
                            ///Just Remove To Proceed
                            // empty: true,
                            text: AppLocalizations.of(context)!.innovative,
                            empty: true,
                            tagForView: false,
                            innovativeDetail: _academyModel,
                          ))
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadAcademies();
                    }
                  });
                },
              );
  }

  void navigateToDetail3(dynamic bookPitchData) {
    Navigator.pushNamed(context, RouteNames.bookPitch,
        arguments: bookPitchData);
  }

  Widget _buildShimmer(sizeWidth, sizeHeight) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: PreferredSize(
          preferredSize: Size(sizeWidth, sizeHeight * 0.105),
          child: AppBar(
              title: Text(
                widget.academyInnovative
                    ? AppLocalizations.of(context)!.academy
                    : AppLocalizations.of(context)!.innovative,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.white),
              ),
              centerTitle: true,
              backgroundColor: AppColors.black,
              leadingWidth: sizeWidth * 0.13,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                    height: sizeHeight * 0.03,
                    child: Image.asset(
                      'assets/images/back.png',
                      color: AppColors.white,
                    )),
              )),
        ),
        body: Container(
          height: sizeHeight,
          decoration: BoxDecoration(
              color: MyAppState.mode == ThemeMode.light
                  ? AppColors.white
                  : const Color(0xff5A5C60),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.only(
                left: sizeWidth * .04,
                right: sizeWidth * .04,
                top: sizeHeight * .03),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: sizeHeight * 0.03),
                        child: Container(
                          padding: EdgeInsets.only(bottom: sizeHeight * 0.03),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0f050818),
                                offset: Offset(10, 40),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(bottom: sizeHeight * 0.02),
                                width: sizeWidth,
                                height: sizeHeight * 0.1,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.asset('assets/images/T.png')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: sizeHeight * 0.001,
                                    bottom: sizeHeight * 0.001),
                                child: Text(
                                  'name',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 1.25,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: sizeHeight * 0.017,
                                        left: sizeHeight * 0.017),
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      'assets/images/icon-kVX.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .showDirections,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3846153846,
                                      color: const Color(0xff686868),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

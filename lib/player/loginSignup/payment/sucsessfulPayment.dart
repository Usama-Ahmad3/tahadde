import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/HomeAcademyOwnerScreen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/playerHomeScreen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';

class PaymentSuccess extends StatefulWidget {
  List<Map> price;
  bool navigateFromInnovative;
  PaymentSuccess(
      {super.key, required this.price, this.navigateFromInnovative = false});
  @override
  // ignore: library_private_types_in_public_api
  _PaymentSuccess createState() => _PaymentSuccess();
}

class _PaymentSuccess extends State<PaymentSuccess> {
  List<Map> academyDetail = [];
  // _PaymentSuccess(this.price,this._isLoading);
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late bool internet;
  late Map profileDetail;
  bool _isLoading = true;
  final NetworkCalls _networkCalls = NetworkCalls();

  loadProfile() {
    _networkCalls.getProfile(
      onSuccess: (msg) {
        setState(() {
          profileDetail = msg;
          _isLoading = false;
        });
      },
      onFailure: (msg) {},
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  loadStatus() {
    _isLoading = false;
    setState(() {});
    // _networkCalls.transectionStatus(
    //     onSuccess: (result) {
    //       setState(() {
    //         price["status"] =
    //             result["Data"]["InvoiceTransactions"][0]['TransactionStatus'];
    //         _isLoading = false;
    //         if (result["Data"]["InvoiceTransactions"][0]['TransactionStatus'] ==
    //             "InProgress") {
    //           loadStatus();
    //         }
    //       });
    //     },
    //     onFailure: (msg) {
    //       showMessage(msg);
    //     },
    //     paymentId: paymentId);
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;

    return _isLoading
        ? Scaffold(
            backgroundColor: MyAppState.mode == ThemeMode.light
                ? Colors.white
                : AppColors.darkTheme,
            bottomNavigationBar: Container(
              height: sizeheight * .1,
              width: sizewidth,
              color: const Color(0XFF25A163),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.bookingSummary,
                style: const TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            body: SizedBox(
              height: sizeheight,
              width: sizewidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 15,
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: sizeheight * .4,
                        width: sizewidth * .8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Container(
                          height: 25,
                          width: sizewidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                        ),
                      )),
                  Flexible(
                    flex: 20,
                    child: Container(),
                  ),
                ],
              ),
            ))
        : internet
            ? WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    backgroundColor: MyAppState.mode == ThemeMode.light
                        ? AppColors.white
                        : AppColors.darkTheme,
                    body: SizedBox(
                      height: sizeheight,
                      width: sizewidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            flex: 15,
                            child: Container(),
                          ),
                          // price["status"] == "Success"?
                          SizedBox(
                            child: Lottie.asset(
                              'assets/lottiefiles/successe.json',
                              height: sizeheight * .4,
                              width: sizewidth * .7,
                            ),
                          ),
                          // : Lottie.asset(
                          //     'assets/lottiefiles/pandingpayment.json',
                          //     height: sizeheight * .4,
                          //     width: sizewidth * .7),

                          //Text(AppLocalizations.of(context).resetPassword,style: TextStyle(color: Color(0XFF2F2F2F),fontSize: 18,fontWeight: FontWeight.w600),),
                          InkWell(
                            onTap: () {
                              print(widget.price);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizewidth * .146,
                                  right: sizewidth * .146),
                              child: Text(
                                widget.navigateFromInnovative
                                    ? AppLocalizations.of(context)!
                                        .paymentSuccessfullyInnovative
                                    : AppLocalizations.of(context)!
                                        .paymentSuccessfully,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? Color(0XFF898989)
                                        : AppColors.white),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 20,
                            child: Container(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizewidth * 0.05),
                            child: ButtonWidget(
                                onTaped: () {
                                  navigateToDetail();
                                },
                                title: Text(
                                    widget.navigateFromInnovative
                                        ? AppLocalizations.of(context)!
                                            .gotoHomepage
                                        : AppLocalizations.of(context)!
                                            .bookingSummary,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.white)),
                                isLoading: false),
                          )
                        ],
                      ),
                    )),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    internet = msg;
                    if (msg == true) {
                      loadStatus();
                    } else {
                      setState(() {});
                    }
                  });
                },
              );
  }

  void navigateToDetail() {
    widget.price.forEach((element) {
      var detail = {
        "status": element["status"],
        "price": element["price"],
        "AcademyName": element["AcademyName"],
        "transactionId": element["tranjectionId"],
        "startingDate": element["startingDate"],
        'sessions': element['sessions'],
        "email": element["email"],
        "booked_date": element["booked_date"],
      };
      academyDetail.add(detail);
    });
    print('shddsjs');
    print(widget.price);
    //Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: CarouselDemo (index: 2,)));
    if (widget.navigateFromInnovative) {
      profileDetail['role'] == 'player'
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayerHomeScreen(index: 0),
              ))
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeAcademyOwnerScreen(index: 0),
              ));
    } else {
      Navigator.pushNamed(context, RouteNames.bookingSummary,
          arguments: widget.price);
    }
  }
}

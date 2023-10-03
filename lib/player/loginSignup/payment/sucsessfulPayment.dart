import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';

class PaymentSuccess extends StatefulWidget {
  var price;
  PaymentSuccess({super.key, this.price});
  @override
  _PaymentSuccess createState() => _PaymentSuccess(price);
}

class _PaymentSuccess extends State<PaymentSuccess> {
  var price;
  // _PaymentSuccess(this.price,this._isLoading);
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late bool internet;
  bool _isLoading = true;
  final NetworkCalls _networkCalls = NetworkCalls();

  _PaymentSuccess(price);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadStatus();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  loadStatus() {
    Map paymentId = {"payment_id": price["tranjectionId"]};
    _networkCalls.transectionStatus(
        onSuccess: (result) {
          setState(() {
            price["status"] =
                result["Data"]["InvoiceTransactions"][0]['TransactionStatus'];
            _isLoading = false;
            if (result["Data"]["InvoiceTransactions"][0]['TransactionStatus'] ==
                "InProgress") {
              loadStatus();
            }
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        paymentId: paymentId);
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;

    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
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
                children: <Widget>[
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
                    backgroundColor: Colors.white,
                    bottomNavigationBar: GestureDetector(
                      onTap: () {
                        navigateToDetail();
                      },
                      child: Container(
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
                    ),
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
                          price["status"] == "Success"
                              ? Lottie.asset('assets/lottiefiles/success.json',
                                  height: sizeheight * .4,
                                  width: sizewidth * .7)
                              : Lottie.asset(
                                  'assets/lottiefiles/pandingpayment.json',
                                  height: sizeheight * .4,
                                  width: sizewidth * .7),

                          //Text(AppLocalizations.of(context).resetPassword,style: TextStyle(color: Color(0XFF2F2F2F),fontSize: 18,fontWeight: FontWeight.w600),),
                          Padding(
                            padding: EdgeInsets.only(
                                left: sizewidth * .146,
                                right: sizewidth * .146),
                            child: Text(
                              AppLocalizations.of(context)!.paymentSuccessfully,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Color(0XFF898989)),
                            ),
                          ),
                          Flexible(
                            flex: 20,
                            child: Container(),
                          ),
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
    var detail = {
      "status": price["status"],
      "price": widget.price["price"],
      "venueName": widget.price["venueName"],
      "name": widget.price["name"],
      "tranjectionId": widget.price["tranjectionId"],
      "startingDate": widget.price["startingDate"],
      "pitchtype": widget.price["pitchtype"],
      "email": widget.price["email"],
      "teamId": widget.price["teamId"],
    };
    //Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: CarouselDemo (index: 2,)));
    Navigator.pushNamed(context, RouteNames.bookingSummary, arguments: detail);
  }
}

import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/cardDetail.dart';
import '../../../network/network_calls.dart';

class Payment extends StatefulWidget {
  dynamic detail;

  Payment({this.detail});

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String? baseUrl;
  late String mAPIKey;
  List<PaymentMethods> paymentMethods = [];
  var tranjectionId;
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;
  int? paymentMethodId;
  bool visibilityObs = false;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final CoustmerDetail _detail = CoustmerDetail();
  late CardDetail cardDetail;
  late bool internet;
  var detail;
  bool _isLoading = true;
  final NetworkCalls _networkCalls = NetworkCalls();
  Map? profileDetail;

  void setPaymentMethodSelected(int index, bool value) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = value;
        if (value) {
          selectedPaymentMethodIndex = index;
          paymentMethodId = paymentMethods[index].paymentMethodId;
          visibilityObs = true;
        } else {
          selectedPaymentMethodIndex = -1;
          visibilityObs = false;
        }
      } else {
        isSelected[i] = false;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        _networkCalls.getProfile(
          onSuccess: (msg) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _detail.firstName = msg['first_name'] ?? '';
                _detail.countryCode = msg["countryCode"];
                _detail.lastName = msg['last_name'] ?? '';
                _detail.phoneNumber = msg['contact_number'] ?? '';
                _detail.email = msg['email'];
                loadToken();
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
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  loadToken() {
    _networkCalls.transectionToken(onSuccess: (msg) {
      mAPIKey = "bearer ${msg["bearer_token"]}";
      print("TokenBearer${msg["bearer_token"]}");
      baseUrl = msg["myfatoorah_base_url"];
      print("Url${msg['myfatoorah_base_url']}");
      // MFSDK.init(mAPIKey, msg, msg["myfatoorah_base_url"]);
      MFSDK.init(
          mAPIKey,
          MFCountry.UNITED_ARAB_EMIRATES,
          // RestApis.BASE_URL == "https://powerhouse.tahadde.ae" ?
          MFEnvironment.LIVE
          // : MFEnvironment.TEST
          );
      initiatePayment();
    }, onFailure: (msg) {
      print('msg$msg');
      showMessage(msg);
    });
  }

  void initiatePayment() {
    var request = MFInitiatePaymentRequest(
        double.parse(widget.detail["price"].toString()), MFCurrencyISO.UAE_AED);
    MFSDK.setUpAppBar(
        title: AppLocalizations.of(context)!.payment,
        //titleColor: Colors.white, // Color(0xFFFFFFFF)
        backgroundColor: const Color(0XFF032040), // Color(0xFF000000)
        isShowAppBar: true);

    MFSDK.initiatePayment(
        request,
        AppLocalizations.of(context)!.locale == "en"
            ? MFAPILanguage.EN
            : MFAPILanguage.AR,
        (MFResult<MFInitiatePaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print(
                        "Result ${result.response!.toJson()}"); //result.response.toJson().toString();
                    paymentMethods.addAll(result.response!.paymentMethods!);
                    for (int i = 0; i < paymentMethods.length; i++) {
                      isSelected.add(false);
                    }
                    _isLoading = false;
                  })
                }
              else
                {
                  showMessage(result.error!.message.toString()),
                  print("Try${result.error!.message.toString()}")
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            appBar: appBar(
              title: AppLocalizations.of(context)!.selectPaymentMethod,
              language: AppLocalizations.of(context)!.locale,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            body: Container(
              height: sizeheight,
              width: sizewidth,
              color: const Color(0XFFF0F0F0),
              child: Padding(
                  padding: EdgeInsets.only(
                      left: sizewidth * .05, right: sizewidth * .05),
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      })),
            ))
        : internet
            ? Scaffold(
                appBar: appBar(
                  title: AppLocalizations.of(context)!.selectPaymentMethod,
                  language: AppLocalizations.of(context)!.locale,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                bottomNavigationBar: visibilityObs
                    ? Container(
                        height: sizeheight * .09,
                        color: const Color(0XFF25A163),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${AppLocalizations.of(context)!.currency} ${widget.detail["price"]}',
                                  style: const TextStyle(
                                      color: Color(0XFFFFFFFF), fontSize: 20),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                _networkCalls.checkInternetConnectivity(
                                    onSuccess: (msg) {
                                  if (msg) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    _networkCalls.checkInternetConnectivity(
                                        onSuccess: (msg) {
                                      if (msg) {
                                        executeRegularPayment();
                                      } else {
                                        if (mounted) {
                                          showMessage(
                                              AppLocalizations.of(context)!
                                                  .noInternetConnection);
                                        }
                                      }
                                    });
                                  } else {
                                    if (mounted) {
                                      showMessage(AppLocalizations.of(context)!
                                          .noInternetConnection);
                                    }
                                  }
                                });

                                //navigateToDetail();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0XFFFFFFFF),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                ),
                                height: sizeheight * .04,
                                width: sizewidth * .3,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.payNow,
                                  style:
                                      const TextStyle(color: Color(0XFF25A163)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        height: 1,
                      ),
                body: Container(
                  height: sizeheight,
                  width: sizewidth,
                  color: const Color(0XFFF0F0F0),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: sizewidth * .05, right: sizewidth * .05),
                      child: ListView.builder(
                          itemCount: paymentMethods.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return !paymentMethods[index].isDirectPayment!
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        isSelected[index] = !isSelected[index];
                                        setState(() {
                                          setPaymentMethodSelected(
                                              index, isSelected[index]);
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: isSelected[index]
                                              ? const Color(0XFF25A163)
                                              : Colors.grey.withOpacity(.3),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0) //
                                                          ),
                                                ),
                                                child: ClipRRect(
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                  child: cachedNetworkImage(
                                                      width: 55.0,
                                                      height: 35.0,
                                                      cuisineImageUrl:
                                                          paymentMethods[index]
                                                              .imageUrl),
                                                )),
                                            // Padding(
                                            //     padding:
                                            //         const EdgeInsets.all(8.0),
                                            //     child: cachedNetworkImage(
                                            //       width: 40.0,
                                            //       height: 40.0,
                                            //       cuisineImageUrl:
                                            //           paymentMethods[index]
                                            //               ?.imageUrl,
                                            //     )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? Text(
                                                    paymentMethods[index]
                                                        .paymentMethodEn
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  )
                                                : Text(
                                                    paymentMethods[index]
                                                        .paymentMethodAr
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                            Flexible(
                                              flex: 1,
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
                          })),
                ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    internet = msg;
                    if (msg == true) {
                      loadToken();
                    }
                  });
                },
              );
  }

  void executeRegularPayment() {
    var request = MFExecutePaymentRequest(
      paymentMethodId!,
      double.parse(widget.detail["price"].toString()),
      // _detail.email,
      // _detail.phoneNumber,
      // "${_detail.firstName} ${_detail.lastName}",
      // _detail.countryCode
    );

    var mfCardInfo = MFCardInfo(cardToken: mAPIKey);
    bool paymentStatus(String paymentStatusResult) {
      if (paymentStatusResult == "Success") {
        return true;
      } else if (paymentStatusResult == "InProgress") {
        return true;
      } else {
        return false;
      }
    }

    MFSDK.executePayment(
      context,
      request,
      AppLocalizations.of(context)!.locale == "en"
          ? MFAPILanguage.EN
          : MFAPILanguage.AR,
      onPaymentResponse:
          (String? invoiceId, MFResult<MFPaymentStatusResponse> result) {
        if (result.isSuccess()) {
          ///debugShowhowMessage(result.response.toJson().toString(), scaffoldkey,duration:  Duration(hours: 1)),
          tranjectionId = result.response!.toJson();
          if (paymentStatus(
              tranjectionId["InvoiceTransactions"][0]['TransactionStatus'])) {
            setState(() {
              String pitchDetail = widget.detail["ids"].toString();
              Map tarnsectiondetail = {
                "transactionId": tranjectionId["InvoiceTransactions"][0]
                        ['PaymentId']
                    .toString(),
                "transactionMadeon": tranjectionId["InvoiceTransactions"][0]
                        ['TransactionDate']
                    .toString(),
                "payment_id": tranjectionId["InvoiceTransactions"][0]
                        ['PaymentId']
                    .toString(),
                "booked_for_date": widget.detail["apidetail"]["date"],
                "slot_ids_list": widget.detail["apidetail"]["id"],
                "pitchtype_id": widget.detail["subPitchId"],
                "player_count": widget.detail["player_count"]
              };
              _networkCalls.transection(
                id: pitchDetail,
                tarnsectiondetail: tarnsectiondetail,
                bookingPer: widget.detail["slug"],
                onSuccess: (value) {
                  showMessage(value);
                  navigateToPaymentSuccess(tranjectionId["InvoiceTransactions"]
                      [0]['TransactionStatus']);
                  Map detail = {
                    "pitchtype_id": widget.detail["subPitchId"],
                    "booked_for_date": widget.detail["apidetail"]["date"],
                    "slot_ids_list": widget.detail["apidetail"]["id"],
                    "player_count": widget.detail["player_count"]
                  };
                  _networkCalls.bookpitchSlotConferm(
                    urlDetail: detail,
                    slug: widget.detail["slug"],
                    onSuccess: (value) {
                      navigateToPaymentSuccess(
                          tranjectionId["InvoiceTransactions"][0]
                              ['TransactionStatus']);
                    },
                    onFailure: (msg) {
                      showMessage(msg);
                    },
                    tokenExpire: () {
                      if (mounted) on401(context);
                    },
                  );
                },
                onFailure: (msg) {
                  showMessage(msg);
                },
                tokenExpire: () {
                  if (mounted) on401(context);
                },
              );
              // _response = result.response.toJson().toString();
            });
          } else {
            setState(() {
              showMessage(
                tranjectionId["InvoiceTransactions"][0]['TransactionStatus'],
              );
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            print(invoiceId);
            print(result.error!.toJson());
            // _response = result.error.message;
            showMessage(result.error!.message.toString());
            _isLoading = false;
          });
        }
      },
    );
  }

  void navigateToPaymentSuccess(String status) {
    var detail = {
      "price": widget.detail["price"],
      "venueName": widget.detail["name"],
      "status": status,
      "tranjectionId": tranjectionId["InvoiceTransactions"][0]['PaymentId'],
      "name": widget.detail["detail"],
      "startingDate": widget.detail["startingDate"],
      "pitchtype": widget.detail["pitchtype"],
      "email": "xyz",
    };
    Navigator.pushNamed(
      context,
      RouteNames.paymentSuccess,
      arguments: detail,
    );
  }

  void navigateToDetail(Map detail) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, RouteNames.bookPitchSlot,
        arguments: detail);
  }
}

class CoustmerDetail {
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;

  CoustmerDetail(
      {this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.countryCode});
}

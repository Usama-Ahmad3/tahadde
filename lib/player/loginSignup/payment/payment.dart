import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import "package:myfatoorah_flutter/utils/MFCountry.dart";
import "package:myfatoorah_flutter/utils/MFEnvironment.dart";
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../main.dart';
import '../../../modelClass/cardDetail.dart';
import '../../../network/network_calls.dart';
import '../../../newStructure/view/player/HomeScreen/widgets/app_bar.dart';

// ignore: must_be_immutable
class Payment extends StatefulWidget {
  List<Map> detail;

  Payment({super.key, required this.detail});

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
  List<Map> academyDetail = [];
  late bool internet;
  var detail;
  bool _isLoading = true;
  final NetworkCalls _networkCalls = NetworkCalls();
  Map? profileDetail;

  void setPaymentMethodSelected(int index, bool value) {
    print('setPaymentMethod');
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
      // print("TokenBearer${msg["bearer_token"]}");
      baseUrl = msg["myfatoorah_base_url"];
      // print("Url${msg['myfatoorah_base_url']}");
      // MFSDK.init(mAPIKey, msg, msg["myfatoorah_base_url"]);
      MFSDK.init(
          'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
          MFCountry.KUWAIT,
          // RestApis.BASE_URL == "https://powerhouse.tahadde.ae" ?
          MFEnvironment.TEST
          // : MFEnvironment.TEST
          );
      initiatePayment();
    }, onFailure: (msg) {
      print('msg$msg');
      showMessage(msg);
    });
  }

  void initiatePayment() {
    print('initial payment');
    var request = MFInitiatePaymentRequest(
        double.parse(widget.detail[0]["totalPrice"].toString()),
        MFCurrencyISO.UAE_AED);
    MFSDK.setUpAppBar(
        title: AppLocalizations.of(context)!.payment,
        //titleColor: Colors.white, // Color(0xFFFFFFFF)
        backgroundColor: AppColors.themeColor, // Color(0xFF000000)
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
            backgroundColor: AppColors.black,
            appBar: appBarWidget(
                sizeWidth: sizewidth,
                sizeHeight: sizeheight,
                context: context,
                title: AppLocalizations.of(context)!.selectPaymentMethod,
                back: true),
            body: Container(
              height: sizeheight,
              width: sizewidth,
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? const Color(0XFFF0F0F0)
                      : AppColors.darkTheme,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizewidth * .059),
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
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        );
                      })),
            ))
        : internet
            ? Scaffold(
                backgroundColor: AppColors.black,
                appBar: appBarWidget(
                    sizeWidth: sizewidth,
                    sizeHeight: sizeheight,
                    context: context,
                    title: AppLocalizations.of(context)!.selectPaymentMethod,
                    back: true),
                resizeToAvoidBottomInset: true,
                body: Container(
                  height: sizeheight,
                  width: sizewidth,
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? const Color(0XFFF0F0F0)
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: sizewidth * .05, right: sizewidth * .05),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: paymentMethods.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return !paymentMethods[index].isDirectPayment!
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: GestureDetector(
                                            onTap: () {
                                              isSelected[index] =
                                                  !isSelected[index];
                                              setState(() {
                                                setPaymentMethodSelected(
                                                    index, isSelected[index]);
                                              });
                                            },
                                            child: Container(
                                              height: sizeheight * 0.07,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: isSelected[index]
                                                    ? AppColors.appThemeColor
                                                    : MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? AppColors.grey
                                                            .withOpacity(.3)
                                                        : AppColors
                                                            .containerColorW12,
                                              ),
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0) //
                                                                ),
                                                      ),
                                                      child: ClipRRect(
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    5.0)),
                                                        child: cachedNetworkImage(
                                                            width: 55.0,
                                                            height: 35.0,
                                                            cuisineImageUrl:
                                                                paymentMethods[
                                                                        index]
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
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: MyAppState
                                                                              .mode ==
                                                                          ThemeMode
                                                                              .light
                                                                      ? Colors
                                                                          .black
                                                                      : AppColors
                                                                          .white),
                                                        )
                                                      : Text(
                                                          paymentMethods[index]
                                                              .paymentMethodAr
                                                              .toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: MyAppState
                                                                              .mode ==
                                                                          ThemeMode
                                                                              .light
                                                                      ? AppColors
                                                                          .black
                                                                      : AppColors
                                                                          .white),
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
                                }),
                          ),
                          visibilityObs
                              ? ButtonWidget(
                                  onTaped: () {},
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${AppLocalizations.of(context)!.currency} ${widget.detail[0]["totalPrice"]}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: Color(0XFFFFFFFF),
                                                ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _networkCalls
                                              .checkInternetConnectivity(
                                                  onSuccess: (msg) {
                                            if (msg) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              _networkCalls
                                                  .checkInternetConnectivity(
                                                      onSuccess: (msg) {
                                                if (msg) {
                                                  executeRegularPayment();
                                                } else {
                                                  if (mounted) {
                                                    showMessage(AppLocalizations
                                                            .of(context)!
                                                        .noInternetConnection);
                                                  }
                                                }
                                              });
                                            } else {
                                              if (mounted) {
                                                showMessage(AppLocalizations.of(
                                                        context)!
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
                                          width: sizewidth * .25,
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .payNow,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color:
                                                        AppColors.barLineColor),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  isLoading: _isLoading)
                              : Container(
                                  height: 1,
                                ),
                        ],
                      )),
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
    print('payment Execute');
    var request = MFExecutePaymentRequest(
      paymentMethodId!,
      double.parse(widget.detail[0]["totalPrice"].toString()),
      // _detail.email,
      // _detail.phoneNumber,
      // "${_detail.firstName} ${_detail.lastName}",
      // _detail.countryCode
    );

    var mfCardInfo = MFCardInfo(cardToken: mAPIKey);
    bool paymentStatus(String paymentStatusResult) {
      print('paymentCheck$paymentStatusResult');
      if (paymentStatusResult == "Success") {
        print('kajsjsj');
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
          print('kuch TO Hai $result');

          ///debugShowhowMessage(result.response.toJson().toString(), scaffoldkey,duration:  Duration(hours: 1)),
          tranjectionId = result.response!.toJson();
          if (tranjectionId["InvoiceTransactions"][0]['TransactionStatus'] ==
              'Succss') {
            print('tarnsasb$tranjectionId');
            setState(() {
              // String pitchDetail = widget.detail["ids"].toString();
              List<Map> transactionDetail = [];
              widget.detail.forEach((element) {
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
                  "booked_for_date": element["apidetail"],
                  "player_count": element["player_count"]
                };
                transactionDetail.add(tarnsectiondetail);
              });
              print('Transaction Detail $transactionDetail');
              widget.detail.forEach((element) {
                Map detailPost = {
                  "price": element["price"],
                  "academy": element['academy_id'],
                  "player": element['id'],
                  "payment_status": true,
                  "transaction_id": tranjectionId["InvoiceTransactions"][0]
                      ['PaymentId'],
                  "player_count": element['player_count'],
                  "booking_date": DateTime.now().day > 10
                      ? tranjectionId["InvoiceTransactions"][0]
                              ['TransactionDate']
                          .toString()
                          .substring(0, 10)
                      : tranjectionId["InvoiceTransactions"][0]
                              ['TransactionDate']
                          .toString()
                          .substring(0, 10),
                  'booked_date': element["apidetail"],
                  "booked_session": element['sessionId'],
                  "location": element['location'],
                  "currency": "AED",
                };
                var detial = {
                  'totalPrice': element['totalPrice'],
                  'cart_id': element['cart_id'],
                  "price": element["price"],
                  "name": element["name"],
                  'academy_id': element['academy'],
                  "detail": element['detail'],
                  "apidetail": element["apidetail"],
                  "id": element['id'],
                  'location': element['location'],
                };
                print('detailPost');
                print(detailPost);
                _networkCalls.confirmBooking(
                  transactionDetail: detailPost,
                  onSuccess: (value) {
                    // showMessage(value);
                    print('Transactionvalue$value');
                    navigateToPaymentSuccess(
                      tranjectionId["InvoiceTransactions"][0]
                          ['TransactionStatus'],
                      detailPost['booking_date'],
                      // DateTime.now().day > 10
                      //     ? tranjectionId["InvoiceTransactions"][0]
                      //             ['TransactionDate']
                      //         .toString()
                      //         .substring(0, 9)
                      //     : tranjectionId["InvoiceTransactions"][0]
                      //             ['TransactionDate']
                      //         .toString()
                      //         .substring(0, 10),
                      detial,
                    );
                    // Map detail = {
                    //   "pitchtype_id": widget.detail["subPitchId"],
                    //   "booked_for_date": widget.detail["apidetail"]["date"],
                    //   "slot_ids_list": widget.detail["apidetail"]["id"],
                    //   "player_count": widget.detail["player_count"]
                    // };
                    // _networkCalls.bookpitchSlotConferm(
                    //   urlDetail: detail,
                    //   slug: widget.detail["slug"],
                    //   onSuccess: (value) {
                    //     navigateToPaymentSuccess(
                    //         tranjectionId["InvoiceTransactions"][0]
                    //         ['TransactionStatus']);
                    //   },
                    //   onFailure: (msg) {
                    //     print('maksj$msg');
                    //     showMessage(msg);
                    //   },
                    //   tokenExpire: () {
                    //     if (mounted) on401(context);
                    //   },
                    // );
                  },
                  onFailure: (msg) {
                    print('failed $msg');
                    showMessage(msg);
                  },
                  tokenExpire: () {
                    if (mounted) on401(context);
                  },
                );
              });
              print('academyDetail');
              print(academyDetail);
              Navigator.pushNamed(
                context,
                RouteNames.paymentSuccess,
                arguments: academyDetail,
              );

              ///clear
              // _networkCalls.transection(
              //   id: pitchDetail,
              //   tarnsectiondetail: tarnsectiondetail,
              //   bookingPer: widget.detail["slug"],
              //   onSuccess: (value) {
              //     showMessage(value);
              //     print('Transactionvalue$value');
              //     navigateToPaymentSuccess(tranjectionId["InvoiceTransactions"]
              //     [0]['TransactionStatus']);
              //     Map detail = {
              //       "pitchtype_id": widget.detail["subPitchId"],
              //       "booked_for_date": widget.detail["apidetail"]["date"],
              //       "slot_ids_list": widget.detail["apidetail"]["id"],
              //       "player_count": widget.detail["player_count"]
              //     };
              //     _networkCalls.bookpitchSlotConferm(
              //       urlDetail: detail,
              //       slug: widget.detail["slug"],
              //       onSuccess: (value) {
              //         navigateToPaymentSuccess(
              //             tranjectionId["InvoiceTransactions"][0]
              //             ['TransactionStatus']);
              //       },
              //       onFailure: (msg) {
              //         print('maksj$msg');
              //         showMessage(msg);
              //       },
              //       tokenExpire: () {
              //         if (mounted) on401(context);
              //       },
              //     );
              //   },
              //   onFailure: (msg) {
              //     print('failed $msg');
              //     showMessage(msg);
              //   },
              //   tokenExpire: () {
              //     if (mounted) on401(context);
              //   },
              // );
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
            print('result Is not Seccess');
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

  void navigateToPaymentSuccess(
      String status, String bookingDate, Map element) {
    print('kkkkkkkkkkkkkkkkk');
    _networkCalls.deleteCart(
      id: element['cart_id'].toString(),
      onSuccess: (value) {
        var detail = {
          'totalPrice': element['totalPrice'],
          "price": element["price"],
          "AcademyName": element["name"],
          "status": status,
          "tranjectionId": tranjectionId["InvoiceTransactions"][0]['PaymentId'],
          "sessions": element["detail"],
          "startingDate": bookingDate,
          "playerId": element["id"],
          'booked_date': element['apidetail'],
          "email": _detail.email,
          "location": element['location'],
          "currency": "AED",
        };
        print('aaaaaaaaaaaa');
        academyDetail.add(detail);
        print(academyDetail);
      },
      onFailure: (msg) {
        print('failed $msg');
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
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

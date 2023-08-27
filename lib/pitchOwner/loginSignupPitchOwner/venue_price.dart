import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../drop_down_file.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';

class VenuePrice extends StatefulWidget {
  const VenuePrice({Key? key}) : super(key: key);

  @override
  _VenuePriceState createState() => _VenuePriceState();
}

class _VenuePriceState extends State<VenuePrice>
    with AutomaticKeepAliveClientMixin {
  late int indexItem;
  int pitchTypeIndex = 1;
  late String _price;
  var focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _pitchType = [
    '1x1',
    '2x2',
    '3x3',
    '4x4',
    '5x5',
    '6x6',
    '7x7',
    '8x8',
    "9x9",
    '10x10'
  ];
  final List<String> _numberPlayerList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    "9",
    '10'
  ];
  final List<VenueDetail> _venueList = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: const Color(0XFFE5E5E5),
      child: _venueList.isEmpty
          ? Container(
              margin: const EdgeInsets.only(top: 60),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Add Venue Price",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffA3A3A3)),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        bottomSheet(onTap: () {
                          setState(() {});
                        });
                      },
                      child: Image.asset("assets/images/add_venue.png")),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    height: size.height * .1,
                    width: size.height,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Add Venue Price",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffA3A3A3)),
                          ),
                          GestureDetector(
                              onTap: () {
                                bottomSheet(onTap: () {
                                  setState(() {});
                                });
                              },
                              child:
                                  Image.asset("assets/images/add_venue.png")),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _venueList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * .01),
                            child: Container(
                              color: Colors.white,
                              child: Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  setState(() {
                                    _venueList.removeAt(index);
                                  });
                                },
                                background: Container(
                                  color: const Color(0XFFFFE9E9),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      flaxibleGap(
                                        10,
                                      ),
                                      Image.asset(
                                        "assets/images/delete_icon.png",
                                        color: Colors.red,
                                        height: 20,
                                        width: 20,
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  height: size.height * .1,
                                  width: size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Venue Price : ",
                                            style: TextStyle(
                                                color: Color(0XFFA3A3A3),
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: "Poppins"),
                                          ),
                                          Text(
                                            "${_venueList[index].price} AED",
                                            style: const TextStyle(
                                                color: appThemeColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(_venueList[index].pitchType!,
                                              style: const TextStyle(
                                                  color: appThemeColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Poppins")),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              const Text(
                                                "Max number of Players : ",
                                                style: TextStyle(
                                                    color: Color(0XFFA3A3A3),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: "Poppins"),
                                              ),
                                              Text(
                                                _venueList[index].playerNumber!,
                                                style: const TextStyle(
                                                    color: appThemeColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
              ],
            ),
    );
  }

  bottomSheet({required Function onTap}) {
    var size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return FractionallySizedBox(
                heightFactor: .98,
                child: Scaffold(
                  appBar: appBar(
                      title: "Venue Price",
                      language: AppLocalizations.of(context)!.locale,
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  bottomNavigationBar: indexItem != null
                      ? Material(
                          color: const Color(0XFF25A163),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _venueList.add(VenueDetail(
                                    pitchType: _pitchType[pitchTypeIndex],
                                    playerNumber: _numberPlayerList[indexItem],
                                    price: _price));
                                Navigator.of(context).pop();
                                onTap();
                              }
                            },
                            splashColor: Colors.black,
                            child: Container(
                                height: size.height * .104,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.continueW,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white),
                                )),
                          ),
                        )
                      : Container(
                          height: size.height * .104,
                          color: const Color(0XFFBCBCBC),
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.continueW,
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                  body: Container(
                    color: const Color(0XFFE5E5E5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: size.height * .005,
                                width: size.width * .19,
                                color: const Color(0XFF25A163),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Container(
                                height: size.height * .005,
                                width: size.width * .19,
                                color: const Color(0XFF25A163),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Container(
                                height: size.height * .005,
                                width: size.width * .19,
                                color: const Color(0XFF25A163),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Container(
                                height: size.height * .005,
                                width: size.width * .19,
                                color: const Color(0XFFCBCBCB),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Container(
                                height: size.height * .005,
                                width: size.width * .19,
                                color: const Color(0XFFCBCBCB),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * .42,
                                height: size.height * .1,
                                child: CustomDropdown(
                                  key: scaffoldKey,
                                  leadingIcon: false,
                                  icon: Image.asset(
                                    "assets/images/drop_down.png",
                                    height: 8,
                                  ),
                                  onChange: (int value, int index) =>
                                      setState(() {
                                    pitchTypeIndex = index;
                                  }),
                                  dropdownButtonStyle:
                                      const DropdownButtonStyle(
                                    width: 170,
                                    height: 45,
                                    elevation: 1,
                                    backgroundColor: Colors.white,
                                    primaryColor: Colors.black87,
                                  ),
                                  dropdownStyle: DropdownStyle(
                                    borderRadius: BorderRadius.circular(0),
                                    elevation: 6,
                                    padding: const EdgeInsets.all(5),
                                  ),
                                  items: _pitchType
                                      .asMap()
                                      .entries
                                      .map(
                                        (item) => DropdownItem(
                                          key: scaffoldKey,
                                          value: item.key + 1,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(item.value),
                                                  ],
                                                ),
                                                const Divider()
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  child: const Text(
                                    '1X1',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Form(
                                key: _formKey,
                                child: Container(
                                    height: size.height * .1,
                                    width: size.width * .55,
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        focusNode: focusNode,
                                        textAlign: TextAlign.right,
                                        autofocus: true,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(0),
                                          prefix: Text(
                                            "Amount: ",
                                            style: TextStyle(
                                                color: appThemeColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          suffix: Text(
                                            "AED",
                                            style: TextStyle(
                                                color: appThemeColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0XFF9F9F9F)),
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                        keyboardType: TextInputType.number,
                                        onSaved: (value) {
                                          _price = value!;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter amount";
                                          }
                                          return null;
                                        },
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          height: 60,
                          child: CustomDropdown(
                            key: scaffoldKey,
                            leadingIcon: false,
                            icon: Image.asset(
                              "assets/images/drop_down.png",
                              height: 8,
                            ),
                            onChange: (int value, int index) => setState(() {
                              indexItem = index;
                            }),
                            dropdownButtonStyle: const DropdownButtonStyle(
                              width: 170,
                              height: 45,
                              elevation: 1,
                              backgroundColor: Colors.white,
                              primaryColor: Colors.black87,
                            ),
                            dropdownStyle: DropdownStyle(
                              borderRadius: BorderRadius.circular(0),
                              elevation: 6,
                              padding: const EdgeInsets.all(5),
                            ),
                            items: _numberPlayerList
                                .asMap()
                                .entries
                                .map(
                                  (item) => DropdownItem(
                                    key: scaffoldKey,
                                    value: item.key + 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(item.value),
                                            ],
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            child: const Text(
                              'Max No. of Players',
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                )); //whatever you're returning, does not have to be a Container
          });
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class VenueDetail {
  final String? pitchType;
  final String? price;
  final String? playerNumber;
  VenueDetail({this.price, this.pitchType, this.playerNumber});
}

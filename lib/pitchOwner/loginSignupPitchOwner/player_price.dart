import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../drop_down_file.dart';
import '../../localizations.dart';

class PlayerPrice extends StatefulWidget {
  const PlayerPrice({Key? key}) : super(key: key);

  @override
  _PlayerPriceState createState() => _PlayerPriceState();
}

class _PlayerPriceState extends State<PlayerPrice> {
  var focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  late int indexItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: const Color(0XFFE5E5E5),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                height: size.height * .15,
                width: size.width,
                color: Colors.white,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
                        borderSide: BorderSide(color: Color(0XFF9F9F9F)),
                      ),
                    ),
                    style: const TextStyle(
                        color: Color(0XFF032040),
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter amount";
                      }
                      return null;
                    },
                  ),
                )),
            Container(
              width: size.width,
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: CustomDropdown(
                leadingIcon: false,
                icon: Image.asset(
                  "images/drop_down.png",
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
                items: ['1', '2', '3', '4', '5', '6', '7', '8', "9", '10']
                    .asMap()
                    .entries
                    .map(
                      (item) => DropdownItem(
                        key: _formKey,
                        value: item.key + 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                key: _formKey,
                child: const Text(
                  'Max No. of Players',
                ),
              ),
            ),
            const Spacer(),
            indexItem != null
                ? Material(
                    color: const Color(0XFF25A163),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
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
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../pitchOwner/loginSignupPitchOwner/select_sport.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  _SportsScreenState createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _internet = true;
  bool _isLoading = true;
  final List<SportsList> _sportsType = [];
  final List<String> _sportsTypeSlug = [];
  final List<String> _selectedSportsTypeSlug = [];
  final List<String> _modern = [];
  final List<String> _modernSlug = [];
  String? _selectedModernSlug;

  _onSelected(String slug) {
    if (_selectedSportsTypeSlug.contains(slug)) {
      setState(() {
        _selectedSportsTypeSlug.remove(slug);
      });
    } else {
      setState(() {
        _selectedSportsTypeSlug.add(slug);
      });
    }
  }

  sportsTypes() {
    _networkCalls.sportsTypes(
      onSuccess: (data) {
        if (mounted) {
          setState(() {
            for (int i = 0; i < data.length; i++) {
              _sportsType.add(SportsList(
                  name: data[i]["sport_name"],
                  nameArabic: data[i]["sport_arabic_name"],
                  slug: data[i]["sport_slug"],
                  bannerImage: data[i]["banner_image"] == null
                      ? ""
                      : data[i]["banner_image"]["filePath"],
                  image: data[i]["sport_image"] == null
                      ? ""
                      : data[i]["sport_image"]["filePath"]));
            }
            _isLoading = false;
          });
        }
      },
      onFailure: (msg) {
        if (mounted) showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  modern() {
    _networkCalls.spotsModerns(
      onSuccess: (data) {
        setState(() {
          for (int i = 0; i < data.length; i++) {
            _modern.add(data[i]["name"]);
            _modernSlug.add(data[i]["slug"]);
          }
        });
      },
      onFailure: (msg) {
        if (mounted) showMessage(msg);
      },
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
      _internet = msg;
      if (msg == true) {
        sportsTypes();
        modern();
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
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          color: const Color(0XFFFFFFFF),
          child: Column(
            children: [
              buildAppBar(
                  language: AppLocalizations.of(context)!.locale,
                  title: "Select your Sports",
                  backButton: true,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  height: sizeHeight,
                  width: sizeWidth),
              _internet
                  ? _isLoading
                      ? const Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                "Awesome, you're almost there",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                "I am interested in...",
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              _sportsType.isNotEmpty
                                  ? Wrap(
                                      spacing: 15.0,
                                      runSpacing: 10.0,
                                      children: List.generate(
                                          _sportsType.length,
                                          (index) => ChipButton(
                                              bgColor: Colors.green,
                                              textColor: Colors.white,
                                              title:
                                                  AppLocalizations.of(context)!
                                                              .locale ==
                                                          "en"
                                                      ? _sportsType[index]
                                                          .name
                                                          .toString()
                                                      : _sportsType[index]
                                                          .nameArabic
                                                          .toString(),
                                              onTap: () {
                                                _onSelected(
                                                    _sportsTypeSlug[index]);
                                              })))
                                  : const SizedBox.shrink(),
                              const SizedBox(height: 20),
                              const Text(
                                "Moderns",
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              _modern.isNotEmpty
                                  ? Wrap(
                                      spacing: 15.0,
                                      runSpacing: 10.0,
                                      children: List.generate(
                                          _modern.length,
                                          (index) => ChipButton(
                                              bgColor: _selectedModernSlug ==
                                                      _modernSlug[index]
                                                  ? appThemeColor
                                                  : Colors.green,
                                              textColor: Colors.white,
                                              title: _modern[index],
                                              onTap: () {
                                                setState(() {
                                                  _selectedModernSlug =
                                                      _modernSlug[index];
                                                });
                                              })))
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        )
                  : InternetLoss(
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
                          }
                        });
                      },
                    ),
            ],
          )),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          AppLocalizations.of(context)!.finish,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: "poppins",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class ChipButton extends StatelessWidget {
  const ChipButton(
      {Key? key,
      required this.bgColor,
      required this.textColor,
      required this.title,
      required this.onTap})
      : super(key: key);
  final Color bgColor;
  final String title;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 35.0,
        minWidth: 50.0,
        maxWidth: double.infinity,
      ),
      child: SizedBox(
        height: 33.0,
        //width: 100.0,
        child: Material(
          borderRadius: BorderRadius.circular(50.0),
          clipBehavior: Clip.hardEdge,
          color: bgColor,
          child: TextButton(
            onPressed: onTap,
            child: Text(
              title,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}

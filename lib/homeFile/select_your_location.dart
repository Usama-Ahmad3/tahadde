import 'package:flutter/material.dart';

import '../constant.dart';
import '../localizations.dart';
import '../modelClass/territory_model_class.dart';
import '../network/network_calls.dart';
import 'routingConstant.dart';
import 'utility.dart';

class SelectYourLocation extends StatefulWidget {
  SelectYourLocation();

  @override
  State<StatefulWidget> createState() {
    return _SelectYourLocationState();
  }
}

class _SelectYourLocationState extends State<SelectYourLocation> {
  final NetworkCalls _networkCalls = NetworkCalls();
  List<TerritoryModelClass> _territoryData = [];
  bool allowBack = false;
  bool _isLoading = true;
  String? country;

  loadTerritories() async {
    country = await _networkCalls.getKey("country");
    await _networkCalls.getTerritory(
      onSuccess: (territoryInfo) {
        if (mounted) {
          setState(() {
            _territoryData = territoryInfo;
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
    loadTerritories();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appThemeColor,
          title: Text(
            AppLocalizations.of(context)!.selectLocation,
          ),
          centerTitle: true,
          leading:  IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0XFFFFFFFF),
                  ),
                  onPressed: () {
                    country == null
                        ? showMessage(
                        "You must select at least one city."):
                    Navigator.pop(context);
                  }),
          automaticallyImplyLeading: false,
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: appThemeColor,
                ),
              )
            : Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                    padding: const EdgeInsets.only(right: 7),
                    separatorBuilder: (context, i) {
                      return const Divider(
                        height: 0,
                        thickness: 2.5,
                        color: Colors.grey,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          AppLocalizations.of(context)!.locale=="en"?_territoryData[index].country!.name.toString():_territoryData[index].country!.nameArabic.toString(),
                          style:
                              const TextStyle(fontSize: 14, color: Color(0xFF696969)),
                        ),
                        leading: SizedBox(
                          height: 22,
                          width: 34,
                          child: cachedNetworkImage(
                              cuisineImageUrl:
                                  _territoryData[index].country?.image ?? "",
                              imageFit: BoxFit.cover),
                        ),
                        children: List.generate(
                            _territoryData[index].cities!.length, (i) {
                          return _territoryData[index].cities![i]!.isDisable as bool
                              ? const SizedBox.shrink()
                              : InkWell(
                                  onTap: () async {
                                    await _networkCalls.saveKeys("country",
                                        _territoryData[index].country!.name.toString());
                                    await _networkCalls.saveKeys("arabicCountry",
                                        _territoryData[index].country!.nameArabic.toString());
                                    await _networkCalls.saveKeys(
                                        "city",
                                        _territoryData[index]
                                            .cities![i]!
                                            .city!
                                            .name.toString());
                                    await _networkCalls.saveKeys(
                                        "arabicCity",
                                        _territoryData[index]
                                            .cities![i]!
                                            .city!
                                            .nameArabic.toString());
                                    await _networkCalls.saveKeys(
                                        "cityId",
                                        _territoryData[index]
                                            .cities![i]!
                                            .city!
                                            .id.toString());
                                    await _networkCalls.saveKeys(
                                        "lat",
                                        _territoryData[index]
                                            .cities![i]!
                                            .city!
                                            .latitude.toString());
                                    await _networkCalls.saveKeys(
                                        "long",
                                        _territoryData[index]
                                            .cities![i]!
                                            .city!
                                            .longitude.toString());
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacementNamed(
                                        context, RouteNames.playerHome,arguments: {
                                          'index':0,
                                       'msg': ''
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 90, top: 12, bottom: 12),
                                        child: Text(
                                         AppLocalizations.of(context)!.locale=="en"? _territoryData[index]
                                              .cities![i]!
                                              .city!
                                              .name.toString():_territoryData[index]
                                             .cities![i]!
                                             .city!
                                             .nameArabic.toString(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }),
                      );
                    },
                    itemCount: _territoryData.length,
                  )),
                ],
              ),
      ),
    );
  }
}

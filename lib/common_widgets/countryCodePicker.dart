library country_code_picker;

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../localizations.dart';

class CountryCodePicker extends StatefulWidget {
  final ValueChanged<CountryCode> onChanged;
  final ValueChanged<CountryCode> onInit;
  final String initialSelection;
  final List<String> favorite;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final bool showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final TextStyle dialogTextStyle;
  final WidgetBuilder emptySearchBuilder;
  final Function(CountryCode) builder;
  final bool enabled;
  final TextOverflow textOverflow;
  final Icon closeIcon;

  /// Barrier color of ModalBottomSheet
  final Color barrierColor;

  /// Background color of ModalBottomSheet
  final Color backgroundColor;

  /// BoxDecoration for dialog
  final BoxDecoration boxDecoration;

  /// the size of the selection dialog
  // final Size dialogSize;

  /// used to customize the country list
  final List<String> countryFilter;

  /// shows the name of the country instead of the dialcode
  final bool showOnlyCountryWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially useful in combination with [showOnlyCountryWhenClosed],
  /// because longer country names are displayed in one line
  final bool alignLeft;

  /// shows the flag
  final bool showFlag;

  final bool hideMainText;

  final bool showFlagMain;

  final bool showFlagDialog;

  /// Width of the flag images
  final double flagWidth;

  /// Use this property to change the order of the options
  final Comparator<CountryCode> comparator;

  /// Set to true if you want to hide the search part
  final bool hideSearch;

  const CountryCodePicker({
    required this.onChanged,
    required this.onInit,
    required this.initialSelection,
    this.favorite = const [],
    required this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showCountryOnly = false,
    this.searchDecoration = const InputDecoration(),
    required this.searchStyle,
    required this.dialogTextStyle,
    required this.emptySearchBuilder,
    this.showOnlyCountryWhenClosed = false,
    this.alignLeft = false,
    this.showFlag = true,
    required this.showFlagDialog,
    this.hideMainText = false,
    required this.showFlagMain,
    required this.builder,
    this.flagWidth = 32.0,
    this.enabled = true,
    this.textOverflow = TextOverflow.ellipsis,
    required this.barrierColor,
    required this.backgroundColor,
    required this.boxDecoration,
    required this.comparator,
    required this.countryFilter,
    this.hideSearch = false,
    // required this.dialogSize,
    this.closeIcon = const Icon(Icons.close),
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<CountryCode> elements = jsonList
        .map((json) => CountryCode.fromJson(json as Map<String, dynamic>))
        .toList();

    elements.sort(comparator);

    if (countryFilter.isNotEmpty) {
      final uppercaseCustomList =
          countryFilter.map((c) => c.toUpperCase()).toList();
      elements = elements
          .where((c) =>
              uppercaseCustomList.contains(c.code) ||
              uppercaseCustomList.contains(c.name) ||
              uppercaseCustomList.contains(c.dialCode))
          .toList();
    }

    return CountryCodePickerState(elements, [], [] as CountryCode);
  }
}

class CountryCodePickerState extends State<CountryCodePicker> {
  CountryCode selectedItem;
  List<CountryCode> elements = [];
  List<CountryCode> favoriteElements = [];

  CountryCodePickerState(
      this.elements, this.favoriteElements, this.selectedItem);

  @override
  Widget build(BuildContext context) {
    var widget;
    if (widget.builder != null) {
      widget = InkWell(
        onTap: showCountryCodePickerDialog,
        child: widget.builder(selectedItem),
      );
    } else {
      widget = TextButton(
        // padding: widget.padding,
        onPressed: widget.enabled ? showCountryCodePickerDialog : null,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.showFlagMain ?? widget.showFlag)
              Flexible(
                flex: widget.alignLeft ? 0 : 1,
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Padding(
                  padding: widget.alignLeft
                      ? const EdgeInsets.only(right: 16.0, left: 8.0)
                      : AppLocalizations.of(context)!.locale == "en"
                          ? const EdgeInsets.only(
                              right: 8.0,
                            )
                          : const EdgeInsets.only(
                              left: 8.0,
                            ),
                  child: Image.asset(
                    selectedItem.flagUri.toString(),
                    package: 'country_code_picker',
                    width: widget.flagWidth,
                  ),
                ),
              ),
            if (!widget.hideMainText)
              Flexible(
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Text(
                  widget.showOnlyCountryWhenClosed
                      ? selectedItem.toCountryStringOnly()
                      : AppLocalizations.of(context)!.locale == "en"
                          ? selectedItem.toString()
                          : "${selectedItem.toString().substring(1)}${selectedItem.toString().substring(0, 1)}",
                  style: widget.textStyle ??
                      Theme.of(context).textTheme.labelLarge,
                  overflow: widget.textOverflow,
                ),
              ),
          ],
        ),
      );
    }
    return widget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    elements = elements.map((e) => e.localize(context)).toList();
    _onInit(selectedItem);
  }

  @override
  void didUpdateWidget(CountryCodePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = elements.firstWhere(
            (e) =>
                (e.code!.toUpperCase() ==
                    widget.initialSelection.toUpperCase()) ||
                (e.dialCode == widget.initialSelection) ||
                (e.name!.toUpperCase() ==
                    widget.initialSelection.toUpperCase()),
            orElse: () => elements[0]);
      } else {
        selectedItem = elements[0];
      }
      _onInit(selectedItem);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) =>
              (e.code!.toUpperCase() ==
                  widget.initialSelection.toUpperCase()) ||
              (e.dialCode == widget.initialSelection) ||
              (e.name!.toUpperCase() == widget.initialSelection.toUpperCase()),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    favoriteElements = elements
        .where((e) =>
            widget.favorite.firstWhere(
                (f) =>
                    e.code!.toUpperCase() == f.toUpperCase() ||
                    e.dialCode == f ||
                    e.name!.toUpperCase() == f.toUpperCase(),
                orElse: () => '') !=
            null)
        .toList();
  }

  void showCountryCodePickerDialog() {
    showBottomSheet(
      // barrierColor: widget.barrierColor ?? Colors.grey.withOpacity(0.5),
      backgroundColor: widget.backgroundColor ?? Colors.transparent,
      context: context,
      builder: (context) => Center(
        child: SelectionDialog(
          elements,
          favoriteElements,
          showCountryOnly: widget.showCountryOnly,
          emptySearchBuilder: widget.emptySearchBuilder,
          searchDecoration: widget.searchDecoration,
          searchStyle: widget.searchStyle,
          textStyle: widget.dialogTextStyle,
          boxDecoration: widget.boxDecoration,
          showFlag: widget.showFlagDialog ?? widget.showFlag,
          flagWidth: widget.flagWidth,
          // size: widget.dialogSize,
          hideSearch: widget.hideSearch,
          closeIcon: widget.closeIcon,
        ),
      ),
    );
  }

  void _publishSelection(CountryCode e) {
    widget.onChanged(e);
    {
      setState(() {
        selectedItem = e;
      });

      _publishSelection(e);
    }
  }

  void _onInit(CountryCode e) {
    widget.onInit(e);
  }
}

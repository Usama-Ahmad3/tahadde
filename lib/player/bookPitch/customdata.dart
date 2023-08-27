import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import 'bookPitchSlot.dart';

class CustomDataTable<T> extends StatefulWidget {
  final String? month;
  final String? year;
  int? count;
  final String? fixedCornerCell = '';
  final List<T>? fixedColCells;
  final List<T>? fixedRowCells;
  final List<List<T>>? rowsCells;
  final Widget Function(T data)? cellBuilder;
  final double? fixedColWidth;
  final double? cellWidth;
  final double? cellHeight;
  final double? cellMargin;
  final double? cellSpacing;
  Function(int count)? onChange;
  Function(Map count)? detail;
  Function(Map count)? monthDetail;

  CustomDataTable(
      {this.fixedColCells,
      this.fixedRowCells,
      @required this.rowsCells,
      this.cellBuilder,
      this.count,
      this.fixedColWidth = 70.0,
      this.cellHeight = 80.0,
      this.cellWidth = 40.0,
      this.cellMargin = 0.0,
      this.cellSpacing = 0.0,
      this.onChange,
      this.month,
      this.year,
      this.detail,
      this.monthDetail});

  @override
  State<StatefulWidget> createState() => CustomDataTableState();
}

class CustomDataTableState<T> extends State<CustomDataTable<T>> {
  int color = 0XFFEDEDED;
  int color1 = 0XFFC7C7C7;
  var count;
  Map<String, List<dynamic>> days = {};
  Map<String, List<dynamic>> slotDetail = {};
  List? time;
  var count1 = 0;
  final _columnController = ScrollController();
  final _rowController = ScrollController(
      initialScrollOffset: 74.5 *
          (int.parse(DateFormat.d('en_US').format(DateTime.now()).toString()) -
              1));
  final _subTableYController = ScrollController();
  final _subTableXController = ScrollController(
      initialScrollOffset: 74.5 *
          (int.parse(DateFormat.d('en_US').format(DateTime.now()).toString()) -
              1));

  Widget _buildChild(double width, Object data) => SizedBox(
      width: width,
      child: widget.cellBuilder?.call((checking(data) ? "" : data) as T) ??
          Text('$data'));

  Widget _buildChild1(double width, T data) => Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          flaxibleGap(1),
          widget.cellBuilder?.call(data) ?? Text('$data'),
          DayConv(x: int.parse(data.toString())),
          flaxibleGap(2),
        ],
      ));

  Widget _buildFixedCol() => widget.fixedColCells == null
      ? const SizedBox.shrink()
      : Material(
          color: Colors.white,
          child: DataTable(
              horizontalMargin: 0,
              columnSpacing: widget.cellSpacing,
              headingRowHeight: 55,
              dataRowHeight: widget.cellHeight,
              columns: [
                DataColumn(
                    label: _buildChild(widget.fixedColWidth!,
                        widget.fixedColCells!.first as Object))
              ],
              rows: widget.fixedColCells!
                  .sublist(widget.fixedRowCells == null ? 1 : 0)
                  .map((c) => DataRow(cells: [
                        DataCell(
                            _buildChild(widget.fixedColWidth!, c as Object))
                      ]))
                  .toList()),
        );

  Widget _buildFixedRow() => widget.fixedRowCells == null
      ? const SizedBox.shrink()
      : Material(
          color: Colors.white,
          child: DataTable(
              horizontalMargin: widget.cellMargin,
              columnSpacing: widget.cellSpacing,
              headingRowHeight: 55,
              dataRowHeight: widget.cellHeight,
              columns: widget.fixedRowCells!
                  .map((c) =>
                      DataColumn(label: _buildChild1(widget.cellWidth!, c)))
                  .toList(),
              rows: []),
        );

  Widget _buildSubTable() => Material(
      color: Colors.white,
      child: DataTable(
          horizontalMargin: widget.cellMargin,
          columnSpacing: widget.cellSpacing,
          headingRowHeight: 55,
          dataRowHeight: widget.cellHeight,
          columns: widget.rowsCells!.first.asMap().entries.map((entry) {
            return DataColumn(
                label: _buildChild(widget.cellWidth!, entry.value as Object));
          }).toList(),
          rows: widget.rowsCells!
              .sublist(widget.fixedRowCells == null ? 1 : 0)
              .map((row) => DataRow(
                      cells: row.map((dynamic c) {
                    return DataCell(
                        count == null
                            ? Container(
                                width: widget.cellHeight! * .9,
                                height: widget.cellWidth! * .9,
                                color: c.price == 54
                                    ? Color(color1)
                                    : c.price == 52
                                        ? Color(color1).withOpacity(.25)
                                        : c.price == 1700
                                            ? const Color(0XFF032040)
                                            : c.price == 1702
                                                ? const Color(0XFF032040)
                                                    .withOpacity(.25)
                                                : c.price == 1802
                                                    ? Color(color)
                                                        .withOpacity(.25)
                                                    : c.select
                                                        ? const Color(
                                                            0xFF25A163)
                                                        : Color(color),
                                alignment: Alignment.center,
                                child: _buildChild(widget.cellWidth!, c.price))
                            : c == count
                                ? Container(
                                    width: widget.cellHeight! * .9,
                                    height: widget.cellWidth! * .9,
                                    color: c.price == 54
                                        ? Color(color1)
                                        : c.price == 52
                                            ? Color(color1).withOpacity(.25)
                                            : c.price == 1700
                                                ? const Color(0XFF032040)
                                                : c.price == 1702
                                                    ? const Color(0XFF032040)
                                                        .withOpacity(.25)
                                                    : c.price == 1802
                                                        ? Color(color)
                                                            .withOpacity(.25)
                                                        : c.select
                                                            ? const Color(
                                                                0xFF25A163)
                                                            : Color(color),
                                    alignment: Alignment.center,
                                    child:
                                        _buildChild(widget.cellWidth!, c.price))
                                : Container(
                                    width: widget.cellHeight! * .9,
                                    height: widget.cellWidth! * .9,
                                    color: c.price == 54
                                        ? Color(color1)
                                        : c.price == 52
                                            ? Color(color1).withOpacity(.25)
                                            : c.price == 1700
                                                ? const Color(0XFF032040)
                                                : c.price == 1702
                                                    ? const Color(0XFF032040)
                                                        .withOpacity(.25)
                                                    : c.price == 1802
                                                        ? Color(color)
                                                            .withOpacity(.25)
                                                        : c.select
                                                            ? const Color(
                                                                0xFF25A163)
                                                            : Color(color),
                                    alignment: Alignment.center,
                                    child: _buildChild(
                                        widget.cellWidth!, c.price)),
                        onTap: () {
                      setState(() {
                        count = c;
                        c.price == 54 ||
                                c.price == 1700 ||
                                c.price == 1702 ||
                                c.price == 1802 ||
                                c.price == 52
                            ? count1 = count1
                            : c.select
                                ? count1 = count1 - 1
                                : count1 = count1 + 1;
                        c.select ? c.select = false : c.select = true;
                        if (c.price == 1801) {
                          c.price = 1800;
                        } else if (c.price == 1800) {
                          c.price = 1801;
                        }

                        if (c.price == 1800 || c.price == 1801) {
                          c.price == 1801;
                          if (c.select == true) {
                            if (!days.containsKey(c.y.toString())) {
                              days[c.y.toString()] = [c.id];
                              slotDetail[c.y.toString()] = [c.x];
                            } else {
                              days[c.y.toString()]!.add(c.id);
                              slotDetail[c.y.toString()]!.add(c.x);
                            }
                          } else {
                            if (days[c.y.toString()]!.length < 2) {
                              days.remove(c.y.toString());
                              slotDetail.remove(c.y.toString());
                            } else {
                              days[c.y.toString()]!.remove(c.id);
                              slotDetail[c.y.toString()]!.remove(c.x);
                            }
                          }
                        }
                        widget.detail!(days);
                        widget.onChange!(count1);
                        widget.monthDetail!(slotDetail);
                      });
                    });
                  }).toList()))
              .toList()));

  Widget _buildCornerCell() =>
      widget.fixedColCells == null || widget.fixedRowCells == null
          ? const SizedBox.shrink()
          : Material(
              color: Colors.white,
              child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: widget.cellSpacing,
                  headingRowHeight: 55,
                  dataRowHeight: widget.cellHeight,
                  columns: [
                    DataColumn(
                        label: _buildChild(widget.fixedColWidth!,
                            widget.fixedCornerCell as Object))
                  ],
                  rows: []),
            );

  @override
  void initState() {
    super.initState();
    _subTableXController.addListener(() {
      _rowController.jumpTo(_subTableXController.position.pixels);
    });
    _subTableYController.addListener(() {
      _columnController.jumpTo(_subTableYController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    count1 = widget.count!;
    if (count1 == 0) {
      days = {};
      slotDetail = {};
    }
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            SingleChildScrollView(
              controller: _columnController,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              child: _buildFixedCol(),
            ),
            Flexible(
              child: SingleChildScrollView(
                controller: _subTableXController,
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  controller: _subTableYController,
                  scrollDirection: Axis.vertical,
                  child: _buildSubTable(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            _buildCornerCell(),
            Flexible(
              child: SingleChildScrollView(
                controller: _rowController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: _buildFixedRow(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget DayFind(String index) {
    var day;
    switch (index) {
      case "1":
        day = const Text(
          'Mon',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;

      case "2":
        day = const Text(
          'Tues',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;

      case "3":
        day = const Text(
          'Wed',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;

      case "4":
        day = const Text(
          'Thu',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;
      case "5":
        day = const Text(
          ' Fri',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;

      case "6":
        day = const Text(
          ' Sat',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;

      default:
        day = const Text(
          'Sun',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;
    }
    return day;
  }

  Widget DayFindAr(String index) {
    var day;
    switch (index) {
      case "1":
        day = const Text(
          'الإثنين',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;

      case "2":
        day = const Text(
          'الثلاثاء',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;

      case "3":
        day = const Text(
          'الأربعاء',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;

      case "4":
        day = const Text(
          'الخميس',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;
      case "5":
        day = const Text(
          'الجمعة',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;
      case "6":
        day = const Text(
          'السبت',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;

      default:
        day = const Text(
          'الأحَد',
          style: TextStyle(
              color: Colors.grey, fontSize: 13, fontFamily: "Poppins"),
        );
        break;
    }
    return day;
  }

  Widget DayConv({required int x}) {
    int month1 = monthFind(index: widget.month ?? "January");
    int year1 = yearFind(index: widget.year ?? "2020");
    var berlinWallFell = DateTime.utc(year1, month1, x);
    int y = berlinWallFell.weekday;
    String y1 = y.toString();
    return AppLocalizations.of(context)!.locale == "en"
        ? DayFind(y1)
        : DayFindAr(y1);
  }

  int yearFind({required String index}) {
    var day;
    switch (index) {
      case "2019":
        day = 2019;
        break;

      case "2020":
        day = 2020;
        break;

      case "2021":
        day = 2021;
        break;

      case "2023":
        day = 2023;
        break;
      case "2024":
        day = 2024;
        break;

      case "2025":
        day = 2025;
        break;

      default:
        day = 2026;
        break;
    }
    return day;
  }

  bool checking(var data) {
    if (data is CellData) {
      return true;
    } else {
      return false;
    }
  }
}

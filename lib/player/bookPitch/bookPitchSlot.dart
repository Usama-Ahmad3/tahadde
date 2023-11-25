import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/bookPitchSlotModelClass.dart';
import '../../network/network_calls.dart';
import 'customdata.dart';

class BookPitchSlots extends StatefulWidget {
  var id;
  BookPitchSlots({super.key, this.id});

  @override
  _BookPitchSlotState createState() => _BookPitchSlotState();
}

class _BookPitchSlotState extends State<BookPitchSlots> {
  List<List<CellData>> rowsCells = <List<CellData>>[
    [
      CellData(x: "00:00:00", y: 1, price: 54),
      CellData(x: "00:00:00", y: 2, price: 54),
      CellData(x: "00:00:00", y: 3, price: 54),
      CellData(x: "00:00:00", y: 4, price: 54),
      CellData(x: "00:00:00", y: 5, price: 54),
      CellData(x: "00:00:00", y: 6, price: 54),
      CellData(x: "00:00:00", y: 7, price: 54),
      CellData(x: "00:00:00", y: 8, price: 54),
      CellData(x: "00:00:00", y: 9, price: 54),
      CellData(x: "00:00:00", y: 10, price: 54),
      CellData(x: "00:00:00", y: 11, price: 54),
      CellData(x: "00:00:00", y: 12, price: 54),
      CellData(x: "00:00:00", y: 13, price: 54),
      CellData(x: "00:00:00", y: 14, price: 54),
      CellData(x: "00:00:00", y: 15, price: 54),
      CellData(x: "00:00:00", y: 16, price: 54),
      CellData(x: "00:00:00", y: 17, price: 54),
      CellData(x: "00:00:00", y: 18, price: 54),
      CellData(x: "00:00:00", y: 19, price: 54),
      CellData(x: "00:00:00", y: 20, price: 54),
      CellData(x: "00:00:00", y: 21, price: 54),
      CellData(x: "00:00:00", y: 22, price: 54),
      CellData(x: "00:00:00", y: 23, price: 54),
      CellData(x: "00:00:00", y: 24, price: 54),
      CellData(x: "00:00:00", y: 25, price: 54),
      CellData(x: "00:00:00", y: 26, price: 54),
      CellData(x: "00:00:00", y: 27, price: 54),
      CellData(x: "00:00:00", y: 28, price: 54),
      CellData(x: "00:00:00", y: 29, price: 54),
      CellData(x: "00:00:00", y: 30, price: 54),
      CellData(x: "00:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "01:00:00", y: 1, price: 54),
      CellData(x: "01:00:00", y: 2, price: 54),
      CellData(x: "01:00:00", y: 3, price: 54),
      CellData(x: "01:00:00", y: 4, price: 54),
      CellData(x: "01:00:00", y: 5, price: 54),
      CellData(x: "01:00:00", y: 6, price: 54),
      CellData(x: "01:00:00", y: 7, price: 54),
      CellData(x: "01:00:00", y: 8, price: 54),
      CellData(x: "01:00:00", y: 9, price: 54),
      CellData(x: "01:00:00", y: 10, price: 54),
      CellData(x: "01:00:00", y: 11, price: 54),
      CellData(x: "01:00:00", y: 12, price: 54),
      CellData(x: "01:00:00", y: 13, price: 54),
      CellData(x: "01:00:00", y: 14, price: 54),
      CellData(x: "01:00:00", y: 15, price: 54),
      CellData(x: "01:00:00", y: 16, price: 54),
      CellData(x: "01:00:00", y: 17, price: 54),
      CellData(x: "01:00:00", y: 18, price: 54),
      CellData(x: "01:00:00", y: 19, price: 54),
      CellData(x: "01:00:00", y: 20, price: 54),
      CellData(x: "01:00:00", y: 21, price: 54),
      CellData(x: "01:00:00", y: 22, price: 54),
      CellData(x: "01:00:00", y: 23, price: 54),
      CellData(x: "01:00:00", y: 24, price: 54),
      CellData(x: "01:00:00", y: 25, price: 54),
      CellData(x: "01:00:00", y: 26, price: 54),
      CellData(x: "01:00:00", y: 27, price: 54),
      CellData(x: "01:00:00", y: 28, price: 54),
      CellData(x: "01:00:00", y: 29, price: 54),
      CellData(x: "01:00:00", y: 30, price: 54),
      CellData(x: "01:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "02:00:00", y: 1, price: 54),
      CellData(x: "02:00:00", y: 2, price: 54),
      CellData(x: "02:00:00", y: 3, price: 54),
      CellData(x: "02:00:00", y: 4, price: 54),
      CellData(x: "02:00:00", y: 5, price: 54),
      CellData(x: "02:00:00", y: 6, price: 54),
      CellData(x: "02:00:00", y: 7, price: 54),
      CellData(x: "02:00:00", y: 8, price: 54),
      CellData(x: "02:00:00", y: 9, price: 54),
      CellData(x: "02:00:00", y: 10, price: 54),
      CellData(x: "02:00:00", y: 11, price: 54),
      CellData(x: "02:00:00", y: 12, price: 54),
      CellData(x: "02:00:00", y: 13, price: 54),
      CellData(x: "02:00:00", y: 14, price: 54),
      CellData(x: "02:00:00", y: 15, price: 54),
      CellData(x: "02:00:00", y: 16, price: 54),
      CellData(x: "02:00:00", y: 17, price: 54),
      CellData(x: "02:00:00", y: 18, price: 54),
      CellData(x: "02:00:00", y: 19, price: 54),
      CellData(x: "02:00:00", y: 20, price: 54),
      CellData(x: "02:00:00", y: 21, price: 54),
      CellData(x: "02:00:00", y: 22, price: 54),
      CellData(x: "02:00:00", y: 23, price: 54),
      CellData(x: "02:00:00", y: 24, price: 54),
      CellData(x: "02:00:00", y: 25, price: 54),
      CellData(x: "02:00:00", y: 26, price: 54),
      CellData(x: "02:00:00", y: 27, price: 54),
      CellData(x: "02:00:00", y: 28, price: 54),
      CellData(x: "02:00:00", y: 29, price: 54),
      CellData(x: "02:00:00", y: 30, price: 54),
      CellData(x: "02:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "03:00:00", y: 1, price: 54),
      CellData(x: "03:00:00", y: 2, price: 54),
      CellData(x: "03:00:00", y: 3, price: 54),
      CellData(x: "03:00:00", y: 4, price: 54),
      CellData(x: "03:00:00", y: 5, price: 54),
      CellData(x: "03:00:00", y: 6, price: 54),
      CellData(x: "03:00:00", y: 7, price: 54),
      CellData(x: "03:00:00", y: 8, price: 54),
      CellData(x: "03:00:00", y: 9, price: 54),
      CellData(x: "03:00:00", y: 10, price: 54),
      CellData(x: "03:00:00", y: 11, price: 54),
      CellData(x: "03:00:00", y: 12, price: 54),
      CellData(x: "03:00:00", y: 13, price: 54),
      CellData(x: "03:00:00", y: 14, price: 54),
      CellData(x: "03:00:00", y: 15, price: 54),
      CellData(x: "03:00:00", y: 16, price: 54),
      CellData(x: "03:00:00", y: 17, price: 54),
      CellData(x: "03:00:00", y: 18, price: 54),
      CellData(x: "03:00:00", y: 19, price: 54),
      CellData(x: "03:00:00", y: 20, price: 54),
      CellData(x: "03:00:00", y: 21, price: 54),
      CellData(x: "03:00:00", y: 22, price: 54),
      CellData(x: "03:00:00", y: 23, price: 54),
      CellData(x: "03:00:00", y: 24, price: 54),
      CellData(x: "03:00:00", y: 25, price: 54),
      CellData(x: "03:00:00", y: 26, price: 54),
      CellData(x: "03:00:00", y: 27, price: 54),
      CellData(x: "03:00:00", y: 28, price: 54),
      CellData(x: "03:00:00", y: 29, price: 54),
      CellData(x: "03:00:00", y: 30, price: 54),
      CellData(x: "03:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "04:00:00", y: 1, price: 54),
      CellData(x: "04:00:00", y: 2, price: 54),
      CellData(x: "04:00:00", y: 3, price: 54),
      CellData(x: "04:00:00", y: 4, price: 54),
      CellData(x: "04:00:00", y: 5, price: 54),
      CellData(x: "04:00:00", y: 6, price: 54),
      CellData(x: "04:00:00", y: 7, price: 54),
      CellData(x: "04:00:00", y: 8, price: 54),
      CellData(x: "04:00:00", y: 9, price: 54),
      CellData(x: "04:00:00", y: 10, price: 54),
      CellData(x: "04:00:00", y: 11, price: 54),
      CellData(x: "04:00:00", y: 12, price: 54),
      CellData(x: "04:00:00", y: 13, price: 54),
      CellData(x: "04:00:00", y: 14, price: 54),
      CellData(x: "04:00:00", y: 15, price: 54),
      CellData(x: "04:00:00", y: 16, price: 54),
      CellData(x: "04:00:00", y: 17, price: 54),
      CellData(x: "04:00:00", y: 18, price: 54),
      CellData(x: "04:00:00", y: 19, price: 54),
      CellData(x: "04:00:00", y: 20, price: 54),
      CellData(x: "04:00:00", y: 21, price: 54),
      CellData(x: "04:00:00", y: 22, price: 54),
      CellData(x: "04:00:00", y: 23, price: 54),
      CellData(x: "04:00:00", y: 24, price: 54),
      CellData(x: "04:00:00", y: 25, price: 54),
      CellData(x: "04:00:00", y: 26, price: 54),
      CellData(x: "04:00:00", y: 27, price: 54),
      CellData(x: "04:00:00", y: 28, price: 54),
      CellData(x: "04:00:00", y: 29, price: 54),
      CellData(x: "04:00:00", y: 30, price: 54),
      CellData(x: "04:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "05:00:00", y: 1, price: 54),
      CellData(x: "05:00:00", y: 2, price: 54),
      CellData(x: "05:00:00", y: 3, price: 54),
      CellData(x: "05:00:00", y: 4, price: 54),
      CellData(x: "05:00:00", y: 5, price: 54),
      CellData(x: "05:00:00", y: 6, price: 54),
      CellData(x: "05:00:00", y: 7, price: 54),
      CellData(x: "05:00:00", y: 8, price: 54),
      CellData(x: "05:00:00", y: 9, price: 54),
      CellData(x: "05:00:00", y: 10, price: 54),
      CellData(x: "05:00:00", y: 11, price: 54),
      CellData(x: "05:00:00", y: 12, price: 54),
      CellData(x: "05:00:00", y: 13, price: 54),
      CellData(x: "05:00:00", y: 14, price: 54),
      CellData(x: "05:00:00", y: 15, price: 54),
      CellData(x: "05:00:00", y: 16, price: 54),
      CellData(x: "05:00:00", y: 17, price: 54),
      CellData(x: "05:00:00", y: 18, price: 54),
      CellData(x: "05:00:00", y: 19, price: 54),
      CellData(x: "05:00:00", y: 20, price: 54),
      CellData(x: "05:00:00", y: 21, price: 54),
      CellData(x: "05:00:00", y: 22, price: 54),
      CellData(x: "05:00:00", y: 23, price: 54),
      CellData(x: "05:00:00", y: 24, price: 54),
      CellData(x: "05:00:00", y: 25, price: 54),
      CellData(x: "05:00:00", y: 26, price: 54),
      CellData(x: "05:00:00", y: 27, price: 54),
      CellData(x: "05:00:00", y: 28, price: 54),
      CellData(x: "05:00:00", y: 29, price: 54),
      CellData(x: "05:00:00", y: 30, price: 54),
      CellData(x: "05:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "06:00:00", y: 1, price: 54),
      CellData(x: "06:00:00", y: 2, price: 54),
      CellData(x: "06:00:00", y: 3, price: 54),
      CellData(x: "06:00:00", y: 4, price: 54),
      CellData(x: "06:00:00", y: 5, price: 54),
      CellData(x: "06:00:00", y: 6, price: 54),
      CellData(x: "06:00:00", y: 7, price: 54),
      CellData(x: "06:00:00", y: 8, price: 54),
      CellData(x: "06:00:00", y: 9, price: 54),
      CellData(x: "06:00:00", y: 10, price: 54),
      CellData(x: "06:00:00", y: 11, price: 54),
      CellData(x: "06:00:00", y: 12, price: 54),
      CellData(x: "06:00:00", y: 13, price: 54),
      CellData(x: "06:00:00", y: 14, price: 54),
      CellData(x: "06:00:00", y: 15, price: 54),
      CellData(x: "06:00:00", y: 16, price: 54),
      CellData(x: "06:00:00", y: 17, price: 54),
      CellData(x: "06:00:00", y: 18, price: 54),
      CellData(x: "06:00:00", y: 19, price: 54),
      CellData(x: "06:00:00", y: 20, price: 54),
      CellData(x: "06:00:00", y: 21, price: 54),
      CellData(x: "06:00:00", y: 22, price: 54),
      CellData(x: "06:00:00", y: 23, price: 54),
      CellData(x: "06:00:00", y: 24, price: 54),
      CellData(x: "06:00:00", y: 25, price: 54),
      CellData(x: "06:00:00", y: 26, price: 54),
      CellData(x: "06:00:00", y: 27, price: 54),
      CellData(x: "06:00:00", y: 28, price: 54),
      CellData(x: "06:00:00", y: 29, price: 54),
      CellData(x: "06:00:00", y: 30, price: 54),
      CellData(x: "06:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "07:00:00", y: 1, price: 54),
      CellData(x: "07:00:00", y: 2, price: 54),
      CellData(x: "07:00:00", y: 3, price: 54),
      CellData(x: "07:00:00", y: 4, price: 54),
      CellData(x: "07:00:00", y: 5, price: 54),
      CellData(x: "07:00:00", y: 6, price: 54),
      CellData(x: "07:00:00", y: 7, price: 54),
      CellData(x: "07:00:00", y: 8, price: 54),
      CellData(x: "07:00:00", y: 9, price: 54),
      CellData(x: "07:00:00", y: 10, price: 54),
      CellData(x: "07:00:00", y: 11, price: 54),
      CellData(x: "07:00:00", y: 12, price: 54),
      CellData(x: "07:00:00", y: 13, price: 54),
      CellData(x: "07:00:00", y: 14, price: 54),
      CellData(x: "07:00:00", y: 15, price: 54),
      CellData(x: "07:00:00", y: 16, price: 54),
      CellData(x: "07:00:00", y: 17, price: 54),
      CellData(x: "07:00:00", y: 18, price: 54),
      CellData(x: "07:00:00", y: 19, price: 54),
      CellData(x: "07:00:00", y: 20, price: 54),
      CellData(x: "07:00:00", y: 21, price: 54),
      CellData(x: "07:00:00", y: 22, price: 54),
      CellData(x: "07:00:00", y: 23, price: 54),
      CellData(x: "07:00:00", y: 24, price: 54),
      CellData(x: "07:00:00", y: 25, price: 54),
      CellData(x: "07:00:00", y: 26, price: 54),
      CellData(x: "07:00:00", y: 27, price: 54),
      CellData(x: "07:00:00", y: 28, price: 54),
      CellData(x: "07:00:00", y: 29, price: 54),
      CellData(x: "07:00:00", y: 30, price: 54),
      CellData(x: "07:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "08:00:00", y: 1, price: 54),
      CellData(x: "08:00:00", y: 2, price: 54),
      CellData(x: "08:00:00", y: 3, price: 54),
      CellData(x: "08:00:00", y: 4, price: 54),
      CellData(x: "08:00:00", y: 5, price: 54),
      CellData(x: "08:00:00", y: 6, price: 54),
      CellData(x: "08:00:00", y: 7, price: 54),
      CellData(x: "08:00:00", y: 8, price: 54),
      CellData(x: "08:00:00", y: 9, price: 54),
      CellData(x: "08:00:00", y: 10, price: 54),
      CellData(x: "08:00:00", y: 11, price: 54),
      CellData(x: "08:00:00", y: 12, price: 54),
      CellData(x: "08:00:00", y: 13, price: 54),
      CellData(x: "08:00:00", y: 14, price: 54),
      CellData(x: "08:00:00", y: 15, price: 54),
      CellData(x: "08:00:00", y: 16, price: 54),
      CellData(x: "08:00:00", y: 17, price: 54),
      CellData(x: "08:00:00", y: 18, price: 54),
      CellData(x: "08:00:00", y: 19, price: 54),
      CellData(x: "08:00:00", y: 20, price: 54),
      CellData(x: "08:00:00", y: 21, price: 54),
      CellData(x: "08:00:00", y: 22, price: 54),
      CellData(x: "08:00:00", y: 23, price: 54),
      CellData(x: "08:00:00", y: 24, price: 54),
      CellData(x: "08:00:00", y: 25, price: 54),
      CellData(x: "08:00:00", y: 26, price: 54),
      CellData(x: "08:00:00", y: 27, price: 54),
      CellData(x: "08:00:00", y: 28, price: 54),
      CellData(x: "08:00:00", y: 29, price: 54),
      CellData(x: "08:00:00", y: 30, price: 54),
      CellData(x: "08:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "09:00:00", y: 1, price: 54),
      CellData(x: "09:00:00", y: 2, price: 54),
      CellData(x: "09:00:00", y: 3, price: 54),
      CellData(x: "09:00:00", y: 4, price: 54),
      CellData(x: "09:00:00", y: 5, price: 54),
      CellData(x: "09:00:00", y: 6, price: 54),
      CellData(x: "09:00:00", y: 7, price: 54),
      CellData(x: "09:00:00", y: 8, price: 54),
      CellData(x: "09:00:00", y: 9, price: 54),
      CellData(x: "09:00:00", y: 10, price: 54),
      CellData(x: "09:00:00", y: 11, price: 54),
      CellData(x: "09:00:00", y: 12, price: 54),
      CellData(x: "09:00:00", y: 13, price: 54),
      CellData(x: "09:00:00", y: 14, price: 54),
      CellData(x: "09:00:00", y: 15, price: 54),
      CellData(x: "09:00:00", y: 16, price: 54),
      CellData(x: "09:00:00", y: 17, price: 54),
      CellData(x: "09:00:00", y: 18, price: 54),
      CellData(x: "09:00:00", y: 19, price: 54),
      CellData(x: "09:00:00", y: 20, price: 54),
      CellData(x: "09:00:00", y: 21, price: 54),
      CellData(x: "09:00:00", y: 22, price: 54),
      CellData(x: "09:00:00", y: 23, price: 54),
      CellData(x: "09:00:00", y: 24, price: 54),
      CellData(x: "09:00:00", y: 25, price: 54),
      CellData(x: "09:00:00", y: 26, price: 54),
      CellData(x: "09:00:00", y: 27, price: 54),
      CellData(x: "09:00:00", y: 28, price: 54),
      CellData(x: "09:00:00", y: 29, price: 54),
      CellData(x: "09:00:00", y: 30, price: 54),
      CellData(x: "09:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "10:00:00", y: 1, price: 54),
      CellData(x: "10:00:00", y: 2, price: 54),
      CellData(x: "10:00:00", y: 3, price: 54),
      CellData(x: "10:00:00", y: 4, price: 54),
      CellData(x: "10:00:00", y: 5, price: 54),
      CellData(x: "10:00:00", y: 6, price: 54),
      CellData(x: "10:00:00", y: 7, price: 54),
      CellData(x: "10:00:00", y: 8, price: 54),
      CellData(x: "10:00:00", y: 9, price: 54),
      CellData(x: "10:00:00", y: 10, price: 54),
      CellData(x: "10:00:00", y: 11, price: 54),
      CellData(x: "10:00:00", y: 12, price: 54),
      CellData(x: "10:00:00", y: 13, price: 54),
      CellData(x: "10:00:00", y: 14, price: 54),
      CellData(x: "10:00:00", y: 15, price: 54),
      CellData(x: "10:00:00", y: 16, price: 54),
      CellData(x: "10:00:00", y: 17, price: 54),
      CellData(x: "10:00:00", y: 18, price: 54),
      CellData(x: "10:00:00", y: 19, price: 54),
      CellData(x: "10:00:00", y: 20, price: 54),
      CellData(x: "10:00:00", y: 21, price: 54),
      CellData(x: "10:00:00", y: 22, price: 54),
      CellData(x: "10:00:00", y: 23, price: 54),
      CellData(x: "10:00:00", y: 24, price: 54),
      CellData(x: "10:00:00", y: 25, price: 54),
      CellData(x: "10:00:00", y: 26, price: 54),
      CellData(x: "10:00:00", y: 27, price: 54),
      CellData(x: "10:00:00", y: 28, price: 54),
      CellData(x: "10:00:00", y: 29, price: 54),
      CellData(x: "10:00:00", y: 30, price: 54),
      CellData(x: "10:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "11:00:00", y: 1, price: 54),
      CellData(x: "11:00:00", y: 2, price: 54),
      CellData(x: "11:00:00", y: 3, price: 54),
      CellData(x: "11:00:00", y: 4, price: 54),
      CellData(x: "11:00:00", y: 5, price: 54),
      CellData(x: "11:00:00", y: 6, price: 54),
      CellData(x: "11:00:00", y: 7, price: 54),
      CellData(x: "11:00:00", y: 8, price: 54),
      CellData(x: "11:00:00", y: 9, price: 54),
      CellData(x: "11:00:00", y: 10, price: 54),
      CellData(x: "11:00:00", y: 11, price: 54),
      CellData(x: "11:00:00", y: 12, price: 54),
      CellData(x: "11:00:00", y: 13, price: 54),
      CellData(x: "11:00:00", y: 14, price: 54),
      CellData(x: "11:00:00", y: 15, price: 54),
      CellData(x: "11:00:00", y: 16, price: 54),
      CellData(x: "11:00:00", y: 17, price: 54),
      CellData(x: "11:00:00", y: 18, price: 54),
      CellData(x: "11:00:00", y: 19, price: 54),
      CellData(x: "11:00:00", y: 20, price: 54),
      CellData(x: "11:00:00", y: 21, price: 54),
      CellData(x: "11:00:00", y: 22, price: 54),
      CellData(x: "11:00:00", y: 23, price: 54),
      CellData(x: "11:00:00", y: 24, price: 54),
      CellData(x: "11:00:00", y: 25, price: 54),
      CellData(x: "11:00:00", y: 26, price: 54),
      CellData(x: "11:00:00", y: 27, price: 54),
      CellData(x: "11:00:00", y: 28, price: 54),
      CellData(x: "11:00:00", y: 29, price: 54),
      CellData(x: "11:00:00", y: 30, price: 54),
      CellData(x: "11:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "12:00:00", y: 1, price: 54),
      CellData(x: "12:00:00", y: 2, price: 54),
      CellData(x: "12:00:00", y: 3, price: 54),
      CellData(x: "12:00:00", y: 4, price: 54),
      CellData(x: "12:00:00", y: 5, price: 54),
      CellData(x: "12:00:00", y: 6, price: 54),
      CellData(x: "12:00:00", y: 7, price: 54),
      CellData(x: "12:00:00", y: 8, price: 54),
      CellData(x: "12:00:00", y: 9, price: 54),
      CellData(x: "12:00:00", y: 10, price: 54),
      CellData(x: "12:00:00", y: 11, price: 54),
      CellData(x: "12:00:00", y: 12, price: 54),
      CellData(x: "12:00:00", y: 13, price: 54),
      CellData(x: "12:00:00", y: 14, price: 54),
      CellData(x: "12:00:00", y: 15, price: 54),
      CellData(x: "12:00:00", y: 16, price: 54),
      CellData(x: "12:00:00", y: 17, price: 54),
      CellData(x: "12:00:00", y: 18, price: 54),
      CellData(x: "12:00:00", y: 19, price: 54),
      CellData(x: "12:00:00", y: 20, price: 54),
      CellData(x: "12:00:00", y: 21, price: 54),
      CellData(x: "12:00:00", y: 22, price: 54),
      CellData(x: "12:00:00", y: 23, price: 54),
      CellData(x: "12:00:00", y: 24, price: 54),
      CellData(x: "12:00:00", y: 25, price: 54),
      CellData(x: "12:00:00", y: 26, price: 54),
      CellData(x: "12:00:00", y: 27, price: 54),
      CellData(x: "12:00:00", y: 28, price: 54),
      CellData(x: "12:00:00", y: 29, price: 54),
      CellData(x: "12:00:00", y: 30, price: 54),
      CellData(x: "12:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "13:00:00", y: 1, price: 54),
      CellData(x: "13:00:00", y: 2, price: 54),
      CellData(x: "13:00:00", y: 3, price: 54),
      CellData(x: "13:00:00", y: 4, price: 54),
      CellData(x: "13:00:00", y: 5, price: 54),
      CellData(x: "13:00:00", y: 6, price: 54),
      CellData(x: "13:00:00", y: 7, price: 54),
      CellData(x: "13:00:00", y: 8, price: 54),
      CellData(x: "13:00:00", y: 9, price: 54),
      CellData(x: "13:00:00", y: 10, price: 54),
      CellData(x: "13:00:00", y: 11, price: 54),
      CellData(x: "13:00:00", y: 12, price: 54),
      CellData(x: "13:00:00", y: 13, price: 54),
      CellData(x: "13:00:00", y: 14, price: 54),
      CellData(x: "13:00:00", y: 15, price: 54),
      CellData(x: "13:00:00", y: 16, price: 54),
      CellData(x: "13:00:00", y: 17, price: 54),
      CellData(x: "13:00:00", y: 18, price: 54),
      CellData(x: "13:00:00", y: 19, price: 54),
      CellData(x: "13:00:00", y: 20, price: 54),
      CellData(x: "13:00:00", y: 21, price: 54),
      CellData(x: "13:00:00", y: 22, price: 54),
      CellData(x: "13:00:00", y: 23, price: 54),
      CellData(x: "13:00:00", y: 24, price: 54),
      CellData(x: "13:00:00", y: 25, price: 54),
      CellData(x: "13:00:00", y: 26, price: 54),
      CellData(x: "13:00:00", y: 27, price: 54),
      CellData(x: "13:00:00", y: 28, price: 54),
      CellData(x: "13:00:00", y: 29, price: 54),
      CellData(x: "13:00:00", y: 30, price: 54),
      CellData(x: "13:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "14:00:00", y: 1, price: 54),
      CellData(x: "14:00:00", y: 2, price: 54),
      CellData(x: "14:00:00", y: 3, price: 54),
      CellData(x: "14:00:00", y: 4, price: 54),
      CellData(x: "14:00:00", y: 5, price: 54),
      CellData(x: "14:00:00", y: 6, price: 54),
      CellData(x: "14:00:00", y: 7, price: 54),
      CellData(x: "14:00:00", y: 8, price: 54),
      CellData(x: "14:00:00", y: 9, price: 54),
      CellData(x: "14:00:00", y: 10, price: 54),
      CellData(x: "14:00:00", y: 11, price: 54),
      CellData(x: "14:00:00", y: 12, price: 54),
      CellData(x: "14:00:00", y: 13, price: 54),
      CellData(x: "14:00:00", y: 14, price: 54),
      CellData(x: "14:00:00", y: 15, price: 54),
      CellData(x: "14:00:00", y: 16, price: 54),
      CellData(x: "14:00:00", y: 17, price: 54),
      CellData(x: "14:00:00", y: 18, price: 54),
      CellData(x: "14:00:00", y: 19, price: 54),
      CellData(x: "14:00:00", y: 20, price: 54),
      CellData(x: "14:00:00", y: 21, price: 54),
      CellData(x: "14:00:00", y: 22, price: 54),
      CellData(x: "14:00:00", y: 23, price: 54),
      CellData(x: "14:00:00", y: 24, price: 54),
      CellData(x: "14:00:00", y: 25, price: 54),
      CellData(x: "14:00:00", y: 26, price: 54),
      CellData(x: "14:00:00", y: 27, price: 54),
      CellData(x: "14:00:00", y: 28, price: 54),
      CellData(x: "14:00:00", y: 29, price: 54),
      CellData(x: "14:00:00", y: 30, price: 54),
      CellData(x: "14:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "15:00:00", y: 1, price: 54),
      CellData(x: "15:00:00", y: 2, price: 54),
      CellData(x: "15:00:00", y: 3, price: 54),
      CellData(x: "15:00:00", y: 4, price: 54),
      CellData(x: "15:00:00", y: 5, price: 54),
      CellData(x: "15:00:00", y: 6, price: 54),
      CellData(x: "15:00:00", y: 7, price: 54),
      CellData(x: "15:00:00", y: 8, price: 54),
      CellData(x: "15:00:00", y: 9, price: 54),
      CellData(x: "15:00:00", y: 10, price: 54),
      CellData(x: "15:00:00", y: 11, price: 54),
      CellData(x: "15:00:00", y: 12, price: 54),
      CellData(x: "15:00:00", y: 13, price: 54),
      CellData(x: "15:00:00", y: 14, price: 54),
      CellData(x: "15:00:00", y: 15, price: 54),
      CellData(x: "15:00:00", y: 16, price: 54),
      CellData(x: "15:00:00", y: 17, price: 54),
      CellData(x: "15:00:00", y: 18, price: 54),
      CellData(x: "15:00:00", y: 19, price: 54),
      CellData(x: "15:00:00", y: 20, price: 54),
      CellData(x: "15:00:00", y: 21, price: 54),
      CellData(x: "15:00:00", y: 22, price: 54),
      CellData(x: "15:00:00", y: 23, price: 54),
      CellData(x: "15:00:00", y: 24, price: 54),
      CellData(x: "15:00:00", y: 25, price: 54),
      CellData(x: "15:00:00", y: 26, price: 54),
      CellData(x: "15:00:00", y: 27, price: 54),
      CellData(x: "15:00:00", y: 28, price: 54),
      CellData(x: "15:00:00", y: 29, price: 54),
      CellData(x: "15:00:00", y: 30, price: 54),
      CellData(x: "15:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "16:00:00", y: 1, price: 54),
      CellData(x: "16:00:00", y: 2, price: 54),
      CellData(x: "16:00:00", y: 3, price: 54),
      CellData(x: "16:00:00", y: 4, price: 54),
      CellData(x: "16:00:00", y: 5, price: 54),
      CellData(x: "16:00:00", y: 6, price: 54),
      CellData(x: "16:00:00", y: 7, price: 54),
      CellData(x: "16:00:00", y: 8, price: 54),
      CellData(x: "16:00:00", y: 9, price: 54),
      CellData(x: "16:00:00", y: 10, price: 54),
      CellData(x: "16:00:00", y: 11, price: 54),
      CellData(x: "16:00:00", y: 12, price: 54),
      CellData(x: "16:00:00", y: 13, price: 54),
      CellData(x: "16:00:00", y: 14, price: 54),
      CellData(x: "16:00:00", y: 15, price: 54),
      CellData(x: "16:00:00", y: 16, price: 54),
      CellData(x: "16:00:00", y: 17, price: 54),
      CellData(x: "16:00:00", y: 18, price: 54),
      CellData(x: "16:00:00", y: 19, price: 54),
      CellData(x: "16:00:00", y: 20, price: 54),
      CellData(x: "16:00:00", y: 21, price: 54),
      CellData(x: "16:00:00", y: 22, price: 54),
      CellData(x: "16:00:00", y: 23, price: 54),
      CellData(x: "16:00:00", y: 24, price: 54),
      CellData(x: "16:00:00", y: 25, price: 54),
      CellData(x: "16:00:00", y: 26, price: 54),
      CellData(x: "16:00:00", y: 27, price: 54),
      CellData(x: "16:00:00", y: 28, price: 54),
      CellData(x: "16:00:00", y: 29, price: 54),
      CellData(x: "16:00:00", y: 30, price: 54),
      CellData(x: "16:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "17:00:00", y: 1, price: 54),
      CellData(x: "17:00:00", y: 2, price: 54),
      CellData(x: "17:00:00", y: 3, price: 54),
      CellData(x: "17:00:00", y: 4, price: 54),
      CellData(x: "17:00:00", y: 5, price: 54),
      CellData(x: "17:00:00", y: 6, price: 54),
      CellData(x: "17:00:00", y: 7, price: 54),
      CellData(x: "17:00:00", y: 8, price: 54),
      CellData(x: "17:00:00", y: 9, price: 54),
      CellData(x: "17:00:00", y: 10, price: 54),
      CellData(x: "17:00:00", y: 11, price: 54),
      CellData(x: "17:00:00", y: 12, price: 54),
      CellData(x: "17:00:00", y: 13, price: 54),
      CellData(x: "17:00:00", y: 14, price: 54),
      CellData(x: "17:00:00", y: 15, price: 54),
      CellData(x: "17:00:00", y: 16, price: 54),
      CellData(x: "17:00:00", y: 17, price: 54),
      CellData(x: "17:00:00", y: 18, price: 54),
      CellData(x: "17:00:00", y: 19, price: 54),
      CellData(x: "17:00:00", y: 20, price: 54),
      CellData(x: "17:00:00", y: 21, price: 54),
      CellData(x: "17:00:00", y: 22, price: 54),
      CellData(x: "17:00:00", y: 23, price: 54),
      CellData(x: "17:00:00", y: 24, price: 54),
      CellData(x: "17:00:00", y: 25, price: 54),
      CellData(x: "17:00:00", y: 26, price: 54),
      CellData(x: "17:00:00", y: 27, price: 54),
      CellData(x: "17:00:00", y: 28, price: 54),
      CellData(x: "17:00:00", y: 29, price: 54),
      CellData(x: "17:00:00", y: 30, price: 54),
      CellData(x: "17:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "18:00:00", y: 1, price: 54),
      CellData(x: "18:00:00", y: 2, price: 54),
      CellData(x: "18:00:00", y: 3, price: 54),
      CellData(x: "18:00:00", y: 4, price: 54),
      CellData(x: "18:00:00", y: 5, price: 54),
      CellData(x: "18:00:00", y: 6, price: 54),
      CellData(x: "18:00:00", y: 7, price: 54),
      CellData(x: "18:00:00", y: 8, price: 54),
      CellData(x: "18:00:00", y: 9, price: 54),
      CellData(x: "18:00:00", y: 10, price: 54),
      CellData(x: "18:00:00", y: 11, price: 54),
      CellData(x: "18:00:00", y: 12, price: 54),
      CellData(x: "18:00:00", y: 13, price: 54),
      CellData(x: "18:00:00", y: 14, price: 54),
      CellData(x: "18:00:00", y: 15, price: 54),
      CellData(x: "18:00:00", y: 16, price: 54),
      CellData(x: "18:00:00", y: 17, price: 54),
      CellData(x: "18:00:00", y: 18, price: 54),
      CellData(x: "18:00:00", y: 19, price: 54),
      CellData(x: "18:00:00", y: 20, price: 54),
      CellData(x: "18:00:00", y: 21, price: 54),
      CellData(x: "18:00:00", y: 22, price: 54),
      CellData(x: "18:00:00", y: 23, price: 54),
      CellData(x: "18:00:00", y: 24, price: 54),
      CellData(x: "18:00:00", y: 25, price: 54),
      CellData(x: "18:00:00", y: 26, price: 54),
      CellData(x: "18:00:00", y: 27, price: 54),
      CellData(x: "18:00:00", y: 28, price: 54),
      CellData(x: "18:00:00", y: 29, price: 54),
      CellData(x: "18:00:00", y: 30, price: 54),
      CellData(x: "18:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "19:00:00", y: 1, price: 54),
      CellData(x: "19:00:00", y: 2, price: 54),
      CellData(x: "19:00:00", y: 3, price: 54),
      CellData(x: "19:00:00", y: 4, price: 54),
      CellData(x: "19:00:00", y: 5, price: 54),
      CellData(x: "19:00:00", y: 6, price: 54),
      CellData(x: "19:00:00", y: 7, price: 54),
      CellData(x: "19:00:00", y: 8, price: 54),
      CellData(x: "19:00:00", y: 9, price: 54),
      CellData(x: "19:00:00", y: 10, price: 54),
      CellData(x: "19:00:00", y: 11, price: 54),
      CellData(x: "19:00:00", y: 12, price: 54),
      CellData(x: "19:00:00", y: 13, price: 54),
      CellData(x: "19:00:00", y: 14, price: 54),
      CellData(x: "19:00:00", y: 15, price: 54),
      CellData(x: "19:00:00", y: 16, price: 54),
      CellData(x: "19:00:00", y: 17, price: 54),
      CellData(x: "19:00:00", y: 18, price: 54),
      CellData(x: "19:00:00", y: 19, price: 54),
      CellData(x: "19:00:00", y: 20, price: 54),
      CellData(x: "19:00:00", y: 21, price: 54),
      CellData(x: "19:00:00", y: 22, price: 54),
      CellData(x: "19:00:00", y: 23, price: 54),
      CellData(x: "19:00:00", y: 24, price: 54),
      CellData(x: "19:00:00", y: 25, price: 54),
      CellData(x: "19:00:00", y: 26, price: 54),
      CellData(x: "19:00:00", y: 27, price: 54),
      CellData(x: "19:00:00", y: 28, price: 54),
      CellData(x: "19:00:00", y: 29, price: 54),
      CellData(x: "19:00:00", y: 30, price: 54),
      CellData(x: "19:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "20:00:00", y: 1, price: 54),
      CellData(x: "20:00:00", y: 2, price: 54),
      CellData(x: "20:00:00", y: 3, price: 54),
      CellData(x: "20:00:00", y: 4, price: 54),
      CellData(x: "20:00:00", y: 5, price: 54),
      CellData(x: "20:00:00", y: 6, price: 54),
      CellData(x: "20:00:00", y: 7, price: 54),
      CellData(x: "20:00:00", y: 8, price: 54),
      CellData(x: "20:00:00", y: 9, price: 54),
      CellData(x: "20:00:00", y: 10, price: 54),
      CellData(x: "20:00:00", y: 11, price: 54),
      CellData(x: "20:00:00", y: 12, price: 54),
      CellData(x: "20:00:00", y: 13, price: 54),
      CellData(x: "20:00:00", y: 14, price: 54),
      CellData(x: "20:00:00", y: 15, price: 54),
      CellData(x: "20:00:00", y: 16, price: 54),
      CellData(x: "20:00:00", y: 17, price: 54),
      CellData(x: "20:00:00", y: 18, price: 54),
      CellData(x: "20:00:00", y: 19, price: 54),
      CellData(x: "20:00:00", y: 20, price: 54),
      CellData(x: "20:00:00", y: 21, price: 54),
      CellData(x: "20:00:00", y: 22, price: 54),
      CellData(x: "20:00:00", y: 23, price: 54),
      CellData(x: "20:00:00", y: 24, price: 54),
      CellData(x: "20:00:00", y: 25, price: 54),
      CellData(x: "20:00:00", y: 26, price: 54),
      CellData(x: "20:00:00", y: 27, price: 54),
      CellData(x: "20:00:00", y: 28, price: 54),
      CellData(x: "20:00:00", y: 29, price: 54),
      CellData(x: "20:00:00", y: 30, price: 54),
      CellData(x: "20:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "21:00:00", y: 1, price: 54),
      CellData(x: "21:00:00", y: 2, price: 54),
      CellData(x: "21:00:00", y: 3, price: 54),
      CellData(x: "21:00:00", y: 4, price: 54),
      CellData(x: "21:00:00", y: 5, price: 54),
      CellData(x: "21:00:00", y: 6, price: 54),
      CellData(x: "21:00:00", y: 7, price: 54),
      CellData(x: "21:00:00", y: 8, price: 54),
      CellData(x: "21:00:00", y: 9, price: 54),
      CellData(x: "21:00:00", y: 10, price: 54),
      CellData(x: "21:00:00", y: 11, price: 54),
      CellData(x: "21:00:00", y: 12, price: 54),
      CellData(x: "21:00:00", y: 13, price: 54),
      CellData(x: "21:00:00", y: 14, price: 54),
      CellData(x: "21:00:00", y: 15, price: 54),
      CellData(x: "21:00:00", y: 16, price: 54),
      CellData(x: "21:00:00", y: 17, price: 54),
      CellData(x: "21:00:00", y: 18, price: 54),
      CellData(x: "21:00:00", y: 19, price: 54),
      CellData(x: "21:00:00", y: 20, price: 54),
      CellData(x: "21:00:00", y: 21, price: 54),
      CellData(x: "21:00:00", y: 22, price: 54),
      CellData(x: "21:00:00", y: 23, price: 54),
      CellData(x: "21:00:00", y: 24, price: 54),
      CellData(x: "21:00:00", y: 25, price: 54),
      CellData(x: "21:00:00", y: 26, price: 54),
      CellData(x: "21:00:00", y: 27, price: 54),
      CellData(x: "21:00:00", y: 28, price: 54),
      CellData(x: "21:00:00", y: 29, price: 54),
      CellData(x: "21:00:00", y: 30, price: 54),
      CellData(x: "21:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "22:00:00", y: 1, price: 54),
      CellData(x: "22:00:00", y: 2, price: 54),
      CellData(x: "22:00:00", y: 3, price: 54),
      CellData(x: "22:00:00", y: 4, price: 54),
      CellData(x: "22:00:00", y: 5, price: 54),
      CellData(x: "22:00:00", y: 6, price: 54),
      CellData(x: "22:00:00", y: 7, price: 54),
      CellData(x: "22:00:00", y: 8, price: 54),
      CellData(x: "22:00:00", y: 9, price: 54),
      CellData(x: "22:00:00", y: 10, price: 54),
      CellData(x: "22:00:00", y: 11, price: 54),
      CellData(x: "22:00:00", y: 12, price: 54),
      CellData(x: "22:00:00", y: 13, price: 54),
      CellData(x: "22:00:00", y: 14, price: 54),
      CellData(x: "22:00:00", y: 15, price: 54),
      CellData(x: "22:00:00", y: 16, price: 54),
      CellData(x: "22:00:00", y: 17, price: 54),
      CellData(x: "22:00:00", y: 18, price: 54),
      CellData(x: "22:00:00", y: 19, price: 54),
      CellData(x: "22:00:00", y: 20, price: 54),
      CellData(x: "22:00:00", y: 21, price: 54),
      CellData(x: "22:00:00", y: 22, price: 54),
      CellData(x: "22:00:00", y: 23, price: 54),
      CellData(x: "22:00:00", y: 24, price: 54),
      CellData(x: "22:00:00", y: 25, price: 54),
      CellData(x: "22:00:00", y: 26, price: 54),
      CellData(x: "22:00:00", y: 27, price: 54),
      CellData(x: "22:00:00", y: 28, price: 54),
      CellData(x: "22:00:00", y: 29, price: 54),
      CellData(x: "22:00:00", y: 30, price: 54),
      CellData(x: "22:00:00", y: 31, price: 54),
    ],
    [
      CellData(x: "23:00:00", y: 1, price: 54),
      CellData(x: "23:00:00", y: 2, price: 54),
      CellData(x: "23:00:00", y: 3, price: 54),
      CellData(x: "23:00:00", y: 4, price: 54),
      CellData(x: "23:00:00", y: 5, price: 54),
      CellData(x: "23:00:00", y: 6, price: 54),
      CellData(x: "23:00:00", y: 7, price: 54),
      CellData(x: "23:00:00", y: 8, price: 54),
      CellData(x: "23:00:00", y: 9, price: 54),
      CellData(x: "23:00:00", y: 10, price: 54),
      CellData(x: "23:00:00", y: 11, price: 54),
      CellData(x: "23:00:00", y: 12, price: 54),
      CellData(x: "23:00:00", y: 13, price: 54),
      CellData(x: "23:00:00", y: 14, price: 54),
      CellData(x: "23:00:00", y: 15, price: 54),
      CellData(x: "23:00:00", y: 16, price: 54),
      CellData(x: "23:00:00", y: 17, price: 54),
      CellData(x: "23:00:00", y: 18, price: 54),
      CellData(x: "23:00:00", y: 19, price: 54),
      CellData(x: "23:00:00", y: 20, price: 54),
      CellData(x: "23:00:00", y: 21, price: 54),
      CellData(x: "23:00:00", y: 22, price: 54),
      CellData(x: "23:00:00", y: 23, price: 54),
      CellData(x: "23:00:00", y: 24, price: 54),
      CellData(x: "23:00:00", y: 25, price: 54),
      CellData(x: "23:00:00", y: 26, price: 54),
      CellData(x: "23:00:00", y: 27, price: 54),
      CellData(x: "23:00:00", y: 28, price: 54),
      CellData(x: "23:00:00", y: 29, price: 54),
      CellData(x: "23:00:00", y: 30, price: 54),
      CellData(x: "23:00:00", y: 31, price: 54),
    ],
  ];
  List<List<CellData>> rowsCells1 = <List<CellData>>[
    [
      CellData(x: "00:00:00", y: 1, price: 54),
      CellData(x: "00:00:00", y: 2, price: 54),
      CellData(x: "00:00:00", y: 3, price: 54),
      CellData(x: "00:00:00", y: 4, price: 54),
      CellData(x: "00:00:00", y: 5, price: 54),
      CellData(x: "00:00:00", y: 6, price: 54),
      CellData(x: "00:00:00", y: 7, price: 54),
      CellData(x: "00:00:00", y: 8, price: 54),
      CellData(x: "00:00:00", y: 9, price: 54),
      CellData(x: "00:00:00", y: 10, price: 54),
      CellData(x: "00:00:00", y: 11, price: 54),
      CellData(x: "00:00:00", y: 12, price: 54),
      CellData(x: "00:00:00", y: 13, price: 54),
      CellData(x: "00:00:00", y: 14, price: 54),
      CellData(x: "00:00:00", y: 15, price: 54),
      CellData(x: "00:00:00", y: 16, price: 54),
      CellData(x: "00:00:00", y: 17, price: 54),
      CellData(x: "00:00:00", y: 18, price: 54),
      CellData(x: "00:00:00", y: 19, price: 54),
      CellData(x: "00:00:00", y: 20, price: 54),
      CellData(x: "00:00:00", y: 21, price: 54),
      CellData(x: "00:00:00", y: 22, price: 54),
      CellData(x: "00:00:00", y: 23, price: 54),
      CellData(x: "00:00:00", y: 24, price: 54),
      CellData(x: "00:00:00", y: 25, price: 54),
      CellData(x: "00:00:00", y: 26, price: 54),
      CellData(x: "00:00:00", y: 27, price: 54),
      CellData(x: "00:00:00", y: 28, price: 54),
      CellData(x: "00:00:00", y: 29, price: 54),
      CellData(x: "00:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "01:00:00", y: 1, price: 54),
      CellData(x: "01:00:00", y: 2, price: 54),
      CellData(x: "01:00:00", y: 3, price: 54),
      CellData(x: "01:00:00", y: 4, price: 54),
      CellData(x: "01:00:00", y: 5, price: 54),
      CellData(x: "01:00:00", y: 6, price: 54),
      CellData(x: "01:00:00", y: 7, price: 54),
      CellData(x: "01:00:00", y: 8, price: 54),
      CellData(x: "01:00:00", y: 9, price: 54),
      CellData(x: "01:00:00", y: 10, price: 54),
      CellData(x: "01:00:00", y: 11, price: 54),
      CellData(x: "01:00:00", y: 12, price: 54),
      CellData(x: "01:00:00", y: 13, price: 54),
      CellData(x: "01:00:00", y: 14, price: 54),
      CellData(x: "01:00:00", y: 15, price: 54),
      CellData(x: "01:00:00", y: 16, price: 54),
      CellData(x: "01:00:00", y: 17, price: 54),
      CellData(x: "01:00:00", y: 18, price: 54),
      CellData(x: "01:00:00", y: 19, price: 54),
      CellData(x: "01:00:00", y: 20, price: 54),
      CellData(x: "01:00:00", y: 21, price: 54),
      CellData(x: "01:00:00", y: 22, price: 54),
      CellData(x: "01:00:00", y: 23, price: 54),
      CellData(x: "01:00:00", y: 24, price: 54),
      CellData(x: "01:00:00", y: 25, price: 54),
      CellData(x: "01:00:00", y: 26, price: 54),
      CellData(x: "01:00:00", y: 27, price: 54),
      CellData(x: "01:00:00", y: 28, price: 54),
      CellData(x: "01:00:00", y: 29, price: 54),
      CellData(x: "01:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "02:00:00", y: 1, price: 54),
      CellData(x: "02:00:00", y: 2, price: 54),
      CellData(x: "02:00:00", y: 3, price: 54),
      CellData(x: "02:00:00", y: 4, price: 54),
      CellData(x: "02:00:00", y: 5, price: 54),
      CellData(x: "02:00:00", y: 6, price: 54),
      CellData(x: "02:00:00", y: 7, price: 54),
      CellData(x: "02:00:00", y: 8, price: 54),
      CellData(x: "02:00:00", y: 9, price: 54),
      CellData(x: "02:00:00", y: 10, price: 54),
      CellData(x: "02:00:00", y: 11, price: 54),
      CellData(x: "02:00:00", y: 12, price: 54),
      CellData(x: "02:00:00", y: 13, price: 54),
      CellData(x: "02:00:00", y: 14, price: 54),
      CellData(x: "02:00:00", y: 15, price: 54),
      CellData(x: "02:00:00", y: 16, price: 54),
      CellData(x: "02:00:00", y: 17, price: 54),
      CellData(x: "02:00:00", y: 18, price: 54),
      CellData(x: "02:00:00", y: 19, price: 54),
      CellData(x: "02:00:00", y: 20, price: 54),
      CellData(x: "02:00:00", y: 21, price: 54),
      CellData(x: "02:00:00", y: 22, price: 54),
      CellData(x: "02:00:00", y: 23, price: 54),
      CellData(x: "02:00:00", y: 24, price: 54),
      CellData(x: "02:00:00", y: 25, price: 54),
      CellData(x: "02:00:00", y: 26, price: 54),
      CellData(x: "02:00:00", y: 27, price: 54),
      CellData(x: "02:00:00", y: 28, price: 54),
      CellData(x: "02:00:00", y: 29, price: 54),
      CellData(x: "02:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "03:00:00", y: 1, price: 54),
      CellData(x: "03:00:00", y: 2, price: 54),
      CellData(x: "03:00:00", y: 3, price: 54),
      CellData(x: "03:00:00", y: 4, price: 54),
      CellData(x: "03:00:00", y: 5, price: 54),
      CellData(x: "03:00:00", y: 6, price: 54),
      CellData(x: "03:00:00", y: 7, price: 54),
      CellData(x: "03:00:00", y: 8, price: 54),
      CellData(x: "03:00:00", y: 9, price: 54),
      CellData(x: "03:00:00", y: 10, price: 54),
      CellData(x: "03:00:00", y: 11, price: 54),
      CellData(x: "03:00:00", y: 12, price: 54),
      CellData(x: "03:00:00", y: 13, price: 54),
      CellData(x: "03:00:00", y: 14, price: 54),
      CellData(x: "03:00:00", y: 15, price: 54),
      CellData(x: "03:00:00", y: 16, price: 54),
      CellData(x: "03:00:00", y: 17, price: 54),
      CellData(x: "03:00:00", y: 18, price: 54),
      CellData(x: "03:00:00", y: 19, price: 54),
      CellData(x: "03:00:00", y: 20, price: 54),
      CellData(x: "03:00:00", y: 21, price: 54),
      CellData(x: "03:00:00", y: 22, price: 54),
      CellData(x: "03:00:00", y: 23, price: 54),
      CellData(x: "03:00:00", y: 24, price: 54),
      CellData(x: "03:00:00", y: 25, price: 54),
      CellData(x: "03:00:00", y: 26, price: 54),
      CellData(x: "03:00:00", y: 27, price: 54),
      CellData(x: "03:00:00", y: 28, price: 54),
      CellData(x: "03:00:00", y: 29, price: 54),
      CellData(x: "03:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "04:00:00", y: 1, price: 54),
      CellData(x: "04:00:00", y: 2, price: 54),
      CellData(x: "04:00:00", y: 3, price: 54),
      CellData(x: "04:00:00", y: 4, price: 54),
      CellData(x: "04:00:00", y: 5, price: 54),
      CellData(x: "04:00:00", y: 6, price: 54),
      CellData(x: "04:00:00", y: 7, price: 54),
      CellData(x: "04:00:00", y: 8, price: 54),
      CellData(x: "04:00:00", y: 9, price: 54),
      CellData(x: "04:00:00", y: 10, price: 54),
      CellData(x: "04:00:00", y: 11, price: 54),
      CellData(x: "04:00:00", y: 12, price: 54),
      CellData(x: "04:00:00", y: 13, price: 54),
      CellData(x: "04:00:00", y: 14, price: 54),
      CellData(x: "04:00:00", y: 15, price: 54),
      CellData(x: "04:00:00", y: 16, price: 54),
      CellData(x: "04:00:00", y: 17, price: 54),
      CellData(x: "04:00:00", y: 18, price: 54),
      CellData(x: "04:00:00", y: 19, price: 54),
      CellData(x: "04:00:00", y: 20, price: 54),
      CellData(x: "04:00:00", y: 21, price: 54),
      CellData(x: "04:00:00", y: 22, price: 54),
      CellData(x: "04:00:00", y: 23, price: 54),
      CellData(x: "04:00:00", y: 24, price: 54),
      CellData(x: "04:00:00", y: 25, price: 54),
      CellData(x: "04:00:00", y: 26, price: 54),
      CellData(x: "04:00:00", y: 27, price: 54),
      CellData(x: "04:00:00", y: 28, price: 54),
      CellData(x: "04:00:00", y: 29, price: 54),
      CellData(x: "04:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "05:00:00", y: 1, price: 54),
      CellData(x: "05:00:00", y: 2, price: 54),
      CellData(x: "05:00:00", y: 3, price: 54),
      CellData(x: "05:00:00", y: 4, price: 54),
      CellData(x: "05:00:00", y: 5, price: 54),
      CellData(x: "05:00:00", y: 6, price: 54),
      CellData(x: "05:00:00", y: 7, price: 54),
      CellData(x: "05:00:00", y: 8, price: 54),
      CellData(x: "05:00:00", y: 9, price: 54),
      CellData(x: "05:00:00", y: 10, price: 54),
      CellData(x: "05:00:00", y: 11, price: 54),
      CellData(x: "05:00:00", y: 12, price: 54),
      CellData(x: "05:00:00", y: 13, price: 54),
      CellData(x: "05:00:00", y: 14, price: 54),
      CellData(x: "05:00:00", y: 15, price: 54),
      CellData(x: "05:00:00", y: 16, price: 54),
      CellData(x: "05:00:00", y: 17, price: 54),
      CellData(x: "05:00:00", y: 18, price: 54),
      CellData(x: "05:00:00", y: 19, price: 54),
      CellData(x: "05:00:00", y: 20, price: 54),
      CellData(x: "05:00:00", y: 21, price: 54),
      CellData(x: "05:00:00", y: 22, price: 54),
      CellData(x: "05:00:00", y: 23, price: 54),
      CellData(x: "05:00:00", y: 24, price: 54),
      CellData(x: "05:00:00", y: 25, price: 54),
      CellData(x: "05:00:00", y: 26, price: 54),
      CellData(x: "05:00:00", y: 27, price: 54),
      CellData(x: "05:00:00", y: 28, price: 54),
      CellData(x: "05:00:00", y: 29, price: 54),
      CellData(x: "05:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "06:00:00", y: 1, price: 54),
      CellData(x: "06:00:00", y: 2, price: 54),
      CellData(x: "06:00:00", y: 3, price: 54),
      CellData(x: "06:00:00", y: 4, price: 54),
      CellData(x: "06:00:00", y: 5, price: 54),
      CellData(x: "06:00:00", y: 6, price: 54),
      CellData(x: "06:00:00", y: 7, price: 54),
      CellData(x: "06:00:00", y: 8, price: 54),
      CellData(x: "06:00:00", y: 9, price: 54),
      CellData(x: "06:00:00", y: 10, price: 54),
      CellData(x: "06:00:00", y: 11, price: 54),
      CellData(x: "06:00:00", y: 12, price: 54),
      CellData(x: "06:00:00", y: 13, price: 54),
      CellData(x: "06:00:00", y: 14, price: 54),
      CellData(x: "06:00:00", y: 15, price: 54),
      CellData(x: "06:00:00", y: 16, price: 54),
      CellData(x: "06:00:00", y: 17, price: 54),
      CellData(x: "06:00:00", y: 18, price: 54),
      CellData(x: "06:00:00", y: 19, price: 54),
      CellData(x: "06:00:00", y: 20, price: 54),
      CellData(x: "06:00:00", y: 21, price: 54),
      CellData(x: "06:00:00", y: 22, price: 54),
      CellData(x: "06:00:00", y: 23, price: 54),
      CellData(x: "06:00:00", y: 24, price: 54),
      CellData(x: "06:00:00", y: 25, price: 54),
      CellData(x: "06:00:00", y: 26, price: 54),
      CellData(x: "06:00:00", y: 27, price: 54),
      CellData(x: "06:00:00", y: 28, price: 54),
      CellData(x: "06:00:00", y: 29, price: 54),
      CellData(x: "06:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "07:00:00", y: 1, price: 54),
      CellData(x: "07:00:00", y: 2, price: 54),
      CellData(x: "07:00:00", y: 3, price: 54),
      CellData(x: "07:00:00", y: 4, price: 54),
      CellData(x: "07:00:00", y: 5, price: 54),
      CellData(x: "07:00:00", y: 6, price: 54),
      CellData(x: "07:00:00", y: 7, price: 54),
      CellData(x: "07:00:00", y: 8, price: 54),
      CellData(x: "07:00:00", y: 9, price: 54),
      CellData(x: "07:00:00", y: 10, price: 54),
      CellData(x: "07:00:00", y: 11, price: 54),
      CellData(x: "07:00:00", y: 12, price: 54),
      CellData(x: "07:00:00", y: 13, price: 54),
      CellData(x: "07:00:00", y: 14, price: 54),
      CellData(x: "07:00:00", y: 15, price: 54),
      CellData(x: "07:00:00", y: 16, price: 54),
      CellData(x: "07:00:00", y: 17, price: 54),
      CellData(x: "07:00:00", y: 18, price: 54),
      CellData(x: "07:00:00", y: 19, price: 54),
      CellData(x: "07:00:00", y: 20, price: 54),
      CellData(x: "07:00:00", y: 21, price: 54),
      CellData(x: "07:00:00", y: 22, price: 54),
      CellData(x: "07:00:00", y: 23, price: 54),
      CellData(x: "07:00:00", y: 24, price: 54),
      CellData(x: "07:00:00", y: 25, price: 54),
      CellData(x: "07:00:00", y: 26, price: 54),
      CellData(x: "07:00:00", y: 27, price: 54),
      CellData(x: "07:00:00", y: 28, price: 54),
      CellData(x: "07:00:00", y: 29, price: 54),
      CellData(x: "07:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "08:00:00", y: 1, price: 54),
      CellData(x: "08:00:00", y: 2, price: 54),
      CellData(x: "08:00:00", y: 3, price: 54),
      CellData(x: "08:00:00", y: 4, price: 54),
      CellData(x: "08:00:00", y: 5, price: 54),
      CellData(x: "08:00:00", y: 6, price: 54),
      CellData(x: "08:00:00", y: 7, price: 54),
      CellData(x: "08:00:00", y: 8, price: 54),
      CellData(x: "08:00:00", y: 9, price: 54),
      CellData(x: "08:00:00", y: 10, price: 54),
      CellData(x: "08:00:00", y: 11, price: 54),
      CellData(x: "08:00:00", y: 12, price: 54),
      CellData(x: "08:00:00", y: 13, price: 54),
      CellData(x: "08:00:00", y: 14, price: 54),
      CellData(x: "08:00:00", y: 15, price: 54),
      CellData(x: "08:00:00", y: 16, price: 54),
      CellData(x: "08:00:00", y: 17, price: 54),
      CellData(x: "08:00:00", y: 18, price: 54),
      CellData(x: "08:00:00", y: 19, price: 54),
      CellData(x: "08:00:00", y: 20, price: 54),
      CellData(x: "08:00:00", y: 21, price: 54),
      CellData(x: "08:00:00", y: 22, price: 54),
      CellData(x: "08:00:00", y: 23, price: 54),
      CellData(x: "08:00:00", y: 24, price: 54),
      CellData(x: "08:00:00", y: 25, price: 54),
      CellData(x: "08:00:00", y: 26, price: 54),
      CellData(x: "08:00:00", y: 27, price: 54),
      CellData(x: "08:00:00", y: 28, price: 54),
      CellData(x: "08:00:00", y: 29, price: 54),
      CellData(x: "08:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "09:00:00", y: 1, price: 54),
      CellData(x: "09:00:00", y: 2, price: 54),
      CellData(x: "09:00:00", y: 3, price: 54),
      CellData(x: "09:00:00", y: 4, price: 54),
      CellData(x: "09:00:00", y: 5, price: 54),
      CellData(x: "09:00:00", y: 6, price: 54),
      CellData(x: "09:00:00", y: 7, price: 54),
      CellData(x: "09:00:00", y: 8, price: 54),
      CellData(x: "09:00:00", y: 9, price: 54),
      CellData(x: "09:00:00", y: 10, price: 54),
      CellData(x: "09:00:00", y: 11, price: 54),
      CellData(x: "09:00:00", y: 12, price: 54),
      CellData(x: "09:00:00", y: 13, price: 54),
      CellData(x: "09:00:00", y: 14, price: 54),
      CellData(x: "09:00:00", y: 15, price: 54),
      CellData(x: "09:00:00", y: 16, price: 54),
      CellData(x: "09:00:00", y: 17, price: 54),
      CellData(x: "09:00:00", y: 18, price: 54),
      CellData(x: "09:00:00", y: 19, price: 54),
      CellData(x: "09:00:00", y: 20, price: 54),
      CellData(x: "09:00:00", y: 21, price: 54),
      CellData(x: "09:00:00", y: 22, price: 54),
      CellData(x: "09:00:00", y: 23, price: 54),
      CellData(x: "09:00:00", y: 24, price: 54),
      CellData(x: "09:00:00", y: 25, price: 54),
      CellData(x: "09:00:00", y: 26, price: 54),
      CellData(x: "09:00:00", y: 27, price: 54),
      CellData(x: "09:00:00", y: 28, price: 54),
      CellData(x: "09:00:00", y: 29, price: 54),
      CellData(x: "09:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "10:00:00", y: 1, price: 54),
      CellData(x: "10:00:00", y: 2, price: 54),
      CellData(x: "10:00:00", y: 3, price: 54),
      CellData(x: "10:00:00", y: 4, price: 54),
      CellData(x: "10:00:00", y: 5, price: 54),
      CellData(x: "10:00:00", y: 6, price: 54),
      CellData(x: "10:00:00", y: 7, price: 54),
      CellData(x: "10:00:00", y: 8, price: 54),
      CellData(x: "10:00:00", y: 9, price: 54),
      CellData(x: "10:00:00", y: 10, price: 54),
      CellData(x: "10:00:00", y: 11, price: 54),
      CellData(x: "10:00:00", y: 12, price: 54),
      CellData(x: "10:00:00", y: 13, price: 54),
      CellData(x: "10:00:00", y: 14, price: 54),
      CellData(x: "10:00:00", y: 15, price: 54),
      CellData(x: "10:00:00", y: 16, price: 54),
      CellData(x: "10:00:00", y: 17, price: 54),
      CellData(x: "10:00:00", y: 18, price: 54),
      CellData(x: "10:00:00", y: 19, price: 54),
      CellData(x: "10:00:00", y: 20, price: 54),
      CellData(x: "10:00:00", y: 21, price: 54),
      CellData(x: "10:00:00", y: 22, price: 54),
      CellData(x: "10:00:00", y: 23, price: 54),
      CellData(x: "10:00:00", y: 24, price: 54),
      CellData(x: "10:00:00", y: 25, price: 54),
      CellData(x: "10:00:00", y: 26, price: 54),
      CellData(x: "10:00:00", y: 27, price: 54),
      CellData(x: "10:00:00", y: 28, price: 54),
      CellData(x: "10:00:00", y: 29, price: 54),
      CellData(x: "10:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "11:00:00", y: 1, price: 54),
      CellData(x: "11:00:00", y: 2, price: 54),
      CellData(x: "11:00:00", y: 3, price: 54),
      CellData(x: "11:00:00", y: 4, price: 54),
      CellData(x: "11:00:00", y: 5, price: 54),
      CellData(x: "11:00:00", y: 6, price: 54),
      CellData(x: "11:00:00", y: 7, price: 54),
      CellData(x: "11:00:00", y: 8, price: 54),
      CellData(x: "11:00:00", y: 9, price: 54),
      CellData(x: "11:00:00", y: 10, price: 54),
      CellData(x: "11:00:00", y: 11, price: 54),
      CellData(x: "11:00:00", y: 12, price: 54),
      CellData(x: "11:00:00", y: 13, price: 54),
      CellData(x: "11:00:00", y: 14, price: 54),
      CellData(x: "11:00:00", y: 15, price: 54),
      CellData(x: "11:00:00", y: 16, price: 54),
      CellData(x: "11:00:00", y: 17, price: 54),
      CellData(x: "11:00:00", y: 18, price: 54),
      CellData(x: "11:00:00", y: 19, price: 54),
      CellData(x: "11:00:00", y: 20, price: 54),
      CellData(x: "11:00:00", y: 21, price: 54),
      CellData(x: "11:00:00", y: 22, price: 54),
      CellData(x: "11:00:00", y: 23, price: 54),
      CellData(x: "11:00:00", y: 24, price: 54),
      CellData(x: "11:00:00", y: 25, price: 54),
      CellData(x: "11:00:00", y: 26, price: 54),
      CellData(x: "11:00:00", y: 27, price: 54),
      CellData(x: "11:00:00", y: 28, price: 54),
      CellData(x: "11:00:00", y: 29, price: 54),
      CellData(x: "11:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "12:00:00", y: 1, price: 54),
      CellData(x: "12:00:00", y: 2, price: 54),
      CellData(x: "12:00:00", y: 3, price: 54),
      CellData(x: "12:00:00", y: 4, price: 54),
      CellData(x: "12:00:00", y: 5, price: 54),
      CellData(x: "12:00:00", y: 6, price: 54),
      CellData(x: "12:00:00", y: 7, price: 54),
      CellData(x: "12:00:00", y: 8, price: 54),
      CellData(x: "12:00:00", y: 9, price: 54),
      CellData(x: "12:00:00", y: 10, price: 54),
      CellData(x: "12:00:00", y: 11, price: 54),
      CellData(x: "12:00:00", y: 12, price: 54),
      CellData(x: "12:00:00", y: 13, price: 54),
      CellData(x: "12:00:00", y: 14, price: 54),
      CellData(x: "12:00:00", y: 15, price: 54),
      CellData(x: "12:00:00", y: 16, price: 54),
      CellData(x: "12:00:00", y: 17, price: 54),
      CellData(x: "12:00:00", y: 18, price: 54),
      CellData(x: "12:00:00", y: 19, price: 54),
      CellData(x: "12:00:00", y: 20, price: 54),
      CellData(x: "12:00:00", y: 21, price: 54),
      CellData(x: "12:00:00", y: 22, price: 54),
      CellData(x: "12:00:00", y: 23, price: 54),
      CellData(x: "12:00:00", y: 24, price: 54),
      CellData(x: "12:00:00", y: 25, price: 54),
      CellData(x: "12:00:00", y: 26, price: 54),
      CellData(x: "12:00:00", y: 27, price: 54),
      CellData(x: "12:00:00", y: 28, price: 54),
      CellData(x: "12:00:00", y: 29, price: 54),
      CellData(x: "12:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "13:00:00", y: 1, price: 54),
      CellData(x: "13:00:00", y: 2, price: 54),
      CellData(x: "13:00:00", y: 3, price: 54),
      CellData(x: "13:00:00", y: 4, price: 54),
      CellData(x: "13:00:00", y: 5, price: 54),
      CellData(x: "13:00:00", y: 6, price: 54),
      CellData(x: "13:00:00", y: 7, price: 54),
      CellData(x: "13:00:00", y: 8, price: 54),
      CellData(x: "13:00:00", y: 9, price: 54),
      CellData(x: "13:00:00", y: 10, price: 54),
      CellData(x: "13:00:00", y: 11, price: 54),
      CellData(x: "13:00:00", y: 12, price: 54),
      CellData(x: "13:00:00", y: 13, price: 54),
      CellData(x: "13:00:00", y: 14, price: 54),
      CellData(x: "13:00:00", y: 15, price: 54),
      CellData(x: "13:00:00", y: 16, price: 54),
      CellData(x: "13:00:00", y: 17, price: 54),
      CellData(x: "13:00:00", y: 18, price: 54),
      CellData(x: "13:00:00", y: 19, price: 54),
      CellData(x: "13:00:00", y: 20, price: 54),
      CellData(x: "13:00:00", y: 21, price: 54),
      CellData(x: "13:00:00", y: 22, price: 54),
      CellData(x: "13:00:00", y: 23, price: 54),
      CellData(x: "13:00:00", y: 24, price: 54),
      CellData(x: "13:00:00", y: 25, price: 54),
      CellData(x: "13:00:00", y: 26, price: 54),
      CellData(x: "13:00:00", y: 27, price: 54),
      CellData(x: "13:00:00", y: 28, price: 54),
      CellData(x: "13:00:00", y: 29, price: 54),
      CellData(x: "13:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "14:00:00", y: 1, price: 54),
      CellData(x: "14:00:00", y: 2, price: 54),
      CellData(x: "14:00:00", y: 3, price: 54),
      CellData(x: "14:00:00", y: 4, price: 54),
      CellData(x: "14:00:00", y: 5, price: 54),
      CellData(x: "14:00:00", y: 6, price: 54),
      CellData(x: "14:00:00", y: 7, price: 54),
      CellData(x: "14:00:00", y: 8, price: 54),
      CellData(x: "14:00:00", y: 9, price: 54),
      CellData(x: "14:00:00", y: 10, price: 54),
      CellData(x: "14:00:00", y: 11, price: 54),
      CellData(x: "14:00:00", y: 12, price: 54),
      CellData(x: "14:00:00", y: 13, price: 54),
      CellData(x: "14:00:00", y: 14, price: 54),
      CellData(x: "14:00:00", y: 15, price: 54),
      CellData(x: "14:00:00", y: 16, price: 54),
      CellData(x: "14:00:00", y: 17, price: 54),
      CellData(x: "14:00:00", y: 18, price: 54),
      CellData(x: "14:00:00", y: 19, price: 54),
      CellData(x: "14:00:00", y: 20, price: 54),
      CellData(x: "14:00:00", y: 21, price: 54),
      CellData(x: "14:00:00", y: 22, price: 54),
      CellData(x: "14:00:00", y: 23, price: 54),
      CellData(x: "14:00:00", y: 24, price: 54),
      CellData(x: "14:00:00", y: 25, price: 54),
      CellData(x: "14:00:00", y: 26, price: 54),
      CellData(x: "14:00:00", y: 27, price: 54),
      CellData(x: "14:00:00", y: 28, price: 54),
      CellData(x: "14:00:00", y: 29, price: 54),
      CellData(x: "14:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "15:00:00", y: 1, price: 54),
      CellData(x: "15:00:00", y: 2, price: 54),
      CellData(x: "15:00:00", y: 3, price: 54),
      CellData(x: "15:00:00", y: 4, price: 54),
      CellData(x: "15:00:00", y: 5, price: 54),
      CellData(x: "15:00:00", y: 6, price: 54),
      CellData(x: "15:00:00", y: 7, price: 54),
      CellData(x: "15:00:00", y: 8, price: 54),
      CellData(x: "15:00:00", y: 9, price: 54),
      CellData(x: "15:00:00", y: 10, price: 54),
      CellData(x: "15:00:00", y: 11, price: 54),
      CellData(x: "15:00:00", y: 12, price: 54),
      CellData(x: "15:00:00", y: 13, price: 54),
      CellData(x: "15:00:00", y: 14, price: 54),
      CellData(x: "15:00:00", y: 15, price: 54),
      CellData(x: "15:00:00", y: 16, price: 54),
      CellData(x: "15:00:00", y: 17, price: 54),
      CellData(x: "15:00:00", y: 18, price: 54),
      CellData(x: "15:00:00", y: 19, price: 54),
      CellData(x: "15:00:00", y: 20, price: 54),
      CellData(x: "15:00:00", y: 21, price: 54),
      CellData(x: "15:00:00", y: 22, price: 54),
      CellData(x: "15:00:00", y: 23, price: 54),
      CellData(x: "15:00:00", y: 24, price: 54),
      CellData(x: "15:00:00", y: 25, price: 54),
      CellData(x: "15:00:00", y: 26, price: 54),
      CellData(x: "15:00:00", y: 27, price: 54),
      CellData(x: "15:00:00", y: 28, price: 54),
      CellData(x: "15:00:00", y: 29, price: 54),
      CellData(x: "15:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "16:00:00", y: 1, price: 54),
      CellData(x: "16:00:00", y: 2, price: 54),
      CellData(x: "16:00:00", y: 3, price: 54),
      CellData(x: "16:00:00", y: 4, price: 54),
      CellData(x: "16:00:00", y: 5, price: 54),
      CellData(x: "16:00:00", y: 6, price: 54),
      CellData(x: "16:00:00", y: 7, price: 54),
      CellData(x: "16:00:00", y: 8, price: 54),
      CellData(x: "16:00:00", y: 9, price: 54),
      CellData(x: "16:00:00", y: 10, price: 54),
      CellData(x: "16:00:00", y: 11, price: 54),
      CellData(x: "16:00:00", y: 12, price: 54),
      CellData(x: "16:00:00", y: 13, price: 54),
      CellData(x: "16:00:00", y: 14, price: 54),
      CellData(x: "16:00:00", y: 15, price: 54),
      CellData(x: "16:00:00", y: 16, price: 54),
      CellData(x: "16:00:00", y: 17, price: 54),
      CellData(x: "16:00:00", y: 18, price: 54),
      CellData(x: "16:00:00", y: 19, price: 54),
      CellData(x: "16:00:00", y: 20, price: 54),
      CellData(x: "16:00:00", y: 21, price: 54),
      CellData(x: "16:00:00", y: 22, price: 54),
      CellData(x: "16:00:00", y: 23, price: 54),
      CellData(x: "16:00:00", y: 24, price: 54),
      CellData(x: "16:00:00", y: 25, price: 54),
      CellData(x: "16:00:00", y: 26, price: 54),
      CellData(x: "16:00:00", y: 27, price: 54),
      CellData(x: "16:00:00", y: 28, price: 54),
      CellData(x: "16:00:00", y: 29, price: 54),
      CellData(x: "16:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "17:00:00", y: 1, price: 54),
      CellData(x: "17:00:00", y: 2, price: 54),
      CellData(x: "17:00:00", y: 3, price: 54),
      CellData(x: "17:00:00", y: 4, price: 54),
      CellData(x: "17:00:00", y: 5, price: 54),
      CellData(x: "17:00:00", y: 6, price: 54),
      CellData(x: "17:00:00", y: 7, price: 54),
      CellData(x: "17:00:00", y: 8, price: 54),
      CellData(x: "17:00:00", y: 9, price: 54),
      CellData(x: "17:00:00", y: 10, price: 54),
      CellData(x: "17:00:00", y: 11, price: 54),
      CellData(x: "17:00:00", y: 12, price: 54),
      CellData(x: "17:00:00", y: 13, price: 54),
      CellData(x: "17:00:00", y: 14, price: 54),
      CellData(x: "17:00:00", y: 15, price: 54),
      CellData(x: "17:00:00", y: 16, price: 54),
      CellData(x: "17:00:00", y: 17, price: 54),
      CellData(x: "17:00:00", y: 18, price: 54),
      CellData(x: "17:00:00", y: 19, price: 54),
      CellData(x: "17:00:00", y: 20, price: 54),
      CellData(x: "17:00:00", y: 21, price: 54),
      CellData(x: "17:00:00", y: 22, price: 54),
      CellData(x: "17:00:00", y: 23, price: 54),
      CellData(x: "17:00:00", y: 24, price: 54),
      CellData(x: "17:00:00", y: 25, price: 54),
      CellData(x: "17:00:00", y: 26, price: 54),
      CellData(x: "17:00:00", y: 27, price: 54),
      CellData(x: "17:00:00", y: 28, price: 54),
      CellData(x: "17:00:00", y: 29, price: 54),
      CellData(x: "17:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "18:00:00", y: 1, price: 54),
      CellData(x: "18:00:00", y: 2, price: 54),
      CellData(x: "18:00:00", y: 3, price: 54),
      CellData(x: "18:00:00", y: 4, price: 54),
      CellData(x: "18:00:00", y: 5, price: 54),
      CellData(x: "18:00:00", y: 6, price: 54),
      CellData(x: "18:00:00", y: 7, price: 54),
      CellData(x: "18:00:00", y: 8, price: 54),
      CellData(x: "18:00:00", y: 9, price: 54),
      CellData(x: "18:00:00", y: 10, price: 54),
      CellData(x: "18:00:00", y: 11, price: 54),
      CellData(x: "18:00:00", y: 12, price: 54),
      CellData(x: "18:00:00", y: 13, price: 54),
      CellData(x: "18:00:00", y: 14, price: 54),
      CellData(x: "18:00:00", y: 15, price: 54),
      CellData(x: "18:00:00", y: 16, price: 54),
      CellData(x: "18:00:00", y: 17, price: 54),
      CellData(x: "18:00:00", y: 18, price: 54),
      CellData(x: "18:00:00", y: 19, price: 54),
      CellData(x: "18:00:00", y: 20, price: 54),
      CellData(x: "18:00:00", y: 21, price: 54),
      CellData(x: "18:00:00", y: 22, price: 54),
      CellData(x: "18:00:00", y: 23, price: 54),
      CellData(x: "18:00:00", y: 24, price: 54),
      CellData(x: "18:00:00", y: 25, price: 54),
      CellData(x: "18:00:00", y: 26, price: 54),
      CellData(x: "18:00:00", y: 27, price: 54),
      CellData(x: "18:00:00", y: 28, price: 54),
      CellData(x: "18:00:00", y: 29, price: 54),
      CellData(x: "18:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "19:00:00", y: 1, price: 54),
      CellData(x: "19:00:00", y: 2, price: 54),
      CellData(x: "19:00:00", y: 3, price: 54),
      CellData(x: "19:00:00", y: 4, price: 54),
      CellData(x: "19:00:00", y: 5, price: 54),
      CellData(x: "19:00:00", y: 6, price: 54),
      CellData(x: "19:00:00", y: 7, price: 54),
      CellData(x: "19:00:00", y: 8, price: 54),
      CellData(x: "19:00:00", y: 9, price: 54),
      CellData(x: "19:00:00", y: 10, price: 54),
      CellData(x: "19:00:00", y: 11, price: 54),
      CellData(x: "19:00:00", y: 12, price: 54),
      CellData(x: "19:00:00", y: 13, price: 54),
      CellData(x: "19:00:00", y: 14, price: 54),
      CellData(x: "19:00:00", y: 15, price: 54),
      CellData(x: "19:00:00", y: 16, price: 54),
      CellData(x: "19:00:00", y: 17, price: 54),
      CellData(x: "19:00:00", y: 18, price: 54),
      CellData(x: "19:00:00", y: 19, price: 54),
      CellData(x: "19:00:00", y: 20, price: 54),
      CellData(x: "19:00:00", y: 21, price: 54),
      CellData(x: "19:00:00", y: 22, price: 54),
      CellData(x: "19:00:00", y: 23, price: 54),
      CellData(x: "19:00:00", y: 24, price: 54),
      CellData(x: "19:00:00", y: 25, price: 54),
      CellData(x: "19:00:00", y: 26, price: 54),
      CellData(x: "19:00:00", y: 27, price: 54),
      CellData(x: "19:00:00", y: 28, price: 54),
      CellData(x: "19:00:00", y: 29, price: 54),
      CellData(x: "19:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "20:00:00", y: 1, price: 54),
      CellData(x: "20:00:00", y: 2, price: 54),
      CellData(x: "20:00:00", y: 3, price: 54),
      CellData(x: "20:00:00", y: 4, price: 54),
      CellData(x: "20:00:00", y: 5, price: 54),
      CellData(x: "20:00:00", y: 6, price: 54),
      CellData(x: "20:00:00", y: 7, price: 54),
      CellData(x: "20:00:00", y: 8, price: 54),
      CellData(x: "20:00:00", y: 9, price: 54),
      CellData(x: "20:00:00", y: 10, price: 54),
      CellData(x: "20:00:00", y: 11, price: 54),
      CellData(x: "20:00:00", y: 12, price: 54),
      CellData(x: "20:00:00", y: 13, price: 54),
      CellData(x: "20:00:00", y: 14, price: 54),
      CellData(x: "20:00:00", y: 15, price: 54),
      CellData(x: "20:00:00", y: 16, price: 54),
      CellData(x: "20:00:00", y: 17, price: 54),
      CellData(x: "20:00:00", y: 18, price: 54),
      CellData(x: "20:00:00", y: 19, price: 54),
      CellData(x: "20:00:00", y: 20, price: 54),
      CellData(x: "20:00:00", y: 21, price: 54),
      CellData(x: "20:00:00", y: 22, price: 54),
      CellData(x: "20:00:00", y: 23, price: 54),
      CellData(x: "20:00:00", y: 24, price: 54),
      CellData(x: "20:00:00", y: 25, price: 54),
      CellData(x: "20:00:00", y: 26, price: 54),
      CellData(x: "20:00:00", y: 27, price: 54),
      CellData(x: "20:00:00", y: 28, price: 54),
      CellData(x: "20:00:00", y: 29, price: 54),
      CellData(x: "20:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "21:00:00", y: 1, price: 54),
      CellData(x: "21:00:00", y: 2, price: 54),
      CellData(x: "21:00:00", y: 3, price: 54),
      CellData(x: "21:00:00", y: 4, price: 54),
      CellData(x: "21:00:00", y: 5, price: 54),
      CellData(x: "21:00:00", y: 6, price: 54),
      CellData(x: "21:00:00", y: 7, price: 54),
      CellData(x: "21:00:00", y: 8, price: 54),
      CellData(x: "21:00:00", y: 9, price: 54),
      CellData(x: "21:00:00", y: 10, price: 54),
      CellData(x: "21:00:00", y: 11, price: 54),
      CellData(x: "21:00:00", y: 12, price: 54),
      CellData(x: "21:00:00", y: 13, price: 54),
      CellData(x: "21:00:00", y: 14, price: 54),
      CellData(x: "21:00:00", y: 15, price: 54),
      CellData(x: "21:00:00", y: 16, price: 54),
      CellData(x: "21:00:00", y: 17, price: 54),
      CellData(x: "21:00:00", y: 18, price: 54),
      CellData(x: "21:00:00", y: 19, price: 54),
      CellData(x: "21:00:00", y: 20, price: 54),
      CellData(x: "21:00:00", y: 21, price: 54),
      CellData(x: "21:00:00", y: 22, price: 54),
      CellData(x: "21:00:00", y: 23, price: 54),
      CellData(x: "21:00:00", y: 24, price: 54),
      CellData(x: "21:00:00", y: 25, price: 54),
      CellData(x: "21:00:00", y: 26, price: 54),
      CellData(x: "21:00:00", y: 27, price: 54),
      CellData(x: "21:00:00", y: 28, price: 54),
      CellData(x: "21:00:00", y: 29, price: 54),
      CellData(x: "21:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "22:00:00", y: 1, price: 54),
      CellData(x: "22:00:00", y: 2, price: 54),
      CellData(x: "22:00:00", y: 3, price: 54),
      CellData(x: "22:00:00", y: 4, price: 54),
      CellData(x: "22:00:00", y: 5, price: 54),
      CellData(x: "22:00:00", y: 6, price: 54),
      CellData(x: "22:00:00", y: 7, price: 54),
      CellData(x: "22:00:00", y: 8, price: 54),
      CellData(x: "22:00:00", y: 9, price: 54),
      CellData(x: "22:00:00", y: 10, price: 54),
      CellData(x: "22:00:00", y: 11, price: 54),
      CellData(x: "22:00:00", y: 12, price: 54),
      CellData(x: "22:00:00", y: 13, price: 54),
      CellData(x: "22:00:00", y: 14, price: 54),
      CellData(x: "22:00:00", y: 15, price: 54),
      CellData(x: "22:00:00", y: 16, price: 54),
      CellData(x: "22:00:00", y: 17, price: 54),
      CellData(x: "22:00:00", y: 18, price: 54),
      CellData(x: "22:00:00", y: 19, price: 54),
      CellData(x: "22:00:00", y: 20, price: 54),
      CellData(x: "22:00:00", y: 21, price: 54),
      CellData(x: "22:00:00", y: 22, price: 54),
      CellData(x: "22:00:00", y: 23, price: 54),
      CellData(x: "22:00:00", y: 24, price: 54),
      CellData(x: "22:00:00", y: 25, price: 54),
      CellData(x: "22:00:00", y: 26, price: 54),
      CellData(x: "22:00:00", y: 27, price: 54),
      CellData(x: "22:00:00", y: 28, price: 54),
      CellData(x: "22:00:00", y: 29, price: 54),
      CellData(x: "22:00:00", y: 30, price: 54),
    ],
    [
      CellData(x: "23:00:00", y: 1, price: 54),
      CellData(x: "23:00:00", y: 2, price: 54),
      CellData(x: "23:00:00", y: 3, price: 54),
      CellData(x: "23:00:00", y: 4, price: 54),
      CellData(x: "23:00:00", y: 5, price: 54),
      CellData(x: "23:00:00", y: 6, price: 54),
      CellData(x: "23:00:00", y: 7, price: 54),
      CellData(x: "23:00:00", y: 8, price: 54),
      CellData(x: "23:00:00", y: 9, price: 54),
      CellData(x: "23:00:00", y: 10, price: 54),
      CellData(x: "23:00:00", y: 11, price: 54),
      CellData(x: "23:00:00", y: 12, price: 54),
      CellData(x: "23:00:00", y: 13, price: 54),
      CellData(x: "23:00:00", y: 14, price: 54),
      CellData(x: "23:00:00", y: 15, price: 54),
      CellData(x: "23:00:00", y: 16, price: 54),
      CellData(x: "23:00:00", y: 17, price: 54),
      CellData(x: "23:00:00", y: 18, price: 54),
      CellData(x: "23:00:00", y: 19, price: 54),
      CellData(x: "23:00:00", y: 20, price: 54),
      CellData(x: "23:00:00", y: 21, price: 54),
      CellData(x: "23:00:00", y: 22, price: 54),
      CellData(x: "23:00:00", y: 23, price: 54),
      CellData(x: "23:00:00", y: 24, price: 54),
      CellData(x: "23:00:00", y: 25, price: 54),
      CellData(x: "23:00:00", y: 26, price: 54),
      CellData(x: "23:00:00", y: 27, price: 54),
      CellData(x: "23:00:00", y: 28, price: 54),
      CellData(x: "23:00:00", y: 29, price: 54),
      CellData(x: "23:00:00", y: 30, price: 54),
    ],
  ];
  List<List<CellData>> rowsCells2 = <List<CellData>>[
    [
      CellData(x: "00:00:00", y: 1, price: 54),
      CellData(x: "00:00:00", y: 2, price: 54),
      CellData(x: "00:00:00", y: 3, price: 54),
      CellData(x: "00:00:00", y: 4, price: 54),
      CellData(x: "00:00:00", y: 5, price: 54),
      CellData(x: "00:00:00", y: 6, price: 54),
      CellData(x: "00:00:00", y: 7, price: 54),
      CellData(x: "00:00:00", y: 8, price: 54),
      CellData(x: "00:00:00", y: 9, price: 54),
      CellData(x: "00:00:00", y: 10, price: 54),
      CellData(x: "00:00:00", y: 11, price: 54),
      CellData(x: "00:00:00", y: 12, price: 54),
      CellData(x: "00:00:00", y: 13, price: 54),
      CellData(x: "00:00:00", y: 14, price: 54),
      CellData(x: "00:00:00", y: 15, price: 54),
      CellData(x: "00:00:00", y: 16, price: 54),
      CellData(x: "00:00:00", y: 17, price: 54),
      CellData(x: "00:00:00", y: 18, price: 54),
      CellData(x: "00:00:00", y: 19, price: 54),
      CellData(x: "00:00:00", y: 20, price: 54),
      CellData(x: "00:00:00", y: 21, price: 54),
      CellData(x: "00:00:00", y: 22, price: 54),
      CellData(x: "00:00:00", y: 23, price: 54),
      CellData(x: "00:00:00", y: 24, price: 54),
      CellData(x: "00:00:00", y: 25, price: 54),
      CellData(x: "00:00:00", y: 26, price: 54),
      CellData(x: "00:00:00", y: 27, price: 54),
      CellData(x: "00:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "01:00:00", y: 1, price: 54),
      CellData(x: "01:00:00", y: 2, price: 54),
      CellData(x: "01:00:00", y: 3, price: 54),
      CellData(x: "01:00:00", y: 4, price: 54),
      CellData(x: "01:00:00", y: 5, price: 54),
      CellData(x: "01:00:00", y: 6, price: 54),
      CellData(x: "01:00:00", y: 7, price: 54),
      CellData(x: "01:00:00", y: 8, price: 54),
      CellData(x: "01:00:00", y: 9, price: 54),
      CellData(x: "01:00:00", y: 10, price: 54),
      CellData(x: "01:00:00", y: 11, price: 54),
      CellData(x: "01:00:00", y: 12, price: 54),
      CellData(x: "01:00:00", y: 13, price: 54),
      CellData(x: "01:00:00", y: 14, price: 54),
      CellData(x: "01:00:00", y: 15, price: 54),
      CellData(x: "01:00:00", y: 16, price: 54),
      CellData(x: "01:00:00", y: 17, price: 54),
      CellData(x: "01:00:00", y: 18, price: 54),
      CellData(x: "01:00:00", y: 19, price: 54),
      CellData(x: "01:00:00", y: 20, price: 54),
      CellData(x: "01:00:00", y: 21, price: 54),
      CellData(x: "01:00:00", y: 22, price: 54),
      CellData(x: "01:00:00", y: 23, price: 54),
      CellData(x: "01:00:00", y: 24, price: 54),
      CellData(x: "01:00:00", y: 25, price: 54),
      CellData(x: "01:00:00", y: 26, price: 54),
      CellData(x: "01:00:00", y: 27, price: 54),
      CellData(x: "01:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "02:00:00", y: 1, price: 54),
      CellData(x: "02:00:00", y: 2, price: 54),
      CellData(x: "02:00:00", y: 3, price: 54),
      CellData(x: "02:00:00", y: 4, price: 54),
      CellData(x: "02:00:00", y: 5, price: 54),
      CellData(x: "02:00:00", y: 6, price: 54),
      CellData(x: "02:00:00", y: 7, price: 54),
      CellData(x: "02:00:00", y: 8, price: 54),
      CellData(x: "02:00:00", y: 9, price: 54),
      CellData(x: "02:00:00", y: 10, price: 54),
      CellData(x: "02:00:00", y: 11, price: 54),
      CellData(x: "02:00:00", y: 12, price: 54),
      CellData(x: "02:00:00", y: 13, price: 54),
      CellData(x: "02:00:00", y: 14, price: 54),
      CellData(x: "02:00:00", y: 15, price: 54),
      CellData(x: "02:00:00", y: 16, price: 54),
      CellData(x: "02:00:00", y: 17, price: 54),
      CellData(x: "02:00:00", y: 18, price: 54),
      CellData(x: "02:00:00", y: 19, price: 54),
      CellData(x: "02:00:00", y: 20, price: 54),
      CellData(x: "02:00:00", y: 21, price: 54),
      CellData(x: "02:00:00", y: 22, price: 54),
      CellData(x: "02:00:00", y: 23, price: 54),
      CellData(x: "02:00:00", y: 24, price: 54),
      CellData(x: "02:00:00", y: 25, price: 54),
      CellData(x: "02:00:00", y: 26, price: 54),
      CellData(x: "02:00:00", y: 27, price: 54),
      CellData(x: "02:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "03:00:00", y: 1, price: 54),
      CellData(x: "03:00:00", y: 2, price: 54),
      CellData(x: "03:00:00", y: 3, price: 54),
      CellData(x: "03:00:00", y: 4, price: 54),
      CellData(x: "03:00:00", y: 5, price: 54),
      CellData(x: "03:00:00", y: 6, price: 54),
      CellData(x: "03:00:00", y: 7, price: 54),
      CellData(x: "03:00:00", y: 8, price: 54),
      CellData(x: "03:00:00", y: 9, price: 54),
      CellData(x: "03:00:00", y: 10, price: 54),
      CellData(x: "03:00:00", y: 11, price: 54),
      CellData(x: "03:00:00", y: 12, price: 54),
      CellData(x: "03:00:00", y: 13, price: 54),
      CellData(x: "03:00:00", y: 14, price: 54),
      CellData(x: "03:00:00", y: 15, price: 54),
      CellData(x: "03:00:00", y: 16, price: 54),
      CellData(x: "03:00:00", y: 17, price: 54),
      CellData(x: "03:00:00", y: 18, price: 54),
      CellData(x: "03:00:00", y: 19, price: 54),
      CellData(x: "03:00:00", y: 20, price: 54),
      CellData(x: "03:00:00", y: 21, price: 54),
      CellData(x: "03:00:00", y: 22, price: 54),
      CellData(x: "03:00:00", y: 23, price: 54),
      CellData(x: "03:00:00", y: 24, price: 54),
      CellData(x: "03:00:00", y: 25, price: 54),
      CellData(x: "03:00:00", y: 26, price: 54),
      CellData(x: "03:00:00", y: 27, price: 54),
      CellData(x: "03:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "04:00:00", y: 1, price: 54),
      CellData(x: "04:00:00", y: 2, price: 54),
      CellData(x: "04:00:00", y: 3, price: 54),
      CellData(x: "04:00:00", y: 4, price: 54),
      CellData(x: "04:00:00", y: 5, price: 54),
      CellData(x: "04:00:00", y: 6, price: 54),
      CellData(x: "04:00:00", y: 7, price: 54),
      CellData(x: "04:00:00", y: 8, price: 54),
      CellData(x: "04:00:00", y: 9, price: 54),
      CellData(x: "04:00:00", y: 10, price: 54),
      CellData(x: "04:00:00", y: 11, price: 54),
      CellData(x: "04:00:00", y: 12, price: 54),
      CellData(x: "04:00:00", y: 13, price: 54),
      CellData(x: "04:00:00", y: 14, price: 54),
      CellData(x: "04:00:00", y: 15, price: 54),
      CellData(x: "04:00:00", y: 16, price: 54),
      CellData(x: "04:00:00", y: 17, price: 54),
      CellData(x: "04:00:00", y: 18, price: 54),
      CellData(x: "04:00:00", y: 19, price: 54),
      CellData(x: "04:00:00", y: 20, price: 54),
      CellData(x: "04:00:00", y: 21, price: 54),
      CellData(x: "04:00:00", y: 22, price: 54),
      CellData(x: "04:00:00", y: 23, price: 54),
      CellData(x: "04:00:00", y: 24, price: 54),
      CellData(x: "04:00:00", y: 25, price: 54),
      CellData(x: "04:00:00", y: 26, price: 54),
      CellData(x: "04:00:00", y: 27, price: 54),
      CellData(x: "04:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "05:00:00", y: 1, price: 54),
      CellData(x: "05:00:00", y: 2, price: 54),
      CellData(x: "05:00:00", y: 3, price: 54),
      CellData(x: "05:00:00", y: 4, price: 54),
      CellData(x: "05:00:00", y: 5, price: 54),
      CellData(x: "05:00:00", y: 6, price: 54),
      CellData(x: "05:00:00", y: 7, price: 54),
      CellData(x: "05:00:00", y: 8, price: 54),
      CellData(x: "05:00:00", y: 9, price: 54),
      CellData(x: "05:00:00", y: 10, price: 54),
      CellData(x: "05:00:00", y: 11, price: 54),
      CellData(x: "05:00:00", y: 12, price: 54),
      CellData(x: "05:00:00", y: 13, price: 54),
      CellData(x: "05:00:00", y: 14, price: 54),
      CellData(x: "05:00:00", y: 15, price: 54),
      CellData(x: "05:00:00", y: 16, price: 54),
      CellData(x: "05:00:00", y: 17, price: 54),
      CellData(x: "05:00:00", y: 18, price: 54),
      CellData(x: "05:00:00", y: 19, price: 54),
      CellData(x: "05:00:00", y: 20, price: 54),
      CellData(x: "05:00:00", y: 21, price: 54),
      CellData(x: "05:00:00", y: 22, price: 54),
      CellData(x: "05:00:00", y: 23, price: 54),
      CellData(x: "05:00:00", y: 24, price: 54),
      CellData(x: "05:00:00", y: 25, price: 54),
      CellData(x: "05:00:00", y: 26, price: 54),
      CellData(x: "05:00:00", y: 27, price: 54),
      CellData(x: "05:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "06:00:00", y: 1, price: 54),
      CellData(x: "06:00:00", y: 2, price: 54),
      CellData(x: "06:00:00", y: 3, price: 54),
      CellData(x: "06:00:00", y: 4, price: 54),
      CellData(x: "06:00:00", y: 5, price: 54),
      CellData(x: "06:00:00", y: 6, price: 54),
      CellData(x: "06:00:00", y: 7, price: 54),
      CellData(x: "06:00:00", y: 8, price: 54),
      CellData(x: "06:00:00", y: 9, price: 54),
      CellData(x: "06:00:00", y: 10, price: 54),
      CellData(x: "06:00:00", y: 11, price: 54),
      CellData(x: "06:00:00", y: 12, price: 54),
      CellData(x: "06:00:00", y: 13, price: 54),
      CellData(x: "06:00:00", y: 14, price: 54),
      CellData(x: "06:00:00", y: 15, price: 54),
      CellData(x: "06:00:00", y: 16, price: 54),
      CellData(x: "06:00:00", y: 17, price: 54),
      CellData(x: "06:00:00", y: 18, price: 54),
      CellData(x: "06:00:00", y: 19, price: 54),
      CellData(x: "06:00:00", y: 20, price: 54),
      CellData(x: "06:00:00", y: 21, price: 54),
      CellData(x: "06:00:00", y: 22, price: 54),
      CellData(x: "06:00:00", y: 23, price: 54),
      CellData(x: "06:00:00", y: 24, price: 54),
      CellData(x: "06:00:00", y: 25, price: 54),
      CellData(x: "06:00:00", y: 26, price: 54),
      CellData(x: "06:00:00", y: 27, price: 54),
      CellData(x: "06:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "07:00:00", y: 1, price: 54),
      CellData(x: "07:00:00", y: 2, price: 54),
      CellData(x: "07:00:00", y: 3, price: 54),
      CellData(x: "07:00:00", y: 4, price: 54),
      CellData(x: "07:00:00", y: 5, price: 54),
      CellData(x: "07:00:00", y: 6, price: 54),
      CellData(x: "07:00:00", y: 7, price: 54),
      CellData(x: "07:00:00", y: 8, price: 54),
      CellData(x: "07:00:00", y: 9, price: 54),
      CellData(x: "07:00:00", y: 10, price: 54),
      CellData(x: "07:00:00", y: 11, price: 54),
      CellData(x: "07:00:00", y: 12, price: 54),
      CellData(x: "07:00:00", y: 13, price: 54),
      CellData(x: "07:00:00", y: 14, price: 54),
      CellData(x: "07:00:00", y: 15, price: 54),
      CellData(x: "07:00:00", y: 16, price: 54),
      CellData(x: "07:00:00", y: 17, price: 54),
      CellData(x: "07:00:00", y: 18, price: 54),
      CellData(x: "07:00:00", y: 19, price: 54),
      CellData(x: "07:00:00", y: 20, price: 54),
      CellData(x: "07:00:00", y: 21, price: 54),
      CellData(x: "07:00:00", y: 22, price: 54),
      CellData(x: "07:00:00", y: 23, price: 54),
      CellData(x: "07:00:00", y: 24, price: 54),
      CellData(x: "07:00:00", y: 25, price: 54),
      CellData(x: "07:00:00", y: 26, price: 54),
      CellData(x: "07:00:00", y: 27, price: 54),
      CellData(x: "07:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "08:00:00", y: 1, price: 54),
      CellData(x: "08:00:00", y: 2, price: 54),
      CellData(x: "08:00:00", y: 3, price: 54),
      CellData(x: "08:00:00", y: 4, price: 54),
      CellData(x: "08:00:00", y: 5, price: 54),
      CellData(x: "08:00:00", y: 6, price: 54),
      CellData(x: "08:00:00", y: 7, price: 54),
      CellData(x: "08:00:00", y: 8, price: 54),
      CellData(x: "08:00:00", y: 9, price: 54),
      CellData(x: "08:00:00", y: 10, price: 54),
      CellData(x: "08:00:00", y: 11, price: 54),
      CellData(x: "08:00:00", y: 12, price: 54),
      CellData(x: "08:00:00", y: 13, price: 54),
      CellData(x: "08:00:00", y: 14, price: 54),
      CellData(x: "08:00:00", y: 15, price: 54),
      CellData(x: "08:00:00", y: 16, price: 54),
      CellData(x: "08:00:00", y: 17, price: 54),
      CellData(x: "08:00:00", y: 18, price: 54),
      CellData(x: "08:00:00", y: 19, price: 54),
      CellData(x: "08:00:00", y: 20, price: 54),
      CellData(x: "08:00:00", y: 21, price: 54),
      CellData(x: "08:00:00", y: 22, price: 54),
      CellData(x: "08:00:00", y: 23, price: 54),
      CellData(x: "08:00:00", y: 24, price: 54),
      CellData(x: "08:00:00", y: 25, price: 54),
      CellData(x: "08:00:00", y: 26, price: 54),
      CellData(x: "08:00:00", y: 27, price: 54),
      CellData(x: "08:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "09:00:00", y: 1, price: 54),
      CellData(x: "09:00:00", y: 2, price: 54),
      CellData(x: "09:00:00", y: 3, price: 54),
      CellData(x: "09:00:00", y: 4, price: 54),
      CellData(x: "09:00:00", y: 5, price: 54),
      CellData(x: "09:00:00", y: 6, price: 54),
      CellData(x: "09:00:00", y: 7, price: 54),
      CellData(x: "09:00:00", y: 8, price: 54),
      CellData(x: "09:00:00", y: 9, price: 54),
      CellData(x: "09:00:00", y: 10, price: 54),
      CellData(x: "09:00:00", y: 11, price: 54),
      CellData(x: "09:00:00", y: 12, price: 54),
      CellData(x: "09:00:00", y: 13, price: 54),
      CellData(x: "09:00:00", y: 14, price: 54),
      CellData(x: "09:00:00", y: 15, price: 54),
      CellData(x: "09:00:00", y: 16, price: 54),
      CellData(x: "09:00:00", y: 17, price: 54),
      CellData(x: "09:00:00", y: 18, price: 54),
      CellData(x: "09:00:00", y: 19, price: 54),
      CellData(x: "09:00:00", y: 20, price: 54),
      CellData(x: "09:00:00", y: 21, price: 54),
      CellData(x: "09:00:00", y: 22, price: 54),
      CellData(x: "09:00:00", y: 23, price: 54),
      CellData(x: "09:00:00", y: 24, price: 54),
      CellData(x: "09:00:00", y: 25, price: 54),
      CellData(x: "09:00:00", y: 26, price: 54),
      CellData(x: "09:00:00", y: 27, price: 54),
      CellData(x: "09:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "10:00:00", y: 1, price: 54),
      CellData(x: "10:00:00", y: 2, price: 54),
      CellData(x: "10:00:00", y: 3, price: 54),
      CellData(x: "10:00:00", y: 4, price: 54),
      CellData(x: "10:00:00", y: 5, price: 54),
      CellData(x: "10:00:00", y: 6, price: 54),
      CellData(x: "10:00:00", y: 7, price: 54),
      CellData(x: "10:00:00", y: 8, price: 54),
      CellData(x: "10:00:00", y: 9, price: 54),
      CellData(x: "10:00:00", y: 10, price: 54),
      CellData(x: "10:00:00", y: 11, price: 54),
      CellData(x: "10:00:00", y: 12, price: 54),
      CellData(x: "10:00:00", y: 13, price: 54),
      CellData(x: "10:00:00", y: 14, price: 54),
      CellData(x: "10:00:00", y: 15, price: 54),
      CellData(x: "10:00:00", y: 16, price: 54),
      CellData(x: "10:00:00", y: 17, price: 54),
      CellData(x: "10:00:00", y: 18, price: 54),
      CellData(x: "10:00:00", y: 19, price: 54),
      CellData(x: "10:00:00", y: 20, price: 54),
      CellData(x: "10:00:00", y: 21, price: 54),
      CellData(x: "10:00:00", y: 22, price: 54),
      CellData(x: "10:00:00", y: 23, price: 54),
      CellData(x: "10:00:00", y: 24, price: 54),
      CellData(x: "10:00:00", y: 25, price: 54),
      CellData(x: "10:00:00", y: 26, price: 54),
      CellData(x: "10:00:00", y: 27, price: 54),
      CellData(x: "10:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "11:00:00", y: 1, price: 54),
      CellData(x: "11:00:00", y: 2, price: 54),
      CellData(x: "11:00:00", y: 3, price: 54),
      CellData(x: "11:00:00", y: 4, price: 54),
      CellData(x: "11:00:00", y: 5, price: 54),
      CellData(x: "11:00:00", y: 6, price: 54),
      CellData(x: "11:00:00", y: 7, price: 54),
      CellData(x: "11:00:00", y: 8, price: 54),
      CellData(x: "11:00:00", y: 9, price: 54),
      CellData(x: "11:00:00", y: 10, price: 54),
      CellData(x: "11:00:00", y: 11, price: 54),
      CellData(x: "11:00:00", y: 12, price: 54),
      CellData(x: "11:00:00", y: 13, price: 54),
      CellData(x: "11:00:00", y: 14, price: 54),
      CellData(x: "11:00:00", y: 15, price: 54),
      CellData(x: "11:00:00", y: 16, price: 54),
      CellData(x: "11:00:00", y: 17, price: 54),
      CellData(x: "11:00:00", y: 18, price: 54),
      CellData(x: "11:00:00", y: 19, price: 54),
      CellData(x: "11:00:00", y: 20, price: 54),
      CellData(x: "11:00:00", y: 21, price: 54),
      CellData(x: "11:00:00", y: 22, price: 54),
      CellData(x: "11:00:00", y: 23, price: 54),
      CellData(x: "11:00:00", y: 24, price: 54),
      CellData(x: "11:00:00", y: 25, price: 54),
      CellData(x: "11:00:00", y: 26, price: 54),
      CellData(x: "11:00:00", y: 27, price: 54),
      CellData(x: "11:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "12:00:00", y: 1, price: 54),
      CellData(x: "12:00:00", y: 2, price: 54),
      CellData(x: "12:00:00", y: 3, price: 54),
      CellData(x: "12:00:00", y: 4, price: 54),
      CellData(x: "12:00:00", y: 5, price: 54),
      CellData(x: "12:00:00", y: 6, price: 54),
      CellData(x: "12:00:00", y: 7, price: 54),
      CellData(x: "12:00:00", y: 8, price: 54),
      CellData(x: "12:00:00", y: 9, price: 54),
      CellData(x: "12:00:00", y: 10, price: 54),
      CellData(x: "12:00:00", y: 11, price: 54),
      CellData(x: "12:00:00", y: 12, price: 54),
      CellData(x: "12:00:00", y: 13, price: 54),
      CellData(x: "12:00:00", y: 14, price: 54),
      CellData(x: "12:00:00", y: 15, price: 54),
      CellData(x: "12:00:00", y: 16, price: 54),
      CellData(x: "12:00:00", y: 17, price: 54),
      CellData(x: "12:00:00", y: 18, price: 54),
      CellData(x: "12:00:00", y: 19, price: 54),
      CellData(x: "12:00:00", y: 20, price: 54),
      CellData(x: "12:00:00", y: 21, price: 54),
      CellData(x: "12:00:00", y: 22, price: 54),
      CellData(x: "12:00:00", y: 23, price: 54),
      CellData(x: "12:00:00", y: 24, price: 54),
      CellData(x: "12:00:00", y: 25, price: 54),
      CellData(x: "12:00:00", y: 26, price: 54),
      CellData(x: "12:00:00", y: 27, price: 54),
      CellData(x: "12:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "13:00:00", y: 1, price: 54),
      CellData(x: "13:00:00", y: 2, price: 54),
      CellData(x: "13:00:00", y: 3, price: 54),
      CellData(x: "13:00:00", y: 4, price: 54),
      CellData(x: "13:00:00", y: 5, price: 54),
      CellData(x: "13:00:00", y: 6, price: 54),
      CellData(x: "13:00:00", y: 7, price: 54),
      CellData(x: "13:00:00", y: 8, price: 54),
      CellData(x: "13:00:00", y: 9, price: 54),
      CellData(x: "13:00:00", y: 10, price: 54),
      CellData(x: "13:00:00", y: 11, price: 54),
      CellData(x: "13:00:00", y: 12, price: 54),
      CellData(x: "13:00:00", y: 13, price: 54),
      CellData(x: "13:00:00", y: 14, price: 54),
      CellData(x: "13:00:00", y: 15, price: 54),
      CellData(x: "13:00:00", y: 16, price: 54),
      CellData(x: "13:00:00", y: 17, price: 54),
      CellData(x: "13:00:00", y: 18, price: 54),
      CellData(x: "13:00:00", y: 19, price: 54),
      CellData(x: "13:00:00", y: 20, price: 54),
      CellData(x: "13:00:00", y: 21, price: 54),
      CellData(x: "13:00:00", y: 22, price: 54),
      CellData(x: "13:00:00", y: 23, price: 54),
      CellData(x: "13:00:00", y: 24, price: 54),
      CellData(x: "13:00:00", y: 25, price: 54),
      CellData(x: "13:00:00", y: 26, price: 54),
      CellData(x: "13:00:00", y: 27, price: 54),
      CellData(x: "13:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "14:00:00", y: 1, price: 54),
      CellData(x: "14:00:00", y: 2, price: 54),
      CellData(x: "14:00:00", y: 3, price: 54),
      CellData(x: "14:00:00", y: 4, price: 54),
      CellData(x: "14:00:00", y: 5, price: 54),
      CellData(x: "14:00:00", y: 6, price: 54),
      CellData(x: "14:00:00", y: 7, price: 54),
      CellData(x: "14:00:00", y: 8, price: 54),
      CellData(x: "14:00:00", y: 9, price: 54),
      CellData(x: "14:00:00", y: 10, price: 54),
      CellData(x: "14:00:00", y: 11, price: 54),
      CellData(x: "14:00:00", y: 12, price: 54),
      CellData(x: "14:00:00", y: 13, price: 54),
      CellData(x: "14:00:00", y: 14, price: 54),
      CellData(x: "14:00:00", y: 15, price: 54),
      CellData(x: "14:00:00", y: 16, price: 54),
      CellData(x: "14:00:00", y: 17, price: 54),
      CellData(x: "14:00:00", y: 18, price: 54),
      CellData(x: "14:00:00", y: 19, price: 54),
      CellData(x: "14:00:00", y: 20, price: 54),
      CellData(x: "14:00:00", y: 21, price: 54),
      CellData(x: "14:00:00", y: 22, price: 54),
      CellData(x: "14:00:00", y: 23, price: 54),
      CellData(x: "14:00:00", y: 24, price: 54),
      CellData(x: "14:00:00", y: 25, price: 54),
      CellData(x: "14:00:00", y: 26, price: 54),
      CellData(x: "14:00:00", y: 27, price: 54),
      CellData(x: "14:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "15:00:00", y: 1, price: 54),
      CellData(x: "15:00:00", y: 2, price: 54),
      CellData(x: "15:00:00", y: 3, price: 54),
      CellData(x: "15:00:00", y: 4, price: 54),
      CellData(x: "15:00:00", y: 5, price: 54),
      CellData(x: "15:00:00", y: 6, price: 54),
      CellData(x: "15:00:00", y: 7, price: 54),
      CellData(x: "15:00:00", y: 8, price: 54),
      CellData(x: "15:00:00", y: 9, price: 54),
      CellData(x: "15:00:00", y: 10, price: 54),
      CellData(x: "15:00:00", y: 11, price: 54),
      CellData(x: "15:00:00", y: 12, price: 54),
      CellData(x: "15:00:00", y: 13, price: 54),
      CellData(x: "15:00:00", y: 14, price: 54),
      CellData(x: "15:00:00", y: 15, price: 54),
      CellData(x: "15:00:00", y: 16, price: 54),
      CellData(x: "15:00:00", y: 17, price: 54),
      CellData(x: "15:00:00", y: 18, price: 54),
      CellData(x: "15:00:00", y: 19, price: 54),
      CellData(x: "15:00:00", y: 20, price: 54),
      CellData(x: "15:00:00", y: 21, price: 54),
      CellData(x: "15:00:00", y: 22, price: 54),
      CellData(x: "15:00:00", y: 23, price: 54),
      CellData(x: "15:00:00", y: 24, price: 54),
      CellData(x: "15:00:00", y: 25, price: 54),
      CellData(x: "15:00:00", y: 26, price: 54),
      CellData(x: "15:00:00", y: 27, price: 54),
      CellData(x: "15:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "16:00:00", y: 1, price: 54),
      CellData(x: "16:00:00", y: 2, price: 54),
      CellData(x: "16:00:00", y: 3, price: 54),
      CellData(x: "16:00:00", y: 4, price: 54),
      CellData(x: "16:00:00", y: 5, price: 54),
      CellData(x: "16:00:00", y: 6, price: 54),
      CellData(x: "16:00:00", y: 7, price: 54),
      CellData(x: "16:00:00", y: 8, price: 54),
      CellData(x: "16:00:00", y: 9, price: 54),
      CellData(x: "16:00:00", y: 10, price: 54),
      CellData(x: "16:00:00", y: 11, price: 54),
      CellData(x: "16:00:00", y: 12, price: 54),
      CellData(x: "16:00:00", y: 13, price: 54),
      CellData(x: "16:00:00", y: 14, price: 54),
      CellData(x: "16:00:00", y: 15, price: 54),
      CellData(x: "16:00:00", y: 16, price: 54),
      CellData(x: "16:00:00", y: 17, price: 54),
      CellData(x: "16:00:00", y: 18, price: 54),
      CellData(x: "16:00:00", y: 19, price: 54),
      CellData(x: "16:00:00", y: 20, price: 54),
      CellData(x: "16:00:00", y: 21, price: 54),
      CellData(x: "16:00:00", y: 22, price: 54),
      CellData(x: "16:00:00", y: 23, price: 54),
      CellData(x: "16:00:00", y: 24, price: 54),
      CellData(x: "16:00:00", y: 25, price: 54),
      CellData(x: "16:00:00", y: 26, price: 54),
      CellData(x: "16:00:00", y: 27, price: 54),
      CellData(x: "16:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "17:00:00", y: 1, price: 54),
      CellData(x: "17:00:00", y: 2, price: 54),
      CellData(x: "17:00:00", y: 3, price: 54),
      CellData(x: "17:00:00", y: 4, price: 54),
      CellData(x: "17:00:00", y: 5, price: 54),
      CellData(x: "17:00:00", y: 6, price: 54),
      CellData(x: "17:00:00", y: 7, price: 54),
      CellData(x: "17:00:00", y: 8, price: 54),
      CellData(x: "17:00:00", y: 9, price: 54),
      CellData(x: "17:00:00", y: 10, price: 54),
      CellData(x: "17:00:00", y: 11, price: 54),
      CellData(x: "17:00:00", y: 12, price: 54),
      CellData(x: "17:00:00", y: 13, price: 54),
      CellData(x: "17:00:00", y: 14, price: 54),
      CellData(x: "17:00:00", y: 15, price: 54),
      CellData(x: "17:00:00", y: 16, price: 54),
      CellData(x: "17:00:00", y: 17, price: 54),
      CellData(x: "17:00:00", y: 18, price: 54),
      CellData(x: "17:00:00", y: 19, price: 54),
      CellData(x: "17:00:00", y: 20, price: 54),
      CellData(x: "17:00:00", y: 21, price: 54),
      CellData(x: "17:00:00", y: 22, price: 54),
      CellData(x: "17:00:00", y: 23, price: 54),
      CellData(x: "17:00:00", y: 24, price: 54),
      CellData(x: "17:00:00", y: 25, price: 54),
      CellData(x: "17:00:00", y: 26, price: 54),
      CellData(x: "17:00:00", y: 27, price: 54),
      CellData(x: "17:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "18:00:00", y: 1, price: 54),
      CellData(x: "18:00:00", y: 2, price: 54),
      CellData(x: "18:00:00", y: 3, price: 54),
      CellData(x: "18:00:00", y: 4, price: 54),
      CellData(x: "18:00:00", y: 5, price: 54),
      CellData(x: "18:00:00", y: 6, price: 54),
      CellData(x: "18:00:00", y: 7, price: 54),
      CellData(x: "18:00:00", y: 8, price: 54),
      CellData(x: "18:00:00", y: 9, price: 54),
      CellData(x: "18:00:00", y: 10, price: 54),
      CellData(x: "18:00:00", y: 11, price: 54),
      CellData(x: "18:00:00", y: 12, price: 54),
      CellData(x: "18:00:00", y: 13, price: 54),
      CellData(x: "18:00:00", y: 14, price: 54),
      CellData(x: "18:00:00", y: 15, price: 54),
      CellData(x: "18:00:00", y: 16, price: 54),
      CellData(x: "18:00:00", y: 17, price: 54),
      CellData(x: "18:00:00", y: 18, price: 54),
      CellData(x: "18:00:00", y: 19, price: 54),
      CellData(x: "18:00:00", y: 20, price: 54),
      CellData(x: "18:00:00", y: 21, price: 54),
      CellData(x: "18:00:00", y: 22, price: 54),
      CellData(x: "18:00:00", y: 23, price: 54),
      CellData(x: "18:00:00", y: 24, price: 54),
      CellData(x: "18:00:00", y: 25, price: 54),
      CellData(x: "18:00:00", y: 26, price: 54),
      CellData(x: "18:00:00", y: 27, price: 54),
      CellData(x: "18:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "19:00:00", y: 1, price: 54),
      CellData(x: "19:00:00", y: 2, price: 54),
      CellData(x: "19:00:00", y: 3, price: 54),
      CellData(x: "19:00:00", y: 4, price: 54),
      CellData(x: "19:00:00", y: 5, price: 54),
      CellData(x: "19:00:00", y: 6, price: 54),
      CellData(x: "19:00:00", y: 7, price: 54),
      CellData(x: "19:00:00", y: 8, price: 54),
      CellData(x: "19:00:00", y: 9, price: 54),
      CellData(x: "19:00:00", y: 10, price: 54),
      CellData(x: "19:00:00", y: 11, price: 54),
      CellData(x: "19:00:00", y: 12, price: 54),
      CellData(x: "19:00:00", y: 13, price: 54),
      CellData(x: "19:00:00", y: 14, price: 54),
      CellData(x: "19:00:00", y: 15, price: 54),
      CellData(x: "19:00:00", y: 16, price: 54),
      CellData(x: "19:00:00", y: 17, price: 54),
      CellData(x: "19:00:00", y: 18, price: 54),
      CellData(x: "19:00:00", y: 19, price: 54),
      CellData(x: "19:00:00", y: 20, price: 54),
      CellData(x: "19:00:00", y: 21, price: 54),
      CellData(x: "19:00:00", y: 22, price: 54),
      CellData(x: "19:00:00", y: 23, price: 54),
      CellData(x: "19:00:00", y: 24, price: 54),
      CellData(x: "19:00:00", y: 25, price: 54),
      CellData(x: "19:00:00", y: 26, price: 54),
      CellData(x: "19:00:00", y: 27, price: 54),
      CellData(x: "19:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "20:00:00", y: 1, price: 54),
      CellData(x: "20:00:00", y: 2, price: 54),
      CellData(x: "20:00:00", y: 3, price: 54),
      CellData(x: "20:00:00", y: 4, price: 54),
      CellData(x: "20:00:00", y: 5, price: 54),
      CellData(x: "20:00:00", y: 6, price: 54),
      CellData(x: "20:00:00", y: 7, price: 54),
      CellData(x: "20:00:00", y: 8, price: 54),
      CellData(x: "20:00:00", y: 9, price: 54),
      CellData(x: "20:00:00", y: 10, price: 54),
      CellData(x: "20:00:00", y: 11, price: 54),
      CellData(x: "20:00:00", y: 12, price: 54),
      CellData(x: "20:00:00", y: 13, price: 54),
      CellData(x: "20:00:00", y: 14, price: 54),
      CellData(x: "20:00:00", y: 15, price: 54),
      CellData(x: "20:00:00", y: 16, price: 54),
      CellData(x: "20:00:00", y: 17, price: 54),
      CellData(x: "20:00:00", y: 18, price: 54),
      CellData(x: "20:00:00", y: 19, price: 54),
      CellData(x: "20:00:00", y: 20, price: 54),
      CellData(x: "20:00:00", y: 21, price: 54),
      CellData(x: "20:00:00", y: 22, price: 54),
      CellData(x: "20:00:00", y: 23, price: 54),
      CellData(x: "20:00:00", y: 24, price: 54),
      CellData(x: "20:00:00", y: 25, price: 54),
      CellData(x: "20:00:00", y: 26, price: 54),
      CellData(x: "20:00:00", y: 27, price: 54),
      CellData(x: "20:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "21:00:00", y: 1, price: 54),
      CellData(x: "21:00:00", y: 2, price: 54),
      CellData(x: "21:00:00", y: 3, price: 54),
      CellData(x: "21:00:00", y: 4, price: 54),
      CellData(x: "21:00:00", y: 5, price: 54),
      CellData(x: "21:00:00", y: 6, price: 54),
      CellData(x: "21:00:00", y: 7, price: 54),
      CellData(x: "21:00:00", y: 8, price: 54),
      CellData(x: "21:00:00", y: 9, price: 54),
      CellData(x: "21:00:00", y: 10, price: 54),
      CellData(x: "21:00:00", y: 11, price: 54),
      CellData(x: "21:00:00", y: 12, price: 54),
      CellData(x: "21:00:00", y: 13, price: 54),
      CellData(x: "21:00:00", y: 14, price: 54),
      CellData(x: "21:00:00", y: 15, price: 54),
      CellData(x: "21:00:00", y: 16, price: 54),
      CellData(x: "21:00:00", y: 17, price: 54),
      CellData(x: "21:00:00", y: 18, price: 54),
      CellData(x: "21:00:00", y: 19, price: 54),
      CellData(x: "21:00:00", y: 20, price: 54),
      CellData(x: "21:00:00", y: 21, price: 54),
      CellData(x: "21:00:00", y: 22, price: 54),
      CellData(x: "21:00:00", y: 23, price: 54),
      CellData(x: "21:00:00", y: 24, price: 54),
      CellData(x: "21:00:00", y: 25, price: 54),
      CellData(x: "21:00:00", y: 26, price: 54),
      CellData(x: "21:00:00", y: 27, price: 54),
      CellData(x: "21:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "22:00:00", y: 1, price: 54),
      CellData(x: "22:00:00", y: 2, price: 54),
      CellData(x: "22:00:00", y: 3, price: 54),
      CellData(x: "22:00:00", y: 4, price: 54),
      CellData(x: "22:00:00", y: 5, price: 54),
      CellData(x: "22:00:00", y: 6, price: 54),
      CellData(x: "22:00:00", y: 7, price: 54),
      CellData(x: "22:00:00", y: 8, price: 54),
      CellData(x: "22:00:00", y: 9, price: 54),
      CellData(x: "22:00:00", y: 10, price: 54),
      CellData(x: "22:00:00", y: 11, price: 54),
      CellData(x: "22:00:00", y: 12, price: 54),
      CellData(x: "22:00:00", y: 13, price: 54),
      CellData(x: "22:00:00", y: 14, price: 54),
      CellData(x: "22:00:00", y: 15, price: 54),
      CellData(x: "22:00:00", y: 16, price: 54),
      CellData(x: "22:00:00", y: 17, price: 54),
      CellData(x: "22:00:00", y: 18, price: 54),
      CellData(x: "22:00:00", y: 19, price: 54),
      CellData(x: "22:00:00", y: 20, price: 54),
      CellData(x: "22:00:00", y: 21, price: 54),
      CellData(x: "22:00:00", y: 22, price: 54),
      CellData(x: "22:00:00", y: 23, price: 54),
      CellData(x: "22:00:00", y: 24, price: 54),
      CellData(x: "22:00:00", y: 25, price: 54),
      CellData(x: "22:00:00", y: 26, price: 54),
      CellData(x: "22:00:00", y: 27, price: 54),
      CellData(x: "22:00:00", y: 28, price: 54),
    ],
    [
      CellData(x: "23:00:00", y: 1, price: 54),
      CellData(x: "23:00:00", y: 2, price: 54),
      CellData(x: "23:00:00", y: 3, price: 54),
      CellData(x: "23:00:00", y: 4, price: 54),
      CellData(x: "23:00:00", y: 5, price: 54),
      CellData(x: "23:00:00", y: 6, price: 54),
      CellData(x: "23:00:00", y: 7, price: 54),
      CellData(x: "23:00:00", y: 8, price: 54),
      CellData(x: "23:00:00", y: 9, price: 54),
      CellData(x: "23:00:00", y: 10, price: 54),
      CellData(x: "23:00:00", y: 11, price: 54),
      CellData(x: "23:00:00", y: 12, price: 54),
      CellData(x: "23:00:00", y: 13, price: 54),
      CellData(x: "23:00:00", y: 14, price: 54),
      CellData(x: "23:00:00", y: 15, price: 54),
      CellData(x: "23:00:00", y: 16, price: 54),
      CellData(x: "23:00:00", y: 17, price: 54),
      CellData(x: "23:00:00", y: 18, price: 54),
      CellData(x: "23:00:00", y: 19, price: 54),
      CellData(x: "23:00:00", y: 20, price: 54),
      CellData(x: "23:00:00", y: 21, price: 54),
      CellData(x: "23:00:00", y: 22, price: 54),
      CellData(x: "23:00:00", y: 23, price: 54),
      CellData(x: "23:00:00", y: 24, price: 54),
      CellData(x: "23:00:00", y: 25, price: 54),
      CellData(x: "23:00:00", y: 26, price: 54),
      CellData(x: "23:00:00", y: 27, price: 54),
      CellData(x: "23:00:00", y: 28, price: 54),
    ],
  ];
  List<List<CellData>> rowsCells3 = <List<CellData>>[
    [
      CellData(x: "00:00:00", y: 1, price: 54),
      CellData(x: "00:00:00", y: 2, price: 54),
      CellData(x: "00:00:00", y: 3, price: 54),
      CellData(x: "00:00:00", y: 4, price: 54),
      CellData(x: "00:00:00", y: 5, price: 54),
      CellData(x: "00:00:00", y: 6, price: 54),
      CellData(x: "00:00:00", y: 7, price: 54),
      CellData(x: "00:00:00", y: 8, price: 54),
      CellData(x: "00:00:00", y: 9, price: 54),
      CellData(x: "00:00:00", y: 10, price: 54),
      CellData(x: "00:00:00", y: 11, price: 54),
      CellData(x: "00:00:00", y: 12, price: 54),
      CellData(x: "00:00:00", y: 13, price: 54),
      CellData(x: "00:00:00", y: 14, price: 54),
      CellData(x: "00:00:00", y: 15, price: 54),
      CellData(x: "00:00:00", y: 16, price: 54),
      CellData(x: "00:00:00", y: 17, price: 54),
      CellData(x: "00:00:00", y: 18, price: 54),
      CellData(x: "00:00:00", y: 19, price: 54),
      CellData(x: "00:00:00", y: 20, price: 54),
      CellData(x: "00:00:00", y: 21, price: 54),
      CellData(x: "00:00:00", y: 22, price: 54),
      CellData(x: "00:00:00", y: 23, price: 54),
      CellData(x: "00:00:00", y: 24, price: 54),
      CellData(x: "00:00:00", y: 25, price: 54),
      CellData(x: "00:00:00", y: 26, price: 54),
      CellData(x: "00:00:00", y: 27, price: 54),
      CellData(x: "00:00:00", y: 28, price: 54),
      CellData(x: "00:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "01:00:00", y: 1, price: 54),
      CellData(x: "01:00:00", y: 2, price: 54),
      CellData(x: "01:00:00", y: 3, price: 54),
      CellData(x: "01:00:00", y: 4, price: 54),
      CellData(x: "01:00:00", y: 5, price: 54),
      CellData(x: "01:00:00", y: 6, price: 54),
      CellData(x: "01:00:00", y: 7, price: 54),
      CellData(x: "01:00:00", y: 8, price: 54),
      CellData(x: "01:00:00", y: 9, price: 54),
      CellData(x: "01:00:00", y: 10, price: 54),
      CellData(x: "01:00:00", y: 11, price: 54),
      CellData(x: "01:00:00", y: 12, price: 54),
      CellData(x: "01:00:00", y: 13, price: 54),
      CellData(x: "01:00:00", y: 14, price: 54),
      CellData(x: "01:00:00", y: 15, price: 54),
      CellData(x: "01:00:00", y: 16, price: 54),
      CellData(x: "01:00:00", y: 17, price: 54),
      CellData(x: "01:00:00", y: 18, price: 54),
      CellData(x: "01:00:00", y: 19, price: 54),
      CellData(x: "01:00:00", y: 20, price: 54),
      CellData(x: "01:00:00", y: 21, price: 54),
      CellData(x: "01:00:00", y: 22, price: 54),
      CellData(x: "01:00:00", y: 23, price: 54),
      CellData(x: "01:00:00", y: 24, price: 54),
      CellData(x: "01:00:00", y: 25, price: 54),
      CellData(x: "01:00:00", y: 26, price: 54),
      CellData(x: "01:00:00", y: 27, price: 54),
      CellData(x: "01:00:00", y: 28, price: 54),
      CellData(x: "01:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "02:00:00", y: 1, price: 54),
      CellData(x: "02:00:00", y: 2, price: 54),
      CellData(x: "02:00:00", y: 3, price: 54),
      CellData(x: "02:00:00", y: 4, price: 54),
      CellData(x: "02:00:00", y: 5, price: 54),
      CellData(x: "02:00:00", y: 6, price: 54),
      CellData(x: "02:00:00", y: 7, price: 54),
      CellData(x: "02:00:00", y: 8, price: 54),
      CellData(x: "02:00:00", y: 9, price: 54),
      CellData(x: "02:00:00", y: 10, price: 54),
      CellData(x: "02:00:00", y: 11, price: 54),
      CellData(x: "02:00:00", y: 12, price: 54),
      CellData(x: "02:00:00", y: 13, price: 54),
      CellData(x: "02:00:00", y: 14, price: 54),
      CellData(x: "02:00:00", y: 15, price: 54),
      CellData(x: "02:00:00", y: 16, price: 54),
      CellData(x: "02:00:00", y: 17, price: 54),
      CellData(x: "02:00:00", y: 18, price: 54),
      CellData(x: "02:00:00", y: 19, price: 54),
      CellData(x: "02:00:00", y: 20, price: 54),
      CellData(x: "02:00:00", y: 21, price: 54),
      CellData(x: "02:00:00", y: 22, price: 54),
      CellData(x: "02:00:00", y: 23, price: 54),
      CellData(x: "02:00:00", y: 24, price: 54),
      CellData(x: "02:00:00", y: 25, price: 54),
      CellData(x: "02:00:00", y: 26, price: 54),
      CellData(x: "02:00:00", y: 27, price: 54),
      CellData(x: "02:00:00", y: 28, price: 54),
      CellData(x: "02:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "03:00:00", y: 1, price: 54),
      CellData(x: "03:00:00", y: 2, price: 54),
      CellData(x: "03:00:00", y: 3, price: 54),
      CellData(x: "03:00:00", y: 4, price: 54),
      CellData(x: "03:00:00", y: 5, price: 54),
      CellData(x: "03:00:00", y: 6, price: 54),
      CellData(x: "03:00:00", y: 7, price: 54),
      CellData(x: "03:00:00", y: 8, price: 54),
      CellData(x: "03:00:00", y: 9, price: 54),
      CellData(x: "03:00:00", y: 10, price: 54),
      CellData(x: "03:00:00", y: 11, price: 54),
      CellData(x: "03:00:00", y: 12, price: 54),
      CellData(x: "03:00:00", y: 13, price: 54),
      CellData(x: "03:00:00", y: 14, price: 54),
      CellData(x: "03:00:00", y: 15, price: 54),
      CellData(x: "03:00:00", y: 16, price: 54),
      CellData(x: "03:00:00", y: 17, price: 54),
      CellData(x: "03:00:00", y: 18, price: 54),
      CellData(x: "03:00:00", y: 19, price: 54),
      CellData(x: "03:00:00", y: 20, price: 54),
      CellData(x: "03:00:00", y: 21, price: 54),
      CellData(x: "03:00:00", y: 22, price: 54),
      CellData(x: "03:00:00", y: 23, price: 54),
      CellData(x: "03:00:00", y: 24, price: 54),
      CellData(x: "03:00:00", y: 25, price: 54),
      CellData(x: "03:00:00", y: 26, price: 54),
      CellData(x: "03:00:00", y: 27, price: 54),
      CellData(x: "03:00:00", y: 28, price: 54),
      CellData(x: "03:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "04:00:00", y: 1, price: 54),
      CellData(x: "04:00:00", y: 2, price: 54),
      CellData(x: "04:00:00", y: 3, price: 54),
      CellData(x: "04:00:00", y: 4, price: 54),
      CellData(x: "04:00:00", y: 5, price: 54),
      CellData(x: "04:00:00", y: 6, price: 54),
      CellData(x: "04:00:00", y: 7, price: 54),
      CellData(x: "04:00:00", y: 8, price: 54),
      CellData(x: "04:00:00", y: 9, price: 54),
      CellData(x: "04:00:00", y: 10, price: 54),
      CellData(x: "04:00:00", y: 11, price: 54),
      CellData(x: "04:00:00", y: 12, price: 54),
      CellData(x: "04:00:00", y: 13, price: 54),
      CellData(x: "04:00:00", y: 14, price: 54),
      CellData(x: "04:00:00", y: 15, price: 54),
      CellData(x: "04:00:00", y: 16, price: 54),
      CellData(x: "04:00:00", y: 17, price: 54),
      CellData(x: "04:00:00", y: 18, price: 54),
      CellData(x: "04:00:00", y: 19, price: 54),
      CellData(x: "04:00:00", y: 20, price: 54),
      CellData(x: "04:00:00", y: 21, price: 54),
      CellData(x: "04:00:00", y: 22, price: 54),
      CellData(x: "04:00:00", y: 23, price: 54),
      CellData(x: "04:00:00", y: 24, price: 54),
      CellData(x: "04:00:00", y: 25, price: 54),
      CellData(x: "04:00:00", y: 26, price: 54),
      CellData(x: "04:00:00", y: 27, price: 54),
      CellData(x: "04:00:00", y: 28, price: 54),
      CellData(x: "04:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "05:00:00", y: 1, price: 54),
      CellData(x: "05:00:00", y: 2, price: 54),
      CellData(x: "05:00:00", y: 3, price: 54),
      CellData(x: "05:00:00", y: 4, price: 54),
      CellData(x: "05:00:00", y: 5, price: 54),
      CellData(x: "05:00:00", y: 6, price: 54),
      CellData(x: "05:00:00", y: 7, price: 54),
      CellData(x: "05:00:00", y: 8, price: 54),
      CellData(x: "05:00:00", y: 9, price: 54),
      CellData(x: "05:00:00", y: 10, price: 54),
      CellData(x: "05:00:00", y: 11, price: 54),
      CellData(x: "05:00:00", y: 12, price: 54),
      CellData(x: "05:00:00", y: 13, price: 54),
      CellData(x: "05:00:00", y: 14, price: 54),
      CellData(x: "05:00:00", y: 15, price: 54),
      CellData(x: "05:00:00", y: 16, price: 54),
      CellData(x: "05:00:00", y: 17, price: 54),
      CellData(x: "05:00:00", y: 18, price: 54),
      CellData(x: "05:00:00", y: 19, price: 54),
      CellData(x: "05:00:00", y: 20, price: 54),
      CellData(x: "05:00:00", y: 21, price: 54),
      CellData(x: "05:00:00", y: 22, price: 54),
      CellData(x: "05:00:00", y: 23, price: 54),
      CellData(x: "05:00:00", y: 24, price: 54),
      CellData(x: "05:00:00", y: 25, price: 54),
      CellData(x: "05:00:00", y: 26, price: 54),
      CellData(x: "05:00:00", y: 27, price: 54),
      CellData(x: "05:00:00", y: 28, price: 54),
      CellData(x: "05:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "06:00:00", y: 1, price: 54),
      CellData(x: "06:00:00", y: 2, price: 54),
      CellData(x: "06:00:00", y: 3, price: 54),
      CellData(x: "06:00:00", y: 4, price: 54),
      CellData(x: "06:00:00", y: 5, price: 54),
      CellData(x: "06:00:00", y: 6, price: 54),
      CellData(x: "06:00:00", y: 7, price: 54),
      CellData(x: "06:00:00", y: 8, price: 54),
      CellData(x: "06:00:00", y: 9, price: 54),
      CellData(x: "06:00:00", y: 10, price: 54),
      CellData(x: "06:00:00", y: 11, price: 54),
      CellData(x: "06:00:00", y: 12, price: 54),
      CellData(x: "06:00:00", y: 13, price: 54),
      CellData(x: "06:00:00", y: 14, price: 54),
      CellData(x: "06:00:00", y: 15, price: 54),
      CellData(x: "06:00:00", y: 16, price: 54),
      CellData(x: "06:00:00", y: 17, price: 54),
      CellData(x: "06:00:00", y: 18, price: 54),
      CellData(x: "06:00:00", y: 19, price: 54),
      CellData(x: "06:00:00", y: 20, price: 54),
      CellData(x: "06:00:00", y: 21, price: 54),
      CellData(x: "06:00:00", y: 22, price: 54),
      CellData(x: "06:00:00", y: 23, price: 54),
      CellData(x: "06:00:00", y: 24, price: 54),
      CellData(x: "06:00:00", y: 25, price: 54),
      CellData(x: "06:00:00", y: 26, price: 54),
      CellData(x: "06:00:00", y: 27, price: 54),
      CellData(x: "06:00:00", y: 28, price: 54),
      CellData(x: "06:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "07:00:00", y: 1, price: 54),
      CellData(x: "07:00:00", y: 2, price: 54),
      CellData(x: "07:00:00", y: 3, price: 54),
      CellData(x: "07:00:00", y: 4, price: 54),
      CellData(x: "07:00:00", y: 5, price: 54),
      CellData(x: "07:00:00", y: 6, price: 54),
      CellData(x: "07:00:00", y: 7, price: 54),
      CellData(x: "07:00:00", y: 8, price: 54),
      CellData(x: "07:00:00", y: 9, price: 54),
      CellData(x: "07:00:00", y: 10, price: 54),
      CellData(x: "07:00:00", y: 11, price: 54),
      CellData(x: "07:00:00", y: 12, price: 54),
      CellData(x: "07:00:00", y: 13, price: 54),
      CellData(x: "07:00:00", y: 14, price: 54),
      CellData(x: "07:00:00", y: 15, price: 54),
      CellData(x: "07:00:00", y: 16, price: 54),
      CellData(x: "07:00:00", y: 17, price: 54),
      CellData(x: "07:00:00", y: 18, price: 54),
      CellData(x: "07:00:00", y: 19, price: 54),
      CellData(x: "07:00:00", y: 20, price: 54),
      CellData(x: "07:00:00", y: 21, price: 54),
      CellData(x: "07:00:00", y: 22, price: 54),
      CellData(x: "07:00:00", y: 23, price: 54),
      CellData(x: "07:00:00", y: 24, price: 54),
      CellData(x: "07:00:00", y: 25, price: 54),
      CellData(x: "07:00:00", y: 26, price: 54),
      CellData(x: "07:00:00", y: 27, price: 54),
      CellData(x: "07:00:00", y: 28, price: 54),
      CellData(x: "07:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "08:00:00", y: 1, price: 54),
      CellData(x: "08:00:00", y: 2, price: 54),
      CellData(x: "08:00:00", y: 3, price: 54),
      CellData(x: "08:00:00", y: 4, price: 54),
      CellData(x: "08:00:00", y: 5, price: 54),
      CellData(x: "08:00:00", y: 6, price: 54),
      CellData(x: "08:00:00", y: 7, price: 54),
      CellData(x: "08:00:00", y: 8, price: 54),
      CellData(x: "08:00:00", y: 9, price: 54),
      CellData(x: "08:00:00", y: 10, price: 54),
      CellData(x: "08:00:00", y: 11, price: 54),
      CellData(x: "08:00:00", y: 12, price: 54),
      CellData(x: "08:00:00", y: 13, price: 54),
      CellData(x: "08:00:00", y: 14, price: 54),
      CellData(x: "08:00:00", y: 15, price: 54),
      CellData(x: "08:00:00", y: 16, price: 54),
      CellData(x: "08:00:00", y: 17, price: 54),
      CellData(x: "08:00:00", y: 18, price: 54),
      CellData(x: "08:00:00", y: 19, price: 54),
      CellData(x: "08:00:00", y: 20, price: 54),
      CellData(x: "08:00:00", y: 21, price: 54),
      CellData(x: "08:00:00", y: 22, price: 54),
      CellData(x: "08:00:00", y: 23, price: 54),
      CellData(x: "08:00:00", y: 24, price: 54),
      CellData(x: "08:00:00", y: 25, price: 54),
      CellData(x: "08:00:00", y: 26, price: 54),
      CellData(x: "08:00:00", y: 27, price: 54),
      CellData(x: "08:00:00", y: 28, price: 54),
      CellData(x: "08:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "09:00:00", y: 1, price: 54),
      CellData(x: "09:00:00", y: 2, price: 54),
      CellData(x: "09:00:00", y: 3, price: 54),
      CellData(x: "09:00:00", y: 4, price: 54),
      CellData(x: "09:00:00", y: 5, price: 54),
      CellData(x: "09:00:00", y: 6, price: 54),
      CellData(x: "09:00:00", y: 7, price: 54),
      CellData(x: "09:00:00", y: 8, price: 54),
      CellData(x: "09:00:00", y: 9, price: 54),
      CellData(x: "09:00:00", y: 10, price: 54),
      CellData(x: "09:00:00", y: 11, price: 54),
      CellData(x: "09:00:00", y: 12, price: 54),
      CellData(x: "09:00:00", y: 13, price: 54),
      CellData(x: "09:00:00", y: 14, price: 54),
      CellData(x: "09:00:00", y: 15, price: 54),
      CellData(x: "09:00:00", y: 16, price: 54),
      CellData(x: "09:00:00", y: 17, price: 54),
      CellData(x: "09:00:00", y: 18, price: 54),
      CellData(x: "09:00:00", y: 19, price: 54),
      CellData(x: "09:00:00", y: 20, price: 54),
      CellData(x: "09:00:00", y: 21, price: 54),
      CellData(x: "09:00:00", y: 22, price: 54),
      CellData(x: "09:00:00", y: 23, price: 54),
      CellData(x: "09:00:00", y: 24, price: 54),
      CellData(x: "09:00:00", y: 25, price: 54),
      CellData(x: "09:00:00", y: 26, price: 54),
      CellData(x: "09:00:00", y: 27, price: 54),
      CellData(x: "09:00:00", y: 28, price: 54),
      CellData(x: "09:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "10:00:00", y: 1, price: 54),
      CellData(x: "10:00:00", y: 2, price: 54),
      CellData(x: "10:00:00", y: 3, price: 54),
      CellData(x: "10:00:00", y: 4, price: 54),
      CellData(x: "10:00:00", y: 5, price: 54),
      CellData(x: "10:00:00", y: 6, price: 54),
      CellData(x: "10:00:00", y: 7, price: 54),
      CellData(x: "10:00:00", y: 8, price: 54),
      CellData(x: "10:00:00", y: 9, price: 54),
      CellData(x: "10:00:00", y: 10, price: 54),
      CellData(x: "10:00:00", y: 11, price: 54),
      CellData(x: "10:00:00", y: 12, price: 54),
      CellData(x: "10:00:00", y: 13, price: 54),
      CellData(x: "10:00:00", y: 14, price: 54),
      CellData(x: "10:00:00", y: 15, price: 54),
      CellData(x: "10:00:00", y: 16, price: 54),
      CellData(x: "10:00:00", y: 17, price: 54),
      CellData(x: "10:00:00", y: 18, price: 54),
      CellData(x: "10:00:00", y: 19, price: 54),
      CellData(x: "10:00:00", y: 20, price: 54),
      CellData(x: "10:00:00", y: 21, price: 54),
      CellData(x: "10:00:00", y: 22, price: 54),
      CellData(x: "10:00:00", y: 23, price: 54),
      CellData(x: "10:00:00", y: 24, price: 54),
      CellData(x: "10:00:00", y: 25, price: 54),
      CellData(x: "10:00:00", y: 26, price: 54),
      CellData(x: "10:00:00", y: 27, price: 54),
      CellData(x: "10:00:00", y: 28, price: 54),
      CellData(x: "10:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "11:00:00", y: 1, price: 54),
      CellData(x: "11:00:00", y: 2, price: 54),
      CellData(x: "11:00:00", y: 3, price: 54),
      CellData(x: "11:00:00", y: 4, price: 54),
      CellData(x: "11:00:00", y: 5, price: 54),
      CellData(x: "11:00:00", y: 6, price: 54),
      CellData(x: "11:00:00", y: 7, price: 54),
      CellData(x: "11:00:00", y: 8, price: 54),
      CellData(x: "11:00:00", y: 9, price: 54),
      CellData(x: "11:00:00", y: 10, price: 54),
      CellData(x: "11:00:00", y: 11, price: 54),
      CellData(x: "11:00:00", y: 12, price: 54),
      CellData(x: "11:00:00", y: 13, price: 54),
      CellData(x: "11:00:00", y: 14, price: 54),
      CellData(x: "11:00:00", y: 15, price: 54),
      CellData(x: "11:00:00", y: 16, price: 54),
      CellData(x: "11:00:00", y: 17, price: 54),
      CellData(x: "11:00:00", y: 18, price: 54),
      CellData(x: "11:00:00", y: 19, price: 54),
      CellData(x: "11:00:00", y: 20, price: 54),
      CellData(x: "11:00:00", y: 21, price: 54),
      CellData(x: "11:00:00", y: 22, price: 54),
      CellData(x: "11:00:00", y: 23, price: 54),
      CellData(x: "11:00:00", y: 24, price: 54),
      CellData(x: "11:00:00", y: 25, price: 54),
      CellData(x: "11:00:00", y: 26, price: 54),
      CellData(x: "11:00:00", y: 27, price: 54),
      CellData(x: "11:00:00", y: 28, price: 54),
      CellData(x: "11:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "12:00:00", y: 1, price: 54),
      CellData(x: "12:00:00", y: 2, price: 54),
      CellData(x: "12:00:00", y: 3, price: 54),
      CellData(x: "12:00:00", y: 4, price: 54),
      CellData(x: "12:00:00", y: 5, price: 54),
      CellData(x: "12:00:00", y: 6, price: 54),
      CellData(x: "12:00:00", y: 7, price: 54),
      CellData(x: "12:00:00", y: 8, price: 54),
      CellData(x: "12:00:00", y: 9, price: 54),
      CellData(x: "12:00:00", y: 10, price: 54),
      CellData(x: "12:00:00", y: 11, price: 54),
      CellData(x: "12:00:00", y: 12, price: 54),
      CellData(x: "12:00:00", y: 13, price: 54),
      CellData(x: "12:00:00", y: 14, price: 54),
      CellData(x: "12:00:00", y: 15, price: 54),
      CellData(x: "12:00:00", y: 16, price: 54),
      CellData(x: "12:00:00", y: 17, price: 54),
      CellData(x: "12:00:00", y: 18, price: 54),
      CellData(x: "12:00:00", y: 19, price: 54),
      CellData(x: "12:00:00", y: 20, price: 54),
      CellData(x: "12:00:00", y: 21, price: 54),
      CellData(x: "12:00:00", y: 22, price: 54),
      CellData(x: "12:00:00", y: 23, price: 54),
      CellData(x: "12:00:00", y: 24, price: 54),
      CellData(x: "12:00:00", y: 25, price: 54),
      CellData(x: "12:00:00", y: 26, price: 54),
      CellData(x: "12:00:00", y: 27, price: 54),
      CellData(x: "12:00:00", y: 28, price: 54),
      CellData(x: "12:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "13:00:00", y: 1, price: 54),
      CellData(x: "13:00:00", y: 2, price: 54),
      CellData(x: "13:00:00", y: 3, price: 54),
      CellData(x: "13:00:00", y: 4, price: 54),
      CellData(x: "13:00:00", y: 5, price: 54),
      CellData(x: "13:00:00", y: 6, price: 54),
      CellData(x: "13:00:00", y: 7, price: 54),
      CellData(x: "13:00:00", y: 8, price: 54),
      CellData(x: "13:00:00", y: 9, price: 54),
      CellData(x: "13:00:00", y: 10, price: 54),
      CellData(x: "13:00:00", y: 11, price: 54),
      CellData(x: "13:00:00", y: 12, price: 54),
      CellData(x: "13:00:00", y: 13, price: 54),
      CellData(x: "13:00:00", y: 14, price: 54),
      CellData(x: "13:00:00", y: 15, price: 54),
      CellData(x: "13:00:00", y: 16, price: 54),
      CellData(x: "13:00:00", y: 17, price: 54),
      CellData(x: "13:00:00", y: 18, price: 54),
      CellData(x: "13:00:00", y: 19, price: 54),
      CellData(x: "13:00:00", y: 20, price: 54),
      CellData(x: "13:00:00", y: 21, price: 54),
      CellData(x: "13:00:00", y: 22, price: 54),
      CellData(x: "13:00:00", y: 23, price: 54),
      CellData(x: "13:00:00", y: 24, price: 54),
      CellData(x: "13:00:00", y: 25, price: 54),
      CellData(x: "13:00:00", y: 26, price: 54),
      CellData(x: "13:00:00", y: 27, price: 54),
      CellData(x: "13:00:00", y: 28, price: 54),
      CellData(x: "13:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "14:00:00", y: 1, price: 54),
      CellData(x: "14:00:00", y: 2, price: 54),
      CellData(x: "14:00:00", y: 3, price: 54),
      CellData(x: "14:00:00", y: 4, price: 54),
      CellData(x: "14:00:00", y: 5, price: 54),
      CellData(x: "14:00:00", y: 6, price: 54),
      CellData(x: "14:00:00", y: 7, price: 54),
      CellData(x: "14:00:00", y: 8, price: 54),
      CellData(x: "14:00:00", y: 9, price: 54),
      CellData(x: "14:00:00", y: 10, price: 54),
      CellData(x: "14:00:00", y: 11, price: 54),
      CellData(x: "14:00:00", y: 12, price: 54),
      CellData(x: "14:00:00", y: 13, price: 54),
      CellData(x: "14:00:00", y: 14, price: 54),
      CellData(x: "14:00:00", y: 15, price: 54),
      CellData(x: "14:00:00", y: 16, price: 54),
      CellData(x: "14:00:00", y: 17, price: 54),
      CellData(x: "14:00:00", y: 18, price: 54),
      CellData(x: "14:00:00", y: 19, price: 54),
      CellData(x: "14:00:00", y: 20, price: 54),
      CellData(x: "14:00:00", y: 21, price: 54),
      CellData(x: "14:00:00", y: 22, price: 54),
      CellData(x: "14:00:00", y: 23, price: 54),
      CellData(x: "14:00:00", y: 24, price: 54),
      CellData(x: "14:00:00", y: 25, price: 54),
      CellData(x: "14:00:00", y: 26, price: 54),
      CellData(x: "14:00:00", y: 27, price: 54),
      CellData(x: "14:00:00", y: 28, price: 54),
      CellData(x: "14:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "15:00:00", y: 1, price: 54),
      CellData(x: "15:00:00", y: 2, price: 54),
      CellData(x: "15:00:00", y: 3, price: 54),
      CellData(x: "15:00:00", y: 4, price: 54),
      CellData(x: "15:00:00", y: 5, price: 54),
      CellData(x: "15:00:00", y: 6, price: 54),
      CellData(x: "15:00:00", y: 7, price: 54),
      CellData(x: "15:00:00", y: 8, price: 54),
      CellData(x: "15:00:00", y: 9, price: 54),
      CellData(x: "15:00:00", y: 10, price: 54),
      CellData(x: "15:00:00", y: 11, price: 54),
      CellData(x: "15:00:00", y: 12, price: 54),
      CellData(x: "15:00:00", y: 13, price: 54),
      CellData(x: "15:00:00", y: 14, price: 54),
      CellData(x: "15:00:00", y: 15, price: 54),
      CellData(x: "15:00:00", y: 16, price: 54),
      CellData(x: "15:00:00", y: 17, price: 54),
      CellData(x: "15:00:00", y: 18, price: 54),
      CellData(x: "15:00:00", y: 19, price: 54),
      CellData(x: "15:00:00", y: 20, price: 54),
      CellData(x: "15:00:00", y: 21, price: 54),
      CellData(x: "15:00:00", y: 22, price: 54),
      CellData(x: "15:00:00", y: 23, price: 54),
      CellData(x: "15:00:00", y: 24, price: 54),
      CellData(x: "15:00:00", y: 25, price: 54),
      CellData(x: "15:00:00", y: 26, price: 54),
      CellData(x: "15:00:00", y: 27, price: 54),
      CellData(x: "15:00:00", y: 28, price: 54),
      CellData(x: "15:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "16:00:00", y: 1, price: 54),
      CellData(x: "16:00:00", y: 2, price: 54),
      CellData(x: "16:00:00", y: 3, price: 54),
      CellData(x: "16:00:00", y: 4, price: 54),
      CellData(x: "16:00:00", y: 5, price: 54),
      CellData(x: "16:00:00", y: 6, price: 54),
      CellData(x: "16:00:00", y: 7, price: 54),
      CellData(x: "16:00:00", y: 8, price: 54),
      CellData(x: "16:00:00", y: 9, price: 54),
      CellData(x: "16:00:00", y: 10, price: 54),
      CellData(x: "16:00:00", y: 11, price: 54),
      CellData(x: "16:00:00", y: 12, price: 54),
      CellData(x: "16:00:00", y: 13, price: 54),
      CellData(x: "16:00:00", y: 14, price: 54),
      CellData(x: "16:00:00", y: 15, price: 54),
      CellData(x: "16:00:00", y: 16, price: 54),
      CellData(x: "16:00:00", y: 17, price: 54),
      CellData(x: "16:00:00", y: 18, price: 54),
      CellData(x: "16:00:00", y: 19, price: 54),
      CellData(x: "16:00:00", y: 20, price: 54),
      CellData(x: "16:00:00", y: 21, price: 54),
      CellData(x: "16:00:00", y: 22, price: 54),
      CellData(x: "16:00:00", y: 23, price: 54),
      CellData(x: "16:00:00", y: 24, price: 54),
      CellData(x: "16:00:00", y: 25, price: 54),
      CellData(x: "16:00:00", y: 26, price: 54),
      CellData(x: "16:00:00", y: 27, price: 54),
      CellData(x: "16:00:00", y: 28, price: 54),
      CellData(x: "16:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "17:00:00", y: 1, price: 54),
      CellData(x: "17:00:00", y: 2, price: 54),
      CellData(x: "17:00:00", y: 3, price: 54),
      CellData(x: "17:00:00", y: 4, price: 54),
      CellData(x: "17:00:00", y: 5, price: 54),
      CellData(x: "17:00:00", y: 6, price: 54),
      CellData(x: "17:00:00", y: 7, price: 54),
      CellData(x: "17:00:00", y: 8, price: 54),
      CellData(x: "17:00:00", y: 9, price: 54),
      CellData(x: "17:00:00", y: 10, price: 54),
      CellData(x: "17:00:00", y: 11, price: 54),
      CellData(x: "17:00:00", y: 12, price: 54),
      CellData(x: "17:00:00", y: 13, price: 54),
      CellData(x: "17:00:00", y: 14, price: 54),
      CellData(x: "17:00:00", y: 15, price: 54),
      CellData(x: "17:00:00", y: 16, price: 54),
      CellData(x: "17:00:00", y: 17, price: 54),
      CellData(x: "17:00:00", y: 18, price: 54),
      CellData(x: "17:00:00", y: 19, price: 54),
      CellData(x: "17:00:00", y: 20, price: 54),
      CellData(x: "17:00:00", y: 21, price: 54),
      CellData(x: "17:00:00", y: 22, price: 54),
      CellData(x: "17:00:00", y: 23, price: 54),
      CellData(x: "17:00:00", y: 24, price: 54),
      CellData(x: "17:00:00", y: 25, price: 54),
      CellData(x: "17:00:00", y: 26, price: 54),
      CellData(x: "17:00:00", y: 27, price: 54),
      CellData(x: "17:00:00", y: 28, price: 54),
      CellData(x: "17:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "18:00:00", y: 1, price: 54),
      CellData(x: "18:00:00", y: 2, price: 54),
      CellData(x: "18:00:00", y: 3, price: 54),
      CellData(x: "18:00:00", y: 4, price: 54),
      CellData(x: "18:00:00", y: 5, price: 54),
      CellData(x: "18:00:00", y: 6, price: 54),
      CellData(x: "18:00:00", y: 7, price: 54),
      CellData(x: "18:00:00", y: 8, price: 54),
      CellData(x: "18:00:00", y: 9, price: 54),
      CellData(x: "18:00:00", y: 10, price: 54),
      CellData(x: "18:00:00", y: 11, price: 54),
      CellData(x: "18:00:00", y: 12, price: 54),
      CellData(x: "18:00:00", y: 13, price: 54),
      CellData(x: "18:00:00", y: 14, price: 54),
      CellData(x: "18:00:00", y: 15, price: 54),
      CellData(x: "18:00:00", y: 16, price: 54),
      CellData(x: "18:00:00", y: 17, price: 54),
      CellData(x: "18:00:00", y: 18, price: 54),
      CellData(x: "18:00:00", y: 19, price: 54),
      CellData(x: "18:00:00", y: 20, price: 54),
      CellData(x: "18:00:00", y: 21, price: 54),
      CellData(x: "18:00:00", y: 22, price: 54),
      CellData(x: "18:00:00", y: 23, price: 54),
      CellData(x: "18:00:00", y: 24, price: 54),
      CellData(x: "18:00:00", y: 25, price: 54),
      CellData(x: "18:00:00", y: 26, price: 54),
      CellData(x: "18:00:00", y: 27, price: 54),
      CellData(x: "18:00:00", y: 28, price: 54),
      CellData(x: "18:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "19:00:00", y: 1, price: 54),
      CellData(x: "19:00:00", y: 2, price: 54),
      CellData(x: "19:00:00", y: 3, price: 54),
      CellData(x: "19:00:00", y: 4, price: 54),
      CellData(x: "19:00:00", y: 5, price: 54),
      CellData(x: "19:00:00", y: 6, price: 54),
      CellData(x: "19:00:00", y: 7, price: 54),
      CellData(x: "19:00:00", y: 8, price: 54),
      CellData(x: "19:00:00", y: 9, price: 54),
      CellData(x: "19:00:00", y: 10, price: 54),
      CellData(x: "19:00:00", y: 11, price: 54),
      CellData(x: "19:00:00", y: 12, price: 54),
      CellData(x: "19:00:00", y: 13, price: 54),
      CellData(x: "19:00:00", y: 14, price: 54),
      CellData(x: "19:00:00", y: 15, price: 54),
      CellData(x: "19:00:00", y: 16, price: 54),
      CellData(x: "19:00:00", y: 17, price: 54),
      CellData(x: "19:00:00", y: 18, price: 54),
      CellData(x: "19:00:00", y: 19, price: 54),
      CellData(x: "19:00:00", y: 20, price: 54),
      CellData(x: "19:00:00", y: 21, price: 54),
      CellData(x: "19:00:00", y: 22, price: 54),
      CellData(x: "19:00:00", y: 23, price: 54),
      CellData(x: "19:00:00", y: 24, price: 54),
      CellData(x: "19:00:00", y: 25, price: 54),
      CellData(x: "19:00:00", y: 26, price: 54),
      CellData(x: "19:00:00", y: 27, price: 54),
      CellData(x: "19:00:00", y: 28, price: 54),
      CellData(x: "19:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "20:00:00", y: 1, price: 54),
      CellData(x: "20:00:00", y: 2, price: 54),
      CellData(x: "20:00:00", y: 3, price: 54),
      CellData(x: "20:00:00", y: 4, price: 54),
      CellData(x: "20:00:00", y: 5, price: 54),
      CellData(x: "20:00:00", y: 6, price: 54),
      CellData(x: "20:00:00", y: 7, price: 54),
      CellData(x: "20:00:00", y: 8, price: 54),
      CellData(x: "20:00:00", y: 9, price: 54),
      CellData(x: "20:00:00", y: 10, price: 54),
      CellData(x: "20:00:00", y: 11, price: 54),
      CellData(x: "20:00:00", y: 12, price: 54),
      CellData(x: "20:00:00", y: 13, price: 54),
      CellData(x: "20:00:00", y: 14, price: 54),
      CellData(x: "20:00:00", y: 15, price: 54),
      CellData(x: "20:00:00", y: 16, price: 54),
      CellData(x: "20:00:00", y: 17, price: 54),
      CellData(x: "20:00:00", y: 18, price: 54),
      CellData(x: "20:00:00", y: 19, price: 54),
      CellData(x: "20:00:00", y: 20, price: 54),
      CellData(x: "20:00:00", y: 21, price: 54),
      CellData(x: "20:00:00", y: 22, price: 54),
      CellData(x: "20:00:00", y: 23, price: 54),
      CellData(x: "20:00:00", y: 24, price: 54),
      CellData(x: "20:00:00", y: 25, price: 54),
      CellData(x: "20:00:00", y: 26, price: 54),
      CellData(x: "20:00:00", y: 27, price: 54),
      CellData(x: "20:00:00", y: 28, price: 54),
      CellData(x: "20:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "21:00:00", y: 1, price: 54),
      CellData(x: "21:00:00", y: 2, price: 54),
      CellData(x: "21:00:00", y: 3, price: 54),
      CellData(x: "21:00:00", y: 4, price: 54),
      CellData(x: "21:00:00", y: 5, price: 54),
      CellData(x: "21:00:00", y: 6, price: 54),
      CellData(x: "21:00:00", y: 7, price: 54),
      CellData(x: "21:00:00", y: 8, price: 54),
      CellData(x: "21:00:00", y: 9, price: 54),
      CellData(x: "21:00:00", y: 10, price: 54),
      CellData(x: "21:00:00", y: 11, price: 54),
      CellData(x: "21:00:00", y: 12, price: 54),
      CellData(x: "21:00:00", y: 13, price: 54),
      CellData(x: "21:00:00", y: 14, price: 54),
      CellData(x: "21:00:00", y: 15, price: 54),
      CellData(x: "21:00:00", y: 16, price: 54),
      CellData(x: "21:00:00", y: 17, price: 54),
      CellData(x: "21:00:00", y: 18, price: 54),
      CellData(x: "21:00:00", y: 19, price: 54),
      CellData(x: "21:00:00", y: 20, price: 54),
      CellData(x: "21:00:00", y: 21, price: 54),
      CellData(x: "21:00:00", y: 22, price: 54),
      CellData(x: "21:00:00", y: 23, price: 54),
      CellData(x: "21:00:00", y: 24, price: 54),
      CellData(x: "21:00:00", y: 25, price: 54),
      CellData(x: "21:00:00", y: 26, price: 54),
      CellData(x: "21:00:00", y: 27, price: 54),
      CellData(x: "21:00:00", y: 28, price: 54),
      CellData(x: "21:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "22:00:00", y: 1, price: 54),
      CellData(x: "22:00:00", y: 2, price: 54),
      CellData(x: "22:00:00", y: 3, price: 54),
      CellData(x: "22:00:00", y: 4, price: 54),
      CellData(x: "22:00:00", y: 5, price: 54),
      CellData(x: "22:00:00", y: 6, price: 54),
      CellData(x: "22:00:00", y: 7, price: 54),
      CellData(x: "22:00:00", y: 8, price: 54),
      CellData(x: "22:00:00", y: 9, price: 54),
      CellData(x: "22:00:00", y: 10, price: 54),
      CellData(x: "22:00:00", y: 11, price: 54),
      CellData(x: "22:00:00", y: 12, price: 54),
      CellData(x: "22:00:00", y: 13, price: 54),
      CellData(x: "22:00:00", y: 14, price: 54),
      CellData(x: "22:00:00", y: 15, price: 54),
      CellData(x: "22:00:00", y: 16, price: 54),
      CellData(x: "22:00:00", y: 17, price: 54),
      CellData(x: "22:00:00", y: 18, price: 54),
      CellData(x: "22:00:00", y: 19, price: 54),
      CellData(x: "22:00:00", y: 20, price: 54),
      CellData(x: "22:00:00", y: 21, price: 54),
      CellData(x: "22:00:00", y: 22, price: 54),
      CellData(x: "22:00:00", y: 23, price: 54),
      CellData(x: "22:00:00", y: 24, price: 54),
      CellData(x: "22:00:00", y: 25, price: 54),
      CellData(x: "22:00:00", y: 26, price: 54),
      CellData(x: "22:00:00", y: 27, price: 54),
      CellData(x: "22:00:00", y: 28, price: 54),
      CellData(x: "22:00:00", y: 29, price: 54),
    ],
    [
      CellData(x: "23:00:00", y: 1, price: 54),
      CellData(x: "23:00:00", y: 2, price: 54),
      CellData(x: "23:00:00", y: 3, price: 54),
      CellData(x: "23:00:00", y: 4, price: 54),
      CellData(x: "23:00:00", y: 5, price: 54),
      CellData(x: "23:00:00", y: 6, price: 54),
      CellData(x: "23:00:00", y: 7, price: 54),
      CellData(x: "23:00:00", y: 8, price: 54),
      CellData(x: "23:00:00", y: 9, price: 54),
      CellData(x: "23:00:00", y: 10, price: 54),
      CellData(x: "23:00:00", y: 11, price: 54),
      CellData(x: "23:00:00", y: 12, price: 54),
      CellData(x: "23:00:00", y: 13, price: 54),
      CellData(x: "23:00:00", y: 14, price: 54),
      CellData(x: "23:00:00", y: 15, price: 54),
      CellData(x: "23:00:00", y: 16, price: 54),
      CellData(x: "23:00:00", y: 17, price: 54),
      CellData(x: "23:00:00", y: 18, price: 54),
      CellData(x: "23:00:00", y: 19, price: 54),
      CellData(x: "23:00:00", y: 20, price: 54),
      CellData(x: "23:00:00", y: 21, price: 54),
      CellData(x: "23:00:00", y: 22, price: 54),
      CellData(x: "23:00:00", y: 23, price: 54),
      CellData(x: "23:00:00", y: 24, price: 54),
      CellData(x: "23:00:00", y: 25, price: 54),
      CellData(x: "23:00:00", y: 26, price: 54),
      CellData(x: "23:00:00", y: 27, price: 54),
      CellData(x: "23:00:00", y: 28, price: 54),
      CellData(x: "23:00:00", y: 29, price: 54),
    ],
  ];
  var fixedColCells = [
    "00:00",
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
  ];
  var fixedRowCells = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
  ];
  var fixedRowCells1 = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
  ];
  var fixedRowCells2 = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28"
  ];
  var fixedRowCells3 = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
  ];
  late BookPitchSlot pitchslot;
  bool _isLoading = true;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  Map<int, List<dynamic>> map = {};
  late String month;
  late String monthEnglish;
  List time = [];
  late Map slotsinformation;
  late String monthNow;
  late String yearNow;
  late String year;
  var urlDetail;
  late String _curentlySelectedItem;
  late String _curentlySelectedItem1;
  int count2 = 0;
  late Map detail;
  late Map slotDetail;
  late bool _internet;
  bool monthState = false;

  loadBookPitchSlot() async {
    await _networkCalls.bookpitchSlot(
      urlDetail: urlDetail,
      onSuccess: (pitchInfo) {
        cellDataChangesempty();
        pitchslot = pitchInfo;
        year = pitchslot.year.toString();
        if (pitchslot.months!.isEmpty == false) {
          _curentlySelectedItem = pitchslot.year.toString();
          _curentlySelectedItem1 =
              monthFindRevers(index: pitchslot.months![0]!.monthNumber!);
          month = AppLocalizations.of(context)!.locale == "en"
              ? monthFindRevers(index: pitchslot.months![0]!.monthNumber!)
              : monthFindReversAr(index: pitchslot.months![0]!.monthNumber!);
          monthEnglish =
              monthFindRevers(index: pitchslot.months![0]!.monthNumber!);
          cellDataChanges();
          monthState = !monthState;
        } else {
          _curentlySelectedItem = yearNow;
          monthFindRevers(index: int.parse(monthNow));
          _curentlySelectedItem1 = month;
        }
        if (mounted) {
          setState(() {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        monthNow = widget.id["month"].toString();
        yearNow = widget.id["year"].toString();
        urlDetail = {
          "month": monthNow,
          "year": yearNow,
          "id": widget.id["id"],
          "ids": widget.id["ids"]
        };
        loadBookPitchSlot();
      } else {
        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0XFFFFFFFF),
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: Container(
                  height: 18,
                  width: 180,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0) //

                        ),
                  ),
                ),
              ),
              backgroundColor: const Color(0XFF032040),
            ),
            bottomNavigationBar: Container(
              alignment: Alignment.topCenter,
              height: sizeHeight * .085,
              color: const Color(0XFF25A163),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    flaxibleGap(1),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: 18,
                        width: 200,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0) //

                              ),
                        ),
                      ),
                    ),
                    flaxibleGap(9),
                  ],
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  height: sizeHeight * .05,
                  width: sizeWidth,
                  color: const Color(0XFFF0F0F0),
                  child: Row(
                    children: <Widget>[
                      flaxibleGap(1),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.arrow_back_ios,
                            color: Color(0XFFADADAD),
                            size: 16,
                          ),
                          Text(
                            AppLocalizations.of(context)!.prev,
                            style: const TextStyle(
                              color: Color(0XFFADADAD),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      flaxibleGap(3),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                    ),
                          ),
                        ),
                      ),
                      flaxibleGap(3),
                      Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.next,
                            style: const TextStyle(
                              color: Color(0XFFADADAD),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0XFFADADAD),
                            size: 16,
                          ),
                        ],
                      ),
                      flaxibleGap(1),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: sizeHeight * .7,
                    width: sizeWidth,
                    child: CustomDataTable(
                      cellWidth: sizeWidth * .19,
                      cellHeight: sizeWidth * .20,
                      rowsCells: rowsCells,
                      fixedColCells: fixedColCells,
                      fixedRowCells: fixedRowCells,
                      month: "January",
                      year: "2020",
                      cellBuilder: (data) {
                        return data == 52
                            ? Container(
                                alignment: Alignment.center,
                                // height: 10,
                                // width: 10,
                                color: Colors.white,
                              )
                            : data.runtimeType == int
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    enabled: true,
                                    child: Container(
                                      alignment: Alignment.center,
                                      // height: 10,
                                      // width: 10,
                                      color: Colors.white,
                                    ),
                                  )
                                : data.toString().length <= 2
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Container(
                                          alignment: Alignment.center,
                                          // height: 10,
                                          // width: 10,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        height: sizeHeight * .055,
                                        width: sizeWidth * .1,
                                        child: Text(
                                          '${timeFormate(index: data.toString())} ${int.parse(data.toString().substring(0, 2)) <= 11 ? AppLocalizations.of(context)!.am : AppLocalizations.of(context)!.pm}',
                                          style: const TextStyle(
                                              color: Color(0XFF696969),
                                              fontSize: 13),
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : _internet
            ? Scaffold(
                key: scaffoldkey,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text(
                    '${pitchslot.pitchType!.area} ${pitchslot.pitchType!.name}',
                    style: TextStyle(
                        fontSize: appHeaderFont,
                        color: const Color(0XFFFFFFFF),
                        fontFamily: AppLocalizations.of(context)!.locale == "en"
                            ? "Poppins"
                            : "VIP",
                        fontWeight: AppLocalizations.of(context)!.locale == "en"
                            ? FontWeight.normal
                            : FontWeight.normal),
                  ),
                  backgroundColor: const Color(0XFF032040),
                ),
                bottomNavigationBar: count2 == 0
                    ? SizedBox(
                        height: sizeHeight * .085,
                        child: Container(
                          alignment: Alignment.topCenter,
                          color: const Color(0XFF25A163),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                flaxibleGap(1),
                                Text(
                                  '${pitchslot.pitchType!.area} ${pitchslot.pitchType!.name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppLocalizations.of(context)!
                                                  .locale ==
                                              "en"
                                          ? 18
                                          : 22,
                                      color: const Color(0XFFFFFFFF)),
                                ),
                                flaxibleGap(9),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: sizeHeight * .09,
                        child: Container(
                          alignment: Alignment.topCenter,
                          color: const Color(0XFF25A163),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                flaxibleGap(1),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context)!.currency} ${count2 * pitchslot.pitchType!.paymentSummary!.grandTotal!.round()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Color(0XFFFFFFFF)),
                                    ),
                                    Text(
                                      '$count2 ${AppLocalizations.of(context)!.slot} ${AppLocalizations.of(context)!.selected}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Color(0XFFFFFFFF)),
                                    ),
                                  ],
                                ),
                                flaxibleGap(4),
                                GestureDetector(
                                  onTap: () {
                                    var day = "0";
                                    var id = "0";
                                    detail["dayId"].forEach((key, value) {
                                      // ignore: prefer_interpolation_to_compose_strings
                                      day = "$day," + key;
                                      value.forEach((element) {
                                        id = "$id,$element";
                                      });
                                    });
                                    var detailSend = {
                                      "year": detail["year"],
                                      "month": detail["month"],
                                      "id": detail["id"]["id"],
                                      "day": day.substring(2),
                                      "ids": id.substring(2),
                                      "idsPitch": widget.id["ids"]
                                    };
                                    _networkCalls.pitchSlotCheck(
                                      urlDetail: detailSend,
                                      onSuccess: (msg) {
                                        if (msg) {
                                          navigateToDetail();
                                        } else {
                                          setState(() {
                                            showMessage(
                                                "your pitch slot has been unavailable, please choose other pitch slot");
                                            _isLoading = true;
                                            count2 = 0;
                                            cellDataChangesempty();
                                            loadBookPitchSlot();
                                          });
                                        }
                                      },
                                      onFailure: (msg) {
                                        if (mounted) {
                                          showMessage(msg);
                                        }
                                      },
                                      tokenExpire: () {
                                        if (mounted) on401(context);
                                      },
                                    );
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
                                    height: 30,
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!.proceed,
                                      style: TextStyle(
                                        color: const Color(0XFF25A163),
                                        fontSize: AppLocalizations.of(context)!
                                                    .locale ==
                                                "en"
                                            ? 18
                                            : 22,
                                      ),
                                    ),
                                  ),
                                ),
                                flaxibleGap(1),
                              ],
                            ),
                          ),
                        ),
                      ),
                body: Column(
                  children: <Widget>[
                    Container(
                      height: sizeHeight * .05,
                      width: sizeWidth,
                      color: const Color(0XFFF0F0F0),
                      child: Row(
                        children: <Widget>[
                          flaxibleGap(1),
                          monthState
                              ? Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0XFFADADAD),
                                      size: 16,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.prev,
                                      style: const TextStyle(
                                        color: Color(0XFFADADAD),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                )
                              : Material(
                                  color: const Color(0XFFF0F0F0),
                                  child: InkWell(
                                    splashColor: Colors.black,
                                    onTap: () {
                                      _networkCalls.checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        if (msg == true) {
                                          if (mounted) {
                                            setState(() {
                                              if (monthNow == "1") {
                                                monthNow = "12";
                                                yearNow =
                                                    (int.parse(yearNow) - 1)
                                                        .toString();
                                                year = yearNow;
                                                month = monthFindRevers(
                                                    index: int.parse(monthNow));
                                              } else {
                                                monthNow =
                                                    (int.parse(monthNow) - 1)
                                                        .toString();
                                                year = yearNow;
                                                month = month = monthFindRevers(
                                                    index: int.parse(monthNow));
                                              }
                                              count2 = 0;
                                              urlDetail = {
                                                "month": monthNow,
                                                "year": yearNow,
                                                "id": widget.id["id"],
                                                "ids": widget.id["ids"]
                                              };
                                              _isLoading = true;
                                              cellDataChangesempty();
                                              loadBookPitchSlot();
                                            });
                                          }
                                        } else {
                                          if (mounted) {
                                            showMessage(
                                                AppLocalizations.of(context)!
                                                    .noInternetConnection);
                                          }
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.arrow_back_ios,
                                          color: Color(0XFF032040),
                                          size: 16,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.prev,
                                          style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          flaxibleGap(3),
                          Text(
                            month,
                            style: const TextStyle(
                                color: Color(0XFF032040),
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          Text(
                            " $_curentlySelectedItem",
                            style: const TextStyle(
                                color: Color(0XFF032040),
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                          flaxibleGap(3),
                          monthState
                              ? Material(
                                  color: const Color(0XFFF0F0F0),
                                  child: InkWell(
                                    splashColor: Colors.black,
                                    onTap: () {
                                      _networkCalls.checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        if (msg == true) {
                                          if (mounted) {
                                            setState(() {
                                              if (monthNow == "12") {
                                                monthNow = "1";
                                                yearNow =
                                                    (int.parse(yearNow) + 1)
                                                        .toString();
                                                year = yearNow;
                                                month = monthFindRevers(
                                                    index: int.parse(monthNow));
                                              } else {
                                                monthNow =
                                                    (int.parse(monthNow) + 1)
                                                        .toString();
                                                year = yearNow;
                                                month = monthFindRevers(
                                                    index: int.parse(monthNow));
                                              }
                                              count2 = 0;
                                              urlDetail = {
                                                "month": monthNow,
                                                "year": yearNow,
                                                "id": widget.id["id"],
                                                "ids": widget.id["ids"]
                                              };
                                              _isLoading = true;
                                              cellDataChangesempty();
                                              loadBookPitchSlot();
                                            });
                                          }
                                        } else {
                                          if (mounted) {
                                            showMessage(
                                                AppLocalizations.of(context)!
                                                    .noInternetConnection);
                                          }
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)!.next,
                                          style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0XFF032040),
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Row(
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.next,
                                      style: const TextStyle(
                                        color: Color(0XFFADADAD),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0XFFADADAD),
                                      size: 16,
                                    ),
                                  ],
                                ),
                          flaxibleGap(1),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: sizeHeight * .7,
                        width: sizeWidth,
                        child: CustomDataTable(
                          cellWidth: sizeWidth * .19,
                          cellHeight: sizeWidth * .20,
                          rowsCells: monthReturn() == 1
                              ? rowsCells
                              : monthReturn() == 2
                                  ? rowsCells1
                                  : monthReturn() == 4
                                      ? rowsCells2
                                      : rowsCells3,
                          fixedColCells: fixedColCells,
                          fixedRowCells: monthReturn() == 1
                              ? fixedRowCells
                              : monthReturn() == 2
                                  ? fixedRowCells1
                                  : monthReturn() == 4
                                      ? fixedRowCells2
                                      : fixedRowCells3,
                          month: monthEnglish,
                          count: count2,
                          year: year,
                          onChange: (count) {
                            setState(() {
                              count2 = count;
                            });
                          },
                          detail: (count) {
                            detail = {
                              "dayId": count,
                              "year": _curentlySelectedItem,
                              "month": monthFind(index: _curentlySelectedItem1),
                              "id": widget.id
                            };
                          },
                          monthDetail: (detail) {
                            map.clear();
                            detail.forEach((key, value) {
                              time.clear();
                              value.forEach((element) {
                                var value = element.toString();
                                String timeslot = value.substring(0, 2);
                                time.add(int.parse(timeslot));
                                time.sort();
                              });
                              for (int i = 0; i < time.length; i++) {
                                if (!map.containsKey(int.parse(key))) {
                                  map[int.parse(key)] = [time[i]];
                                } else {
                                  map[int.parse(key)]!.add(time[i]);
                                }
                              }
                            });
                            slotsinformation = {
                              "days": map,
                              "year": _curentlySelectedItem,
                              "month": monthFind(index: _curentlySelectedItem1),
                            };
                          },
                          cellBuilder: (data) {
                            return data == 52
                                ? const Text('')
                                : data == 1800
                                    ? Container(
                                        alignment: Alignment.center,
                                        height: sizeHeight * .055,
                                        width: sizeWidth * .1,
                                        child: Text(
                                          '${AppLocalizations.of(context)!.currency} ${pitchslot.pitchType!.paymentSummary!.grandTotal!.round()}',
                                          style: const TextStyle(
                                              color: Color(0XFF696969),
                                              fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : data == 1801
                                        ? Container(
                                            alignment: Alignment.center,
                                            height: sizeHeight * .055,
                                            width: sizeWidth * .1,
                                            child: Text(
                                              '${AppLocalizations.of(context)!.currency} ${pitchslot.pitchType!.paymentSummary!.grandTotal!.round()}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : data == 1802
                                            ? Container(
                                                alignment: Alignment.center,
                                                height: sizeHeight * .055,
                                                width: sizeWidth * .1,
                                                child: Text(
                                                  '${AppLocalizations.of(context)!.currency} ${pitchslot.pitchType!.paymentSummary!.grandTotal!.round()}',
                                                  style: const TextStyle(
                                                      color: Color(0XFF696969),
                                                      fontSize: 13),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            : data == 1700
                                                ? Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    height: sizeHeight * .055,
                                                    width: sizeWidth * .1,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                          '${AppLocalizations.of(context)!.currency} ${pitchslot.pitchType!.paymentSummary!.grandTotal!.round()}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .booked,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : data == 1702
                                                    ? Container(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        height:
                                                            sizeHeight * .055,
                                                        width: sizeWidth * .1,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              '${AppLocalizations.of(context)!.currency} ${pitchslot.pitchType!.paymentSummary!.grandTotal!.round()}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .booked,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : data.toString().length <=
                                                            2
                                                        ? Container(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            height: sizeHeight *
                                                                .03,
                                                            width:
                                                                sizeWidth * .1,
                                                            child: Text(
                                                              ' $data',
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF696969),
                                                                  fontSize: 16),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          )
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: sizeHeight *
                                                                .055,
                                                            width:
                                                                sizeWidth * .1,
                                                            child: Text(
                                                              '${timeFormate(index: data.toString())} ${int.parse(data.toString().substring(0, 2)) <= 11 ? AppLocalizations.of(context)!.am : AppLocalizations.of(context)!.pm}',
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF696969),
                                                                  fontSize: 13),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Material(
                child: SizedBox(
                  height: sizeHeight,
                  width: sizeWidth,
                  child: InternetLoss(
                    onChange: () {
                      if (mounted) {
                        _networkCalls.checkInternetConnectivity(
                            onSuccess: (msg) {
                          _internet = msg;
                          if (msg == true) {
                            setState(() {
                              _isLoading = true;
                            });
                            monthNow = DateFormat.M('en_US').format(
                                DateTime.parse(DateTime.now().toString()));
                            yearNow = DateFormat.y('en_US').format(
                                DateTime.parse(DateTime.now().toString()));
                            urlDetail = {
                              "month": monthNow,
                              "year": yearNow,
                              "id": widget.id["id"],
                              "ids": widget.id["ids"]
                            };
                            loadBookPitchSlot();
                          } else {
                            if (mounted) {
                              showMessage(AppLocalizations.of(context)!
                                  .noInternetConnection);
                            }
                          }
                        });
                      }
                    },
                  ),
                ),
              );
  }

  void navigateToDetail() {
    var deatil = {
      "price":
          count2 * pitchslot.pitchType!.paymentSummary!.grandTotal!.round(),
      "apidetail": detail,
      "slotdetail": slotsinformation,
      "pitchtype": pitchslot.pitchType!.name,
      "count": count2,
      "detail": pitchslot.pitchType!.paymentSummary,
      "ids": widget.id["ids"],
      "email": widget.id["email"]
    };
    Navigator.pushNamed(context, RouteNames.enterDetailAcademy,
        arguments: deatil);
  }

  bool leapYear() {
    int year1 = yearFind(index: year ?? '2020');
    if (year1 % 4 == 0) {
      if (year1 % 100 == 0) {
        if (year1 % 400 == 0) {
          return true;
          //print(" $year, is  a leap year");
        } else {
          return false;
          //print(" $year, is not a leap year");
        }
      } else {
        return true;
        //  print(" $year, is  a leap year");
      }
    } else {
      return false;
      // print(" $year, is not a leap year");
    }
  }

  int yearFind({required String index}) {
    int day;
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

  String timeFormate({required String index}) {
    String day;
    switch (index) {
      case "00:00":
        day = "12:00";
        break;

      case "01:00":
        day = "1:00";
        break;

      case "02:00":
        day = "2:00";
        break;

      case "03:00":
        day = "3:00";
        break;
      case "04:00":
        day = "4:00";
        break;

      case "05:00":
        day = "5:00";
        break;
      case "06:00":
        day = "6:00";
        break;
      case "07:00":
        day = "7:00";
        break;

      case "08:00":
        day = "8:00";
        break;

      case "09:00":
        day = "9:00";
        break;

      case "10:00":
        day = "10:00";
        break;
      case "11:00":
        day = "11:00";
        break;

      case "12:00":
        day = "12:00";
        break;
      case "13:00":
        day = "1:00";
        break;

      case "14:00":
        day = "2:00";
        break;

      case "15:00":
        day = "3:00";
        break;

      case "16:00":
        day = "4:00";
        break;
      case "17:00":
        day = "5:00";
        break;

      case "18:00":
        day = "6:00";
        break;
      case "19:00":
        day = "7:00";
        break;

      case "20:00":
        day = "8:00";
        break;

      case "21:00":
        day = "9:00";
        break;
      case "22:00":
        day = "10:00";
        break;
      default:
        day = "11:00";
        break;
    }
    return day;
  }

  int? monthReturn() {
    bool year2 = leapYear();
    int month1 = monthFind(index: monthEnglish ?? 'January');
    if (month1 == 1 ||
        month1 == 3 ||
        month1 == 5 ||
        month1 == 7 ||
        month1 == 8 ||
        month1 == 10 ||
        month1 == 12) {
      return 1;
    }
    if (month1 == 4 || month1 == 6 || month1 == 9 || month1 == 11) {
      return 2;
    }
    if (year2 && month1 == 2) {
      return 3;
    }
    if (!year2 && month1 == 2) {
      return 4;
    }
    return null;
  }

  cellDataChanges() {
    bool year2 = leapYear();
    int month1 = monthFind(index: monthEnglish ?? 'January');
    if (month1 == 1 ||
        month1 == 3 ||
        month1 == 5 ||
        month1 == 7 ||
        month1 == 8 ||
        month1 == 10 ||
        month1 == 12) {
      //return 1;
      for (int i = 0; i < pitchslot.months![0]!.days!.length; i++) {
        for (int j = 0;
            j < pitchslot.months![0]!.days![i]!.slots!.length;
            j++) {
          for (int m = 0; m < rowsCells.length; m++) {
            for (int n = 0; n < rowsCells[0].length; n++) {
              if (timeComparison(
                      currentTime: pitchslot.current_datetime.toString(),
                      year: _curentlySelectedItem,
                      month: _curentlySelectedItem1,
                      date: rowsCells[m][n].y,
                      hour: rowsCells[m][n].x.substring(0, 2)) ==
                  false) {
                if (rowsCells[m][n].x ==
                        pitchslot.months![0]!.days![i]!.slots![j]!.startTime &&
                    rowsCells[m][n].y ==
                        pitchslot.months![0]!.days![i]!.dayNumber) {
                  if (pitchslot.months![0]!.days![i]!.slots![j]!.is_booked ==
                      false) {
                    if (pitchslot.months![0]!.days![i]!.slots![j]!
                            .slot_not_available ==
                        false) {
                      rowsCells[m][n].price = 1800;
                      rowsCells[m][n].id =
                          pitchslot.months![0]!.days![i]!.slots![j]!.id;
                    } else {
                      rowsCells[m][n].price = 1802;
                    }
                  } else {
                    rowsCells[m][n].price = 1700;
                  }
                } else {
                  if (rowsCells[m][n].price == 54) {
                    rowsCells[m][n].price = 54;
                  }
                }
              } else {
                if (rowsCells[m][n].x ==
                        pitchslot.months![0]!.days![i]!.slots![j]!.startTime &&
                    rowsCells[m][n].y ==
                        pitchslot.months![0]!.days![i]!.dayNumber) {
                  if (pitchslot.months![0]!.days![i]!.slots![j]!.is_booked ==
                      false) {
                    rowsCells[m][n].price = 1802;
                    rowsCells[m][n].id =
                        pitchslot.months![0]!.days![i]!.slots![j]!.id;
                  } else {
                    rowsCells[m][n].price = 1702;
                  }
                } else {
                  if (rowsCells[m][n].price == 54) {
                    rowsCells[m][n].price = 52;
                  }
                }
              }
            }
          }
        }
      }
    }
    if (month1 == 4 || month1 == 6 || month1 == 9 || month1 == 11) {
      for (int i = 0; i < pitchslot.months![0]!.days!.length; i++) {
        for (int j = 0;
            j < pitchslot.months![0]!.days![i]!.slots!.length;
            j++) {
          for (int m = 0; m < rowsCells1.length; m++) {
            for (int n = 0; n < rowsCells1[0].length; n++) {
              if (timeComparison(
                      currentTime: pitchslot.current_datetime.toString(),
                      year: _curentlySelectedItem,
                      month: _curentlySelectedItem1,
                      date: rowsCells1[m][n].y,
                      hour: rowsCells1[m][n].x.substring(0, 2)) ==
                  false) {
                if (rowsCells1[m][n].x ==
                        pitchslot.months![0]!.days![i]!.slots![j]!.startTime
                            .toString() &&
                    rowsCells1[m][n].y ==
                        pitchslot.months![0]!.days![i]!.dayNumber) {
                  if (pitchslot.months![0]!.days![i]!.slots![j]!.is_booked ==
                      false) {
                    if (pitchslot.months![0]!.days![i]!.slots![j]!
                            .slot_not_available ==
                        false) {
                      rowsCells1[m][n].price = 1800;
                      rowsCells1[m][n].id =
                          pitchslot.months![0]!.days![i]!.slots![j]!.id;
                    } else {
                      rowsCells1[m][n].price = 1802;
                    }
                  } else {
                    rowsCells1[m][n].price = 1700;
                  }
                } else {
                  if (rowsCells1[m][n].price == 54) {
                    rowsCells1[m][n].price = 54;
                  }
                }
              } else {
                if (rowsCells1[m][n].x ==
                        pitchslot.months![0]!.days![i]!.slots![j]!.startTime &&
                    rowsCells1[m][n].y ==
                        pitchslot.months![0]!.days![i]!.dayNumber) {
                  if (pitchslot.months![0]!.days![i]!.slots![j]!.is_booked ==
                      false) {
                    rowsCells1[m][n].price = 1802;
                    rowsCells1[m][n].id =
                        pitchslot.months![0]!.days![i]!.slots![j]!.id;
                  } else {
                    rowsCells1[m][n].price = 1702;
                  }
                } else {
                  if (rowsCells1[m][n].price == 54) {
                    rowsCells1[m][n].price = 52;
                  }
                }
              }
            }
          }
        }
      }
    }

    if (year2 && month1 == 2) {
      for (int i = 0; i < pitchslot.months![0]!.days!.length; i++) {
        for (int j = 0;
            j < pitchslot.months![0]!.days![i]!.slots!.length;
            j++) {
          for (int m = 0; m < rowsCells3.length; m++) {
            for (int n = 0; n < rowsCells3[0].length; n++) {
              if (timeComparison(
                      currentTime: pitchslot.current_datetime.toString(),
                      year: _curentlySelectedItem,
                      month: _curentlySelectedItem1,
                      date: rowsCells3[m][n].y,
                      hour: rowsCells3[m][n].x.substring(0, 2)) ==
                  false) {
                if (rowsCells3[m][n].x ==
                        pitchslot.months![0]!.days![i]!.slots![j]!.startTime &&
                    rowsCells3[m][n].y ==
                        pitchslot.months![0]!.days![i]!.dayNumber) {
                  if (pitchslot.months![0]!.days![i]!.slots![j]!.is_booked ==
                      false) {
                    if (pitchslot.months![0]!.days![i]!.slots![j]!
                            .slot_not_available ==
                        false) {
                      rowsCells3[m][n].price = 1800;
                      rowsCells3[m][n].id =
                          pitchslot.months![0]!.days![i]!.slots![j]!.id;
                    } else {
                      rowsCells3[m][n].price = 1802;
                    }
                  } else {
                    rowsCells3[m][n].price = 1700;
                  }
                } else {
                  if (rowsCells3[m][n].price == 54) {
                    rowsCells3[m][n].price = 54;
                  }
                }
              } else {
                if (rowsCells3[m][n].x ==
                        pitchslot.months![0]!.days![i]!.slots![j]!.startTime &&
                    rowsCells3[m][n].y ==
                        pitchslot.months![0]!.days![i]!.dayNumber) {
                  if (pitchslot.months![0]!.days![i]!.slots![j]!.is_booked ==
                      false) {
                    rowsCells3[m][n].price = 1802;
                    rowsCells3[m][n].id =
                        pitchslot.months![0]!.days![i]!.slots![j]!.id;
                  } else {
                    rowsCells3[m][n].price = 1702;
                  }
                } else {
                  if (rowsCells3[m][n].price == 54) {
                    rowsCells3[m][n].price = 52;
                  }
                }
              }
            }
          }
        }
      }
    }
    if (!year2 && month1 == 2) {
      for (int i = 0; i < pitchslot.months![0]!.days!.length; i++) {
        for (int j = 0;
            j < pitchslot.months![0]!.days![i]!.slots!.length;
            j++) {
          for (int m = 0; m < rowsCells2.length; m++) {
            for (int n = 0; n < rowsCells2[0].length; n++) {
              if (timeComparison(
                      currentTime: pitchslot.current_datetime.toString(),
                      year: _curentlySelectedItem,
                      month: _curentlySelectedItem1,
                      date: rowsCells2[m][n].y,
                      hour: rowsCells2[m][n].x.substring(0, 2)) ==
                  false) {
                if (rowsCells2[m][n].x ==
                        pitchslot.months![0]!.days![i]!.slots![j]!.startTime &&
                    rowsCells2[m][n].y ==
                        pitchslot.months![0]!.days![i]!.dayNumber) {
                  if (pitchslot.months![0]!.days![i]!.slots![j]!.is_booked ==
                      false) {
                    if (pitchslot.months![0]!.days![i]!.slots![j]!
                            .slot_not_available ==
                        false) {
                      rowsCells2[m][n].price = 1800;
                      rowsCells2[m][n].id =
                          pitchslot.months![0]!.days![i]!.slots![j]!.id;
                    } else {
                      rowsCells2[m][n].price = 1802;
                    }
                  } else {
                    rowsCells2[m][n].price = 1700;
                  }
                } else {
                  if (rowsCells2[m][n].price == 54) {
                    rowsCells2[m][n].price = 54;
                  }
                }
              } else {
                if (rowsCells2[m][n].x ==
                        pitchslot.months![0]!.days![i]!.slots![j]!.startTime &&
                    rowsCells2[m][n].y ==
                        pitchslot.months![0]!.days![i]!.dayNumber) {
                  if (pitchslot.months![0]!.days![i]!.slots![j]!.is_booked ==
                      false) {
                    rowsCells2[m][n].price = 1802;
                    rowsCells2[m][n].id =
                        pitchslot.months![0]!.days![i]!.slots![j]!.id;
                  } else {
                    rowsCells2[m][n].price = 1702;
                  }
                } else {
                  if (rowsCells2[m][n].price == 54) {
                    rowsCells2[m][n].price = 52;
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  cellDataChangesempty() {
    bool year2 = leapYear();
    int month1 = monthFind(index: month ?? 'January');
    if (month1 == 1 ||
        month1 == 3 ||
        month1 == 5 ||
        month1 == 7 ||
        month1 == 8 ||
        month1 == 10 ||
        month1 == 12) {
      for (int m = 0; m < rowsCells.length; m++) {
        for (int n = 0; n < rowsCells[0].length; n++) {
          rowsCells[m][n].price = 54;
          rowsCells[m][n].select = false;
        }
      }
    }

    if (month1 == 4 || month1 == 6 || month1 == 9 || month1 == 11) {
      for (int m = 0; m < rowsCells1.length; m++) {
        for (int n = 0; n < rowsCells1[0].length; n++) {
          rowsCells1[m][n].price = 54;
          rowsCells1[m][n].select = false;
        }
      }
    }

    if (year2 && month1 == 2) {
      for (int m = 0; m < rowsCells3.length; m++) {
        for (int n = 0; n < rowsCells3[0].length; n++) {
          rowsCells3[m][n].price = 54;
          rowsCells3[m][n].select = false;
        }
      }
    }

    if (!year2 && month1 == 2) {
      for (int m = 0; m < rowsCells2.length; m++) {
        for (int n = 0; n < rowsCells2[0].length; n++) {
          rowsCells2[m][n].price = 54;
          rowsCells2[m][n].select = false;
        }
      }
    }
  }

  bool timeComparison(
      {String? currentTime,
      String? year,
      String? month,
      int? date,
      String? hour}) {
    var now1 = DateTime(
        int.parse(year!), monthFind(index: month!), date!, int.parse(hour!));
    var now = DateTime.parse(currentTime!);

    DateTime DaysAgo = now.add(const Duration(hours: 4, minutes: 10));
    bool slot = now1.isBefore(DaysAgo);
    return slot;
  }
}

class CellData {
  var id;
  var x;
  var y;
  bool select = false;
  var price;

  CellData({this.x, this.y, this.price, this.id});
}

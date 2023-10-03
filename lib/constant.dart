library constatnt;

import 'package:flutter/material.dart';

const kGoogleApiKey = "AIzaSyAFKs1KhSVbpFuG_W9gSDLeMqD9kIsA8j4";
const List<String> facilitySlug = [
  "bathroom",
  "bibs",
  "car-parking",
  "locker",
  "train-station",
  "refree",
  "parking-free",
  "mosque",
  "market",
];
const List<String> genderEn = ["Male", "Female"];
const List<String> genderAr = ["ذكر", "أنثى"];
const List<String> facility = [
  "Bathroom",
  "Bibs",
  "Car Parking",
  "Locker",
  "Metro Station",
  "Refree",
  "Free Parking",
  "Mosque",
  "Market",
];
const List<String> facilityAr = [
  "حمام",
  "كفرات",
  "موقف سيارات",
  "خزانة",
  "محطة مترو",
  "حكم",
  "موقف سيارات مجاني",
  "مسجد",
  "دكان",
];
const List<String> facilityImage = [
  "assets/images/bathtub.png",
  "assets/images/lock.png",
  "assets/images/car.png",
  "assets/images/lockerRoom.png",
  "assets/images/train.png",
  "assets/images/referee.png",
  "assets/images/parking.png",
  "assets/images/mosque.png",
  "assets/images/market.png",
];
const List<String> facilityImageS = [
  "assets/images/bathtubColor.png",
  "assets/images/lockColor.png",
  "assets/images/carColor.png",
  "assets/images/lockerColor.png",
  "assets/images/trainColor.png",
  "assets/images/refereeColor.png",
  "assets/images/parkingColor.png",
  "assets/images/mosqueColor.png",
  "assets/images/marketColor.png",
];
const List<int> facilityId = [28, 27, 26, 25, 24, 23, 22, 21, 20];
final List<String> imgList = [
  'assets/images/T.png',
  'assets/images/placeHolder.png',
];
int monthFind({required String index}) {
  int day;
  switch (index) {
    case "January":
      day = 1;
      break;

    case "February":
      day = 2;
      break;

    case "March":
      day = 3;
      break;

    case "April":
      day = 4;
      break;
    case "May":
      day = 5;
      break;

    case "June":
      day = 6;
      break;
    case "July":
      day = 7;
      break;

    case "August":
      day = 8;
      break;

    case "September":
      day = 9;
      break;
    case "October":
      day = 10;
      break;
    case "November":
      day = 11;
      break;
    default:
      day = 12;
      break;
  }
  return day;
}

String monthFindRevers({required int index}) {
  switch (index) {
    case 1:
      return "January";
      break;

    case 2:
      return "February";
      break;

    case 3:
      return "March";
      break;

    case 4:
      return "April";
      break;
    case 5:
      return "May";
      break;

    case 6:
      return "June";
      break;
    case 7:
      return "July";
      break;

    case 8:
      return "August";
      break;

    case 9:
      return "September";
      break;

    case 10:
      return "October";
      break;

    case 11:
      return "November";
      break;

    default:
      return "December";
      break;
  }
}

String monthFindReversAr({required int index}) {
  switch (index) {
    case 1:
      return "يناير";
      break;

    case 2:
      return "فبراير";
      break;

    case 3:
      return "مارس";
      break;

    case 4:
      return "أبريل";
      break;
    case 5:
      return "مايو";
      break;

    case 6:
      return "يونيو";
      break;
    case 7:
      return "يوليو";
      break;

    case 8:
      return "أغسطس";
      break;

    case 9:
      return "سبتمبر";
      break;

    case 10:
      return "أكتوبر";
      break;

    case 11:
      return "نوفمبر";
      break;

    default:
      return "ديسمبر";
      break;
  }
}

String timing({required int x}) {
  String day;
  switch (x) {
    case 0:
      day = "12 AM";
      break;
    case 1:
      day = "1 AM";
      break;
    case 2:
      day = "2 AM";
      break;
    case 3:
      day = "3 AM";
      break;
    case 4:
      day = "4 AM";
      break;
    case 5:
      day = "5 AM";
      break;
    case 6:
      day = "6 AM";
      break;
    case 7:
      day = "7 AM";
      break;
    case 8:
      day = "8 AM";
      break;
    case 9:
      day = "9 AM";
      break;
    case 10:
      day = "10 AM";
      break;
    case 11:
      day = "11 AM";
      break;
    case 12:
      day = "12 PM";
      break;
    case 13:
      day = "1 PM";
      break;
    case 14:
      day = "2 PM";
      break;
    case 15:
      day = "3 PM";
      break;
    case 16:
      day = "4 PM";
      break;
    case 17:
      day = "5 PM";
      break;
    case 18:
      day = "6 PM";
      break;
    case 19:
      day = "7 PM";
      break;
    case 20:
      day = "8 PM";
      break;
    case 21:
      day = "9 PM";
      break;
    case 22:
      day = "10 PM";
      break;
    default:
      day = "11 PM";
      break;
  }
  return day;
}

////
const appThemeColor = Color(0XFF032040);
const double appHeaderFont = 20;
int? count;

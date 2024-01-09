import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/manageSlotScreens/academy_detail.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/bookAcademyScreens/enterYourDetailAcademy.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/editProfile.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/profileDetail.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/login.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/verification.dart';

import '../homeFile/association_promotion.dart';
import '../homeFile/routingConstant.dart';
import '../homeFile/specific_promotion_screen.dart';
import '../homeFile/specific_sports_venue_screen.dart';
import '../main.dart';
import '../modelClass/bookPitchModelClass.dart';
import '../modelClass/pramotion_model_class.dart';
import '../modelClass/teamModelClass.dart';
import '../modelClass/yourTahaddiModelClass.dart';
import '../newStructure/view/owner/home_screens/home_page/academy_detail_screen2.dart';
import '../newStructure/view/owner/home_screens/home_page/select_sport0.dart';
import '../newStructure/view/player/HomeScreen/Home/groundDetail/bookAcademyScreens/BookingScreen.dart';
import '../newStructure/view/player/HomeScreen/NotificationScreenBoth/notification.dart';
import '../player/bookPitch/venueDetail.dart';
import '../player/loginSignup/forgotPassword.dart';
import '../player/loginSignup/payment/bookingSummary.dart';
import '../player/loginSignup/payment/payment.dart';
import '../player/loginSignup/payment/sucsessfulPayment.dart';
import '../player/loginSignup/preferred_sports.dart';
import '../player/loginSignup/profile/myInterest.dart';
import '../player/loginSignup/profile/rating.dart';
import '../player/loginSignup/socialdetail.dart';
import 'accountSetting.dart';
import 'chooseAccount.dart';
import 'permission_priming.dart';

class RouterPage {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.payment:
        var price = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => Payment(detail: settings.arguments as List<Map>));
      case RouteNames.languageSave:
        return MaterialPageRoute(builder: (context) => const LanguageSave());

      ///
      ///
      ///
      case RouteNames.groundDetail:
        return MaterialPageRoute(
          builder: (context) => GroundDetail(detail: settings.arguments as Map),
        );
      case RouteNames.bookingScreen:
        return MaterialPageRoute(
          builder: (context) =>
              PlayerBookingScreenView(detail: settings.arguments),
        );
      case RouteNames.verificationScreen:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => VerificationScreen(
                  detail: detail as SignUpSignInDetail,
                ));
      case RouteNames.editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      // case addCard:
      //   var price = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => AddCard(
      //             price: price,
      //           ));
      // case paymentMethod:
      //   var price = settings.arguments;
      //   return MaterialPageRoute(
      //       builder: (_) => PaymentMethod(
      //             price: price,
      //           ));
      case RouteNames.bookingSummary:
        var price = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BookingSummary(price: price as List<Map>));
      case RouteNames.forgotPassword:
        var tokenstatus = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ForgotPassword(
                  tokenStatus: false,
                ));
      case RouteNames.profileDetail:
        return MaterialPageRoute(
            builder: (BuildContext context) => ProfileDetailScreen());
      case RouteNames.searchBar:
        return MaterialPageRoute(builder: (_) => const SearchBar());
      case RouteNames.notificationScreen:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case RouteNames.socialDetail:
        var msg = settings.arguments;
        return MaterialPageRoute(builder: (_) => SocialDetail(detail: msg));
      case RouteNames.chooseAccount:
        return MaterialPageRoute(builder: (_) => const ChooseAccount());
      case RouteNames.paymentSuccess:
        var price = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => PaymentSuccess(
                  price: price as List<Map>,
                ));
      case RouteNames.rate:
        return MaterialPageRoute(builder: (_) => const Rate());
      case RouteNames.pitchDetail:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => AcademyDetailScreen(detail: detail as SportsModel));


      case RouteNames.enterDetailAcademy:
        var deatil = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                EnterDetailAcademyScreen(detail: deatil as List<Map>));
      case RouteNames.myInterest:
        return MaterialPageRoute(builder: (_) => const MyInterest());
      case RouteNames.accountSetting:
        return MaterialPageRoute(builder: (_) => const AccountSetting());
      case RouteNames.selectSport:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => SelectSportScreen(
                  isBack: detail as bool,
                ));

      ///
      case RouteNames.preferredSports:
        return MaterialPageRoute(builder: (_) => const PreferredSports());
      case RouteNames.sportExperience:
      case RouteNames.editAcademyDetail:
        return MaterialPageRoute(
            builder: (_) => EditAcademyDetailScreen(
                  detail: settings.arguments,
                ));
      case RouteNames.venueDetailScreen:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => VenueDetailScreen(
                  detail: detail as Map,
                ));
      case RouteNames.specificSportsScreen:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => SpecificSportsScreen(
                  detail: detail as Map,
                ));
      case RouteNames.specificPromotionScreen:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => SpecificPromotionScreen(id: detail.toString()));
      case RouteNames.associationPromotion:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                AssociationPromotion(detail: detail as PromotionModelClass));
      case RouteNames.permissionPriming:
        return MaterialPageRoute(
            builder: (_) => const PermissionPrimingScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/profileDetail.dart';

import '../homeFile/association_promotion.dart';
import '../homeFile/routingConstant.dart';
import '../homeFile/select_your_location.dart';
import '../homeFile/specific_promotion_screen.dart';
import '../homeFile/specific_sports_venue_screen.dart';
import '../main.dart';
import '../modelClass/bookPitchModelClass.dart';
import '../modelClass/bookingModelClass.dart';
import '../modelClass/my_venue_list_model_class.dart';
import '../modelClass/pramotion_model_class.dart';
import '../modelClass/teamModelClass.dart';
import '../modelClass/yourTahaddiModelClass.dart';
import '../pitchOwner/addNewPitch/addNewGround.dart';
import '../pitchOwner/addNewPitch/addNewGroundSecond.dart';
import '../pitchOwner/bookingPitchOwner/closingHour.dart';
import '../pitchOwner/bookingPitchOwner/manageSlotsDetail.dart';
import '../pitchOwner/bookingPitchOwner/pitchBookingDetails.dart';
import '../pitchOwner/bookingPitchOwner/verifiedPitchDetail.dart';
import '../pitchOwner/createEvents/createEventFirst.dart';
import '../pitchOwner/createEvents/createEventSecond.dart';
import '../pitchOwner/homePitchOwner/eventDetailOwner.dart';
import '../pitchOwner/homePitchOwner/homePitchOwner.dart';
import '../pitchOwner/homePitchOwner/ragisterTeam.dart';
import '../pitchOwner/homePitchOwner/viewMoreOwner.dart';
import '../pitchOwner/homePitchOwner/view_more_venue.dart';
import '../pitchOwner/loginSignupPitchOwner/bankDetail.dart';
import '../pitchOwner/loginSignupPitchOwner/createSession.dart';
import '../pitchOwner/loginSignupPitchOwner/documents.dart';
import '../pitchOwner/loginSignupPitchOwner/pitchDetail.dart';
import '../pitchOwner/loginSignupPitchOwner/price_screen.dart';
import '../pitchOwner/loginSignupPitchOwner/select_sport.dart';
import '../pitchOwner/loginSignupPitchOwner/signUpPitchOwner.dart';
import '../pitchOwner/loginSignupPitchOwner/slot_chart.dart';
import '../pitchOwner/loginSignupPitchOwner/venue_created.dart';
import '../pitchOwner/loginSignupPitchOwner/verifyNumber.dart';
import '../pitchOwner/profilePitchOwner/account.dart';
import '../pitchOwner/profilePitchOwner/editProfilePitchOwner.dart';
import '../pitchOwner/profilePitchOwner/myPitches/editPitch.dart';
import '../pitchOwner/profilePitchOwner/myPitches/editSessions.dart';
import '../pitchOwner/profilePitchOwner/myPitches/edit_pitch_detail.dart';
import '../pitchOwner/profilePitchOwner/myPitches/edit_venue.dart';
import '../pitchOwner/profilePitchOwner/myPitches/myPitches.dart';
import '../pitchOwner/profilePitchOwner/myPitches/my_venues.dart';
import '../pitchOwner/profilePitchOwner/myPitches/rejectPitch.dart';
import '../player/bookPitch/bookPitch.dart';
import '../player/bookPitch/bookPitchSlot.dart';
import '../player/bookPitch/bookPitchYourTahaddi.dart';
import '../player/bookPitch/enterYourDetailPitch.dart';
import '../player/bookPitch/venueDetail.dart';
import '../player/bookPitch/viewMoreBookPitch.dart';
import '../player/league/enterDetail.dart';
import '../player/league/league.dart';
import '../player/league/tahaddiLeague.dart';
import '../player/league/viewMore.dart';
import '../player/league/viewMoreTournament.dart';
import '../player/loginSignup/forgotPassword.dart';
import '../player/loginSignup/forgotPasswordscreen.dart';
import '../player/loginSignup/loginPage.dart';
import '../player/loginSignup/payment/bookingSummary.dart';
import '../player/loginSignup/payment/payment.dart';
import '../player/loginSignup/payment/sucsessfulPayment.dart';
import '../player/loginSignup/preferred_sports.dart';
import '../player/loginSignup/profile/editProfile.dart';
import '../player/loginSignup/profile/myBookings.dart';
import '../player/loginSignup/profile/myInterest.dart';
import '../player/loginSignup/profile/rating.dart';
import '../player/loginSignup/profile/resetPassword.dart';
import '../player/loginSignup/profile/resetPasswordSucess.dart';
import '../player/loginSignup/profile/resetPasswordlottie.dart';
import '../player/loginSignup/signup.dart';
import '../player/loginSignup/socialdetail.dart';
import '../player/loginSignup/sport_experience.dart';
import '../player/loginSignup/team/addPlayer.dart';
import '../player/loginSignup/team/createTeam.dart';
import '../player/loginSignup/team/emptyTeam.dart';
import '../player/loginSignup/team/enterDetailJoinTeam.dart';
import '../player/loginSignup/team/joinTeam.dart';
import '../player/loginSignup/team/teamViewMore.dart';
import '../player/loginSignup/varification.dart';
import 'accountSetting.dart';
import 'chooseAccount.dart';
import 'permission_priming.dart';

class RouterPage {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeRoute:
        return MaterialPageRoute(
            builder: (_) =>
                PlayerHome(
                  index: 0,
                ));
      case RouteNames.playerHome:
        return MaterialPageRoute(
            builder: (_) =>
                PlayerHome(
                  index: 0,
                ));
      case RouteNames.league:
        var leageData = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                League(
                  eventData: leageData as Map,
                ));
      case RouteNames.enterYourDetail:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                EnterDetail(
                  leagueData: detail,
                ));
      case RouteNames.payment:
        var price = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                Payment(
                  detail: settings.arguments,
                ));
      case RouteNames.languageSave:
        return MaterialPageRoute(builder: (context) => const LanguageSave());
      case RouteNames.groundDetail:
        return MaterialPageRoute(builder: (context) =>
            GroundDetail(detail: settings.arguments as Map),);
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
        return MaterialPageRoute(builder: (_) => BookingSummary(price: price));
      case RouteNames.bookPitch:
        var pitchData = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                BookPitch(
                  pitchDetail: pitchData as int,
                ));
      case RouteNames.bookPitchSlot:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                BookPitchSlots(
                  id: detail,
                ));
      case RouteNames.editSession:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                EditSession(
                  pitchData: detail as Map,
                ));
      case RouteNames.signupPage:
        return MaterialPageRoute(builder: (_) => SignupPage());
      case RouteNames.varification:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                Verification(
                  detail: detail as SignUpDetail,
                ));
      case RouteNames.passworSuccess:
        return MaterialPageRoute(builder: (_) => PassworSuccess());
      case RouteNames.editProfile:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case RouteNames.forgotPassword:
        var tokenstatus = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                ForgotPassword(
                  tokenStatus: false,
                ));
      case RouteNames.forgotPasswordScreen:
        var token = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                ForgotPasswordScreen(
                  token: token.toString(),
                ));
      case RouteNames.profileDetail:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileDetailScreen());
      case RouteNames.more:
        return MaterialPageRoute(
            builder: (_) =>
                PlayerHome(
                  index: 3,
                ));
      case RouteNames.team:
        return MaterialPageRoute(builder: (_) => PlayerHome(index: 1));
      case RouteNames.searchBar:
        return MaterialPageRoute(builder: (_) => const SearchBar());
      case RouteNames.notification:
        return MaterialPageRoute(
            builder: (_) =>
                PlayerHome(
                  index: 1,
                ));
      case RouteNames.emptyProfile:
        return MaterialPageRoute(
            builder: (_) =>
                PlayerHome(
                  index: 2,
                ));
      case RouteNames.login:
        var msg = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                Loginpage(
                  message: msg.toString(),
                ));
      case RouteNames.resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case RouteNames.socialDetail:
        var msg = settings.arguments;
        return MaterialPageRoute(builder: (_) => SocialDetail(detail: msg));
      case RouteNames.chooseAccount:
        return MaterialPageRoute(builder: (_) => const ChooseAccount());
      case RouteNames.signUpPitchOwner:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
    // case editCard:
    //   var price = settings.arguments;
    //   return MaterialPageRoute(
    //       builder: (_) => EditCard(
    //             detail: price,
    //           ));
      case RouteNames.addPlayer:
        return MaterialPageRoute(
            builder: (_) =>
                AddPlayer(
                  index: 0,
                ));
      case RouteNames.createTeam:
        return MaterialPageRoute(builder: (_) => CreateTeam());
      case RouteNames.paymentSuccess:
        var price = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                PaymentSuccess(
                  price: price,
                ));
      case RouteNames.resetPasswordSuccess:
        var msg = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                ResetPasswordSuccess(
                  msg: msg,
                ));
      case RouteNames.viewMore:
        var msg = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                ViewMoreLeague(
                  leagueType: msg as Map,
                ));
      case RouteNames.viewMoreTournament:
        var msg = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                ViewMoreTournament(
                  tournamentType: msg as Map,
                ));
      case RouteNames.viewMoreBookPitch:
        var msg = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                ViewMoreBookPitch(
                  pitchType: msg as Map,
                ));
      case RouteNames.myBookings:
        return MaterialPageRoute(builder: (_) => MyBookings());
      case RouteNames.rate:
        return MaterialPageRoute(builder: (_) => Rate());
      case RouteNames.bankDetail:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BankDetail(detail: detail as Map));
      case RouteNames.pitchDetail:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => PitchDetail(detail: detail as SportsModel));
      case RouteNames.viewMoreowner:
        var event = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                ViewMoreowner(
                  eventType: event.toString(),
                ));
      case RouteNames.varifyMoblie:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => VarifyMoblie(detail: detail as SignUpDetail));
      case RouteNames.createEventFirst:
        var event = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => CreateEventFirst(event: event.toString()));
      case RouteNames.createEventSecond:
        var event = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => CreateEventSecond(event: event as Map));
      case RouteNames.documents:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => Documents(detail: detail as SportsModel));
      case RouteNames.homePitchOwner:
        var index = settings.arguments ?? 0;
        return MaterialPageRoute(
            builder: (_) => HomePitchOwner(index: index as int));
      case RouteNames.myPitches:
        var index = settings.arguments ?? 1;
        return MaterialPageRoute(
            builder: (_) =>
                MyPitches(
                  index: index as int,
                ));
      case RouteNames.manageSlotsDetail:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                ManageSlotsDetail(pitchDetail: detail as BookPitchDetail));
      case RouteNames.eventDetailOwner:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                EventDetailOwner(
                  id: detail as Map,
                ));

      case RouteNames.editProfilePitchOwner:
        return MaterialPageRoute(builder: (_) => EditProfilePitchOwner());
      case RouteNames.teamEmpaty:
        return MaterialPageRoute(builder: (_) => TeamEmpaty());
      case RouteNames.closingHour:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ClosingHour(detail: detail as Map));
      case RouteNames.addNewGroundFirst:
        return MaterialPageRoute(builder: (_) => AddNewGroundFirst());
      case RouteNames.enterDetailJoinTeam:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                EnterDetailJoinTeam(teamDeatail: detail as TeamModelClass));
      case RouteNames.joinTeam:
        var deatil = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => JoinTeam(detailTeam: deatil as TeamModelClass));
      case RouteNames.registerTeam:
        var deatil = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => RegisterTeam(detail: deatil as List));
      case RouteNames.addNewGroundSecond:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                AddNewGroundSecond(
                  detail: detail as Map,
                ));

      case RouteNames.editPitch:
        var deatil = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => EditPitch(pitchDetail: deatil as Map));
      case RouteNames.rejectPitch:
        var deatil = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => RejectPitch(pitchDetail: deatil as Map));
      case RouteNames.enterDetailPitch:
        var deatil = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => EnterDetailPitch(detail: deatil));
      case RouteNames.verifiedPitchDetail:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                VerifiedPitchDetail(
                  pitchDetail: detail as Map,
                ));

    // case savePayment:
    //   return MaterialPageRoute(builder: (_) => SavePayment());
      case RouteNames.myInterest:
        return MaterialPageRoute(builder: (_) => MyInterest());
      case RouteNames.account:
        return MaterialPageRoute(builder: (_) => Account());
      case RouteNames.accountSetting:
        return MaterialPageRoute(builder: (_) => AccountSetting());
      case RouteNames.pitchBookingDetails:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                PitchBookingDetails(
                    bookindDetail: detail as BookingModelClass));
      case RouteNames.leagueTahaddi:
        var leageData = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                LeagueTahaddi(
                  leaguedata: leageData as Map,
                ));
      case RouteNames.bookPitchTahaddi:
        var bookPitchData = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                BookPitchYourTahaddi(
                  bookpitch: bookPitchData as YourTahaddi,
                ));
      case RouteNames.selectSport:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                SelectSport(
                  isBack: detail as bool,
                ));
      case RouteNames.priceScreen:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => PriceScreen(detail: detail as SportsModel));
      case RouteNames.createSession:
        var pitchData = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                CreateSession(
                  pitchData: pitchData as Map,
                ));
      case RouteNames.slotChart:
        var pitchId = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => SlotChart(pitchDetail: pitchId as Map));
      case RouteNames.myVenues:
        return MaterialPageRoute(builder: (_) => MyVenues());
      case RouteNames.editVenues:
        var id = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                EditVenues(
                  detail: id as Map,
                ));
      case RouteNames.venueCreated:
        return MaterialPageRoute(builder: (_) => const VenueCreated());
      case RouteNames.viewMoreTeam:
        return MaterialPageRoute(builder: (_) => ViewMoreTeam());
      case RouteNames.preferredSports:
        return MaterialPageRoute(builder: (_) => const PreferredSports());
      case RouteNames.sportExperience:
        return MaterialPageRoute(builder: (_) => const SportExperience());
      case RouteNames.editPitchDetail:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                EditPitchDetail(
                  detail: detail,
                ));
      case RouteNames.venueDetailScreen:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                VenueDetailScreen(
                  detail: detail as Map,
                ));
      case RouteNames.specificSportsScreen:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                SpecificSportsScreen(
                  detail: detail as Map,
                ));
      case RouteNames.viewMoreVenue:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                ViewMoreVenue(venues: detail as List<MyVenueModelClass>));
      case RouteNames.specificPromotionScreen:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => SpecificPromotionScreen(id: detail.toString()));
      case RouteNames.associationPromotion:
        var detail = settings.arguments;
        return MaterialPageRoute(
            builder: (_) =>
                AssociationPromotion(detail: detail as PromotionModelClass));
      case RouteNames.selectLocation:
        return MaterialPageRoute(builder: (_) => SelectYourLocation());
      case RouteNames.permissionPriming:
        return MaterialPageRoute(builder: (_) => PermissionPrimingScreen());

      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

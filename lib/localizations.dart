import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  String get locale {
    return Intl.message('en', name: 'locale');
  }

  String get league {
    return Intl.message('league', name: 'league');
  }

  String get tournament {
    return Intl.message('tournament', name: 'tournament');
  }

  String get bookPitch {
    return Intl.message('bookPitch', name: 'bookPitch');
  }

  String get team {
    return Intl.message('team', name: 'team');
  }

  String get popular {
    return Intl.message('Our Popular Features', name: 'popular');
  }

  String get groundList {
    return Intl.message('Ground List', name: 'groundList');
  }

  String get teamH {
    return Intl.message('teamH', name: 'teamH');
  }

  String get legal {
    return Intl.message('Legal Information', name: 'legalInformation');
  }

  String get nameEmail {
    return Intl.message('name, email, phone, location', name: 'name,email');
  }

  String get yourInterest {
    return Intl.message('Your Interest', name: 'yourInterest');
  }

  String get yourProfile {
    return Intl.message('Your profile', name: 'yourProfile');
  }

  String get eventTitle {
    return Intl.message('Events', name: 'eventTitle');
  }

  String get academy {
    return Intl.message('Academies', name: 'academy');
  }

  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode');
  }

  String get bookingVenue {
    return Intl.message('Booking, Venues, leagues', name: 'booking,venue');
  }

  String get languageTheme {
    return Intl.message('language, theme, configuration',
        name: 'language,theme');
  }

  String get help {
    return Intl.message('Help', name: 'Help');
  }

  String get game {
    return Intl.message('game', name: 'game');
  }

  String get sendMessage {
    return Intl.message('sendMessage', name: 'sendMessage');
  }

  String get challengeTeam {
    return Intl.message('challengeTeam', name: 'challengeTeam');
  }

  String get createTeamC {
    return Intl.message('createTeamC', name: 'createTeamC');
  }

  String get viewMore {
    return Intl.message('viewMore', name: 'viewMore');
  }

  String get notification {
    return Intl.message('notification', name: 'notification');
  }

  String get more {
    return Intl.message('more', name: 'more');
  }

  String get profile {
    return Intl.message('profile', name: 'profile');
  }

  String get profileC {
    return Intl.message('profileC', name: 'profileC');
  }

  String get notificationDec {
    return Intl.message('notificationDec', name: 'notificationDec');
  }

  String get profileDec {
    return Intl.message('profileDec', name: 'profileDec');
  }

  String get profileDecfirst {
    return Intl.message('profileDecfirst', name: 'profileDecfirst');
  }

  String get profileDecsecond {
    return Intl.message('notificationDec', name: 'profileDecsecond');
  }

  String get signIn {
    return Intl.message('signIn', name: 'signIn');
  }

  String get addYourFavorite {
    return Intl.message('Add Your Favorite', name: 'addYourFavorite');
  }

  String get signUp {
    return Intl.message('signUp', name: 'signUp');
  }

  String get tahaddi {
    return Intl.message('tahaddi', name: 'tahaddi');
  }

  String get morning {
    return Intl.message('Good Morning', name: 'morning');
  }

  String get login {
    return Intl.message('login', name: 'login');
  }

  String get refer {
    return Intl.message('refer', name: 'refer');
  }

  String get rateApp {
    return Intl.message('rateApp', name: 'rateApp');
  }

  String get contectUs {
    return Intl.message('contectUs', name: 'contectUs');
  }

  String get setting {
    return Intl.message('setting', name: 'setting');
  }

  String get email {
    return Intl.message('email', name: 'email');
  }

  String get password {
    return Intl.message('password', name: 'password');
  }

  String get forgotPassword {
    return Intl.message('forgotPassword', name: 'forgotPassword');
  }

  String get chooseLocation {
    return Intl.message('chooseLocation', name: 'chooseLocation');
  }

  String get location {
    return Intl.message('location', name: 'location');
  }

  String get getDirection {
    return Intl.message('getDirection', name: 'getDirection');
  }

  String get bookingGround {
    return Intl.message('Booking a Academy', name: 'bookAcademy');
  }

  String get dateTime {
    return Intl.message('dateTime', name: 'dateTime');
  }

  String get start {
    return Intl.message('start', name: 'start');
  }

  String get end {
    return Intl.message('end', name: 'end');
  }

  String get description {
    return Intl.message('description', name: 'description');
  }

  String get ratepitchafteryourgame {
    return Intl.message('ratepitchafteryourgame',
        name: 'ratepitchafteryourgame');
  }

  String get addpitchtoyourfavorites {
    return Intl.message('addpitchtoyourfavorites',
        name: 'addpitchtoyourfavorites');
  }

  String get youarefacinganyissuespleaseemailuson {
    return Intl.message('youarefacinganyissuespleaseemailuson',
        name: 'youarefacinganyissuespleaseemailuson');
  }

  String get organisedby {
    return Intl.message('organisedby', name: 'organisedby');
  }

  String get youarelongermemberteam {
    return Intl.message('youarelongermemberteam',
        name: 'youarelongermemberteam');
  }

  String get bookNow {
    return Intl.message('bookNow', name: 'bookNow');
  }

  String get onwords {
    return Intl.message('onwords', name: 'onwords');
  }

  String get addto {
    return Intl.message('addto', name: 'addto');
  }

  String get calendar {
    return Intl.message('calendar', name: 'calendar');
  }

  String get proceed {
    return Intl.message('proceed', name: 'proceed');
  }

  String get selectPaymentMethod {
    return Intl.message('selectPaymentMethod', name: 'selectPaymentMethod');
  }

  String get credit {
    return Intl.message('credit', name: 'credit');
  }

  String get wallets {
    return Intl.message('wallets', name: 'wallets');
  }

  String get addNewCard {
    return Intl.message('addNewCard', name: 'addNewCard');
  }

  String get needcreateaccountorlogin {
    return Intl.message('needcreateaccountorlogin',
        name: 'needcreateaccountorlogin');
  }

  String get cardNumber {
    return Intl.message('cardNumber', name: 'cardNumber');
  }

  String get cardHolderNumber {
    return Intl.message('cardHolderNumber', name: 'cardHolderNumber');
  }

  String get expriyDate {
    return Intl.message('expriyDate', name: 'expriyDate');
  }

  String get securelySave {
    return Intl.message('securelySave', name: 'securelySave');
  }

  String get nameOnCard {
    return Intl.message('nameOnCard', name: 'nameOnCard');
  }

  String get validity {
    return Intl.message('validity', name: 'validity');
  }

  String get remove {
    return Intl.message('remove', name: 'remove');
  }

  String get payment {
    return Intl.message('payment', name: 'payment');
  }

  String get enterYourDetails {
    return Intl.message('enterYourDetails', name: 'enterYourDetails');
  }

  String get captain {
    return Intl.message('captain', name: 'captain');
  }

  String get bookingUser {
    return Intl.message('bookingUser', name: 'bookingUser');
  }

  String get applyCoupon {
    return Intl.message('applyCoupon', name: 'applyCoupon');
  }

  String get paymentSummary {
    return Intl.message('paymentSummary', name: 'paymentSummary');
  }

  String get subTotal {
    return Intl.message('subTotal', name: 'subTotal');
  }

  String get tex {
    return Intl.message('tex', name: 'tex');
  }

  String get all {
    return Intl.message('all', name: 'all');
  }

  String get teamC {
    return Intl.message('teamC', name: 'teamC');
  }

  String get grandTotal {
    return Intl.message('grandTotal', name: 'grandTotal');
  }

  String get iAgree {
    return Intl.message('iAgree', name: 'iAgree');
  }

  String get term {
    return Intl.message('term', name: 'term');
  }

  String get ofCompany {
    return Intl.message('ofCompany', name: 'ofCompany');
  }

  String get bookingSummary {
    return Intl.message('bookingSummary', name: 'bookingSummary');
  }

  String get paymentSuccessful {
    return Intl.message('paymentSuccessful', name: 'paymentSuccessful');
  }

  String get personalDetail {
    return Intl.message('personalDetail', name: 'personalDetail');
  }

  String get myInterest {
    return Intl.message('myInterest', name: 'myInterest');
  }

  String get myBooking {
    return Intl.message('myBooking', name: 'myBooking');
  }

  String get savePaymentMethod {
    return Intl.message('savePaymentMethod', name: 'savePaymentMethod');
  }

  String get resetPassword {
    return Intl.message('resetPassword', name: 'resetPassword');
  }

  String get logout {
    return Intl.message('logout', name: 'logout');
  }

  String get viewsavePaymentMethod {
    return Intl.message('viewsavePaymentMethod', name: 'viewsavePaymentMethod');
  }

  String get viewbook {
    return Intl.message('viewbook', name: 'viewbook');
  }

  String get viewInterest {
    return Intl.message('viewInterest', name: 'viewInterest');
  }

  String get dateofBirth {
    return Intl.message('dateofBirth', name: 'dateofBirth');
  }

  String get currentpassword {
    return Intl.message('currentpassword', name: 'currentpassword');
  }

  String get support {
    return Intl.message('Support', name: 'support');
  }

  String get security {
    return Intl.message('Security', name: 'security');
  }

  String get newpassword {
    return Intl.message('newpassword', name: 'newpassword');
  }

  String get confermpassword {
    return Intl.message('confermpassword', name: 'confermpassword');
  }

  String get changepassword {
    return Intl.message('changepassword', name: 'changepassword');
  }

  String get sendEmail {
    return Intl.message('sendEmail', name: 'sendEmail');
  }

  String get createYourAccount {
    return Intl.message('createYourAccount', name: 'createYourAccount');
  }

  String get phoneNumber {
    return Intl.message('phoneNumber', name: 'phoneNumber');
  }

  String get lastName {
    return Intl.message('lastName', name: 'lastName');
  }

  String get firstName {
    return Intl.message('firstName', name: 'firstName');
  }

  String get language {
    return Intl.message('language', name: 'language');
  }

  String get verifyMobile {
    return Intl.message('verifyMobile', name: 'verifyMobile');
  }

  String get pleaseEnter {
    return Intl.message('pleaseEnter', name: 'pleaseEnter');
  }

  String get enterCode {
    return Intl.message('enterCode', name: 'enterCode');
  }

  String get resendOTP {
    return Intl.message('resendOTP', name: 'resendOTP');
  }

  String get verifyOTP {
    return Intl.message('verifyOTP', name: 'verifyOTP');
  }

  String get viewProfile {
    return Intl.message('viewProfile', name: 'viewProfile');
  }

  String get saveChanges {
    return Intl.message('saveChanges', name: 'saveChanges');
  }

  String get editProfile {
    return Intl.message('editProfile', name: 'editProfile');
  }

  String get changePhoto {
    return Intl.message('changePhoto', name: 'changePhoto');
  }

  String get search {
    return Intl.message('search', name: 'search');
  }

  String get indoor {
    return Intl.message('indoor', name: 'indoor');
  }

  String get outdoor {
    return Intl.message('outdoor', name: 'outdoor');
  }

  String get facility {
    return Intl.message('facility', name: 'facility');
  }

  String get asidePitch {
    return Intl.message('asidePitch', name: 'asidePitch');
  }

  String get filter {
    return Intl.message('filter', name: 'filter');
  }

  String get sports {
    return Intl.message('sports', name: 'sports');
  }

  String get pitch {
    return Intl.message('pitch', name: 'pitch');
  }

  String get notificationC {
    return Intl.message('notificationC', name: 'notificationC');
  }

  String get setPassword {
    return Intl.message('setPassword', name: 'setPassword');
  }

  String get pleaseEnterEmail {
    return Intl.message('pleaseEnterEmail', name: 'pleaseEnterEmail');
  }

  String get toReserve {
    return Intl.message('toReserve', name: 'toReserve');
  }

  String get yes {
    return Intl.message('yes', name: 'yes');
  }

  String get no {
    return Intl.message('no', name: 'no');
  }

  String get pinEntered {
    return Intl.message('pinEntered', name: 'pinEntered');
  }

  String get Pin {
    return Intl.message('Pin', name: 'Pin');
  }

  String get youHaveSuccessfully {
    return Intl.message('youHaveSuccessfully', name: 'youHaveSuccessfully');
  }

  String get cancel {
    return Intl.message('cancel', name: 'cancel');
  }

  String get canceled {
    return Intl.message('canceled', name: 'canceled');
  }

  String get lastDate {
    return Intl.message('lastDate', name: 'lastDate');
  }

  String get areYouSure {
    return Intl.message('areYouSure', name: 'areYouSure');
  }

  String get youGoingLogout {
    return Intl.message('youGoingLogout', name: 'youGoingLogout');
  }

  String get youGoingDeleteAccount {
    return Intl.message('youGoingDeleteAccount', name: 'youGoingDeleteAccount');
  }

  String get youGoingExit {
    return Intl.message('youGoingExit', name: 'youGoingExit');
  }

  String get createTeam {
    return Intl.message('createTeam', name: 'createTeam');
  }

  String get teamName {
    return Intl.message('teamName', name: 'teamName');
  }

  String get captainName {
    return Intl.message('captainName', name: 'captainName');
  }

  String get jerseyColor {
    return Intl.message('jerseyColor', name: 'jerseyColor');
  }

  String get submit {
    return Intl.message('submit', name: 'submit');
  }

  String get contactNumber {
    return Intl.message('contactNumber', name: 'contactNumber');
  }

  String get captainC {
    return Intl.message('captainC', name: 'captainC');
  }

  String get players {
    return Intl.message('players', name: 'players');
  }

  String get invite {
    return Intl.message('invite', name: 'invite');
  }

  String get searchC {
    return Intl.message('searchC', name: 'searchC');
  }

  String get pitchOwner {
    return Intl.message('pitchOwner', name: 'pitchOwner');
  }

  String get addPlayers {
    return Intl.message('addPlayers', name: 'addPlayers');
  }

  String get to {
    return Intl.message('to', name: 'to');
  }

  String get bysigningupTahaddi {
    return Intl.message('bysigningupTahaddi', name: 'bysigningupTahaddi');
  }

  String get termsofUse {
    return Intl.message('termsofUse', name: 'termsofUse');
  }

  String get and {
    return Intl.message('and', name: 'and');
  }

  String get privacyPolicy {
    return Intl.message('privacyPolicy', name: 'privacyPolicy');
  }

  String get createYourOwnTeam {
    return Intl.message('createYourOwnTeam', name: 'createYourOwnTeam');
  }

  String get youhaveSignedup {
    return Intl.message('youhaveSignedup', name: 'youhaveSignedup');
  }

  String get passwordhasbeenreset {
    return Intl.message('passwordhasbeenreset', name: 'passwordhasbeenreset');
  }

  String get passwordhasbeenchanged {
    return Intl.message('passwordhasbeenchanged',
        name: 'passwordhasbeenchanged');
  }

  String get youNeedChallenge {
    return Intl.message('youNeedChallenge', name: 'youNeedChallenge');
  }

  String get createYourOwnChallenge {
    return Intl.message('createYourOwnChallenge',
        name: 'createYourOwnChallenge');
  }

  String get createTeamNow {
    return Intl.message('createTeamNow', name: 'createTeamNow');
  }

  String get currency {
    return Intl.message('currency', name: 'currency');
  }

  String get pleaseEnterNewPassword {
    return Intl.message('pleaseEnterNewPassword',
        name: 'pleaseEnterNewPassword');
  }

  String get removeCard {
    return Intl.message('removeCard', name: 'removeCard');
  }

  String get selected {
    return Intl.message('selected', name: 'selected');
  }

  String get payNow {
    return Intl.message('payNow', name: 'payNow');
  }

  String get bookingSummaryC {
    return Intl.message('bookingSummaryC', name: 'bookingSummaryC');
  }

  String get paymentSuccessfully {
    return Intl.message('paymentSuccessfully', name: 'paymentSuccessfully');
  }

  String get tranjectionId {
    return Intl.message('tranjectionId', name: 'tranjectionId');
  }

  String get paidTotal {
    return Intl.message('paidTotal', name: 'paidTotal');
  }

  String get contacts {
    return Intl.message('contacts', name: 'contacts');
  }

  String get invitePlayers {
    return Intl.message('invitePlayers', name: 'invitePlayers');
  }

  String get yourTahaddi {
    return Intl.message('yourTahaddi', name: 'yourTahaddi');
  }

  String get saveCards {
    return Intl.message('saveCards', name: 'saveCards');
  }

  String get youCanAdd {
    return Intl.message('youCanAdd', name: 'youCanAdd');
  }

  String get savePaymentMethods {
    return Intl.message('savePaymentMethods', name: 'savePaymentMethods');
  }

  String get next {
    return Intl.message('next', name: 'next');
  }

  String get prev {
    return Intl.message('prev', name: 'prev');
  }

  String get events {
    return Intl.message('events', name: 'events');
  }

  String get noBookingsFound {
    return Intl.message('noBookingsFound', name: 'noBookingsFound');
  }

  String get youHaveBooked {
    return Intl.message('youHaveBooked', name: 'youHaveBooked');
  }

  String get createYourLeagueHere {
    return Intl.message('createYourLeagueHere', name: 'createYourLeagueHere');
  }

  String get createYourTournamentHere {
    return Intl.message('createYourTournamentHere',
        name: 'createYourTournamentHere');
  }

  String get home {
    return Intl.message('home', name: 'home');
  }

  String get booking {
    return Intl.message('booking', name: 'booking');
  }

  String get account {
    return Intl.message('account', name: 'account');
  }

  String get bankDetails {
    return Intl.message('bankDetails', name: 'bankDetails');
  }

  String get chooseAccount {
    return Intl.message('chooseAccount', name: 'chooseAccount');
  }

  String get selectUserType {
    return Intl.message('selectUserType', name: 'selectUserType');
  }

  String get player {
    return Intl.message('player', name: 'player');
  }

  String get pitchOwnerS {
    return Intl.message('pitchOwnerS', name: 'pitchOwnerS');
  }

  String get continueW {
    return Intl.message('continueW', name: 'continueW');
  }

  String get pitchOwnerDetails {
    return Intl.message('pitchOwnerDetails', name: 'pitchOwnerDetails');
  }

  String get addPitchImage {
    return Intl.message('addPitchImage', name: 'addPitchImage');
  }

  String get pitchName {
    return Intl.message('pitchName', name: 'pitchName');
  }

  String get pitchLocation {
    return Intl.message('pitchLocation', name: 'pitchLocation');
  }

  String get both {
    return Intl.message('both', name: 'both');
  }

  String get chooseFacilitiesProvided {
    return Intl.message('chooseFacilitiesProvided',
        name: 'chooseFacilitiesProvided');
  }

  String get documents {
    return Intl.message('documents', name: 'documents');
  }

  String get uploadDocument {
    return Intl.message('uploadDocument', name: 'uploadDocument');
  }

  String get weNeedAccount {
    return Intl.message('weNeedAccount', name: 'weNeedAccount');
  }

  String get addAsideCamesPitch {
    return Intl.message('addAsideCamesPitch', name: 'addAsideCamesPitch');
  }

  String get addPitchDetails {
    return Intl.message('addPitchDetails', name: 'addPitchDetails');
  }

  String get name {
    return Intl.message('name', name: 'name');
  }

  String get selectPitchType {
    return Intl.message('selectPitchType', name: 'selectPitchType');
  }

  String get price {
    return Intl.message('price', name: 'price');
  }

  String get accountNumber {
    return Intl.message('accountNumber', name: 'accountNumber');
  }

  String get ibnNumber {
    return Intl.message('ibnNumber', name: 'ibnNumber');
  }

  String get skip {
    return Intl.message('skip', name: 'skip');
  }

  String get finishSignup {
    return Intl.message('finishSignup', name: 'finishSignup');
  }

  String get save {
    return Intl.message('save', name: 'save');
  }

  String get accountHolderName {
    return Intl.message('accountHolderName', name: 'accountHolderName');
  }

  String get myPitches {
    return Intl.message('myPitches', name: 'myPitches');
  }

  String get verified {
    return Intl.message('verified', name: 'verified');
  }

  String get inReview {
    return Intl.message('inReview', name: 'inReview');
  }

  String get addNewGroundPitch {
    return Intl.message('addNewGroundPitch', name: 'addNewGroundPitch');
  }

  String get sortBy {
    return Intl.message('sortBy', name: 'sortBy');
  }

  String get latest {
    return Intl.message('latest', name: 'latest');
  }

  String get startDate {
    return Intl.message('startDate', name: 'startDate');
  }

  String get createLeague {
    return Intl.message('createLeague', name: 'createLeague');
  }

  String get leagueDetails {
    return Intl.message('leagueDetails', name: 'leagueDetails');
  }

  String get leagueName {
    return Intl.message('leagueName', name: 'leagueName');
  }

  String get bookingPrice {
    return Intl.message('bookingPrice', name: 'bookingPrice');
  }

  String get createTournament {
    return Intl.message('createTournament', name: 'createTournament');
  }

  String get tournamentDetails {
    return Intl.message('tournamentDetails', name: 'tournamentDetails');
  }

  String get tournamentName {
    return Intl.message('tournamentName', name: 'tournamentName');
  }

  String get totalTeamParticipate {
    return Intl.message('totalTeamParticipate', name: 'totalTeamParticipate');
  }

  String get clickStartTime {
    return Intl.message('clickStartTime', name: 'clickStartTime');
  }

  String get clickEndTime {
    return Intl.message('clickEndTime', name: 'clickEndTime');
  }

  String get lastBooking {
    return Intl.message('lastBooking', name: 'lastBooking');
  }

  String get SelectPitchLeague {
    return Intl.message('SelectPitchLeague', name: 'SelectPitchLeague');
  }

  String get selectAsidePitchLeague {
    return Intl.message('selectAsidePitchLeague',
        name: 'selectAsidePitchLeague');
  }

  String get areCreateleague {
    return Intl.message('areCreateleague', name: 'areCreateleague');
  }

  String get selectPitchTournament {
    return Intl.message('selectPitchTournament', name: 'selectPitchTournament');
  }

  String get selectAsidePitchTournament {
    return Intl.message('selectAsidePitchTournament',
        name: 'selectAsidePitchTournament');
  }

  String get areCreateTournament {
    return Intl.message('areCreateTournament', name: 'areCreateTournament');
  }

  String get confirm {
    return Intl.message('confirm', name: 'confirm');
  }

  String get currentPlayers {
    return Intl.message('currentPlayers', name: 'currentPlayers');
  }

  String get endDate {
    return Intl.message('endDate', name: 'endDate');
  }

  String get finish {
    return Intl.message('finish', name: 'finish');
  }

  String get manageSlots {
    return Intl.message('manageSlots', name: 'manageSlots');
  }

  String get bookingDetails {
    return Intl.message('bookingDetails', name: 'bookingDetails');
  }

  String get selectAsidePitchManageSlots {
    return Intl.message('selectAsidePitchManageSlots',
        name: 'selectAsidePitchManageSlots');
  }

  String get amongstAvailableSlotUnavailable {
    return Intl.message('amongstAvailableSlotUnavailable',
        name: 'amongstAvailableSlotUnavailable');
  }

  String get unavailable {
    return Intl.message('unavailable', name: 'unavailable');
  }

  String get availableSlots {
    return Intl.message('availableSlots', name: 'availableSlots');
  }

  String get since {
    return Intl.message('since', name: 'since');
  }

  String get until {
    return Intl.message('until', name: 'until');
  }

  String get closedHours {
    return Intl.message('closedHours', name: 'closedHours');
  }

  String get walkBookpitch {
    return Intl.message('walkBookpitch', name: 'walkBookpitch');
  }

  String get onlineBooking {
    return Intl.message('onlineBooking', name: 'onlineBooking');
  }

  String get walkHereTahaddi {
    return Intl.message('walkHereTahaddi', name: 'walkHereTahaddi');
  }

  String get buildTahaddi {
    return Intl.message('buildTahaddi', name: 'buildTahaddi');
  }

  String get walkyouTahaddi {
    return Intl.message('walkyouTahaddi', name: 'walkyouTahaddi');
  }

  String get walkcreatePitch {
    return Intl.message('walkcreatePitch', name: 'walkcreatePitch');
  }

  String get pitchTournament {
    return Intl.message('pitchTournament', name: 'pitchTournament');
  }

  String get youCanBuild {
    return Intl.message('youCanBuild', name: 'youCanBuild');
  }

  String get changepasswordC {
    return Intl.message('changepasswordC', name: 'changepasswordC');
  }

  String get createyourteam {
    return Intl.message('createyourteam', name: 'createyourteam');
  }

  String get Youneedtocreateyourownteam {
    return Intl.message('Youneedtocreateyourownteam',
        name: 'Youneedtocreateyourownteam');
  }

  String get youarecaptianoftheteamyoucreate {
    return Intl.message('youarecaptianoftheteamyoucreate',
        name: 'youarecaptianoftheteamyoucreate');
  }

  String get teamLogo {
    return Intl.message('teamLogo', name: 'teamLogo');
  }

  String get Youmaximumplayersyourteam {
    return Intl.message('Youmaximumplayersyourteam',
        name: 'Youmaximumplayersyourteam');
  }

  String get submitS {
    return Intl.message('submitS', name: 'submitS');
  }

  String get yourteamhasbeensuccessfullycreated {
    return Intl.message('yourteamhasbeensuccessfullycreated',
        name: 'yourteamhasbeensuccessfullycreated');
  }

  String get viewTeam {
    return Intl.message('viewTeam', name: 'viewTeam');
  }

  String get pending {
    return Intl.message('pending', name: 'pending');
  }

  String get joiningRequests {
    return Intl.message('joiningRequests', name: 'joiningRequests');
  }

  String get leaveTeam {
    return Intl.message('leaveTeam', name: 'leaveTeam');
  }

  String get addPlayerC {
    return Intl.message('addPlayerC', name: 'addPlayerC');
  }

  String get noplayershavebeenaddedyet {
    return Intl.message('noplayershavebeenaddedyet',
        name: 'noplayershavebeenaddedyet');
  }

  String get noPlayerRequests {
    return Intl.message('noPlayerRequests', name: 'noPlayerRequests');
  }

  String get share {
    return Intl.message('share', name: 'share');
  }

  String get newPlayer {
    return Intl.message('newPlayer', name: 'newPlayer');
  }

  String get hasrequestedtojointheteam {
    return Intl.message('hasrequestedtojointheteam',
        name: 'hasrequestedtojointheteam');
  }

  String get join {
    return Intl.message('join', name: 'join');
  }

  String get cancelRequest {
    return Intl.message('cancelRequest', name: 'cancelRequest');
  }

  String get teamplayers {
    return Intl.message('teamplayers', name: 'teamplayers');
  }

  String get approve {
    return Intl.message('approve', name: 'approve');
  }

  String get reject {
    return Intl.message('reject', name: 'reject');
  }

  String get searchplayerstahaddi {
    return Intl.message('searchplayerstahaddi', name: 'searchplayerstahaddi');
  }

  String get send {
    return Intl.message('send', name: 'send');
  }

  String get sent {
    return Intl.message('sent', name: 'sent');
  }

  String get youcreateexistingteam {
    return Intl.message('youcreateexistingteam', name: 'youcreateexistingteam');
  }

  String get requestjointeam {
    return Intl.message('requestjointeam', name: 'requestjointeam');
  }

  String get availablePlayers {
    return Intl.message('availablePlayers', name: 'availablePlayers');
  }

  String get pitchDetails {
    return Intl.message('pitchDetails', name: 'pitchDetails');
  }

  String get bookingpriceleague {
    return Intl.message('bookingpriceleague', name: 'bookingpriceleague');
  }

  String get pitchBookings {
    return Intl.message('pitchBookings', name: 'pitchBookings');
  }

  String get slots {
    return Intl.message('slots', name: 'slots');
  }

  String get unavailableSlots {
    return Intl.message('unavailableSlots', name: 'unavailableSlots');
  }

  String get available {
    return Intl.message('available', name: 'available');
  }

  String get closed {
    return Intl.message('closed', name: 'closed');
  }

  String get verifiedPitch {
    return Intl.message('verifiedPitch', name: 'verifiedPitch');
  }

  String get addNewPitch {
    return Intl.message('addNewPitch', name: 'addNewPitch');
  }

  String get clickfillenddatetime {
    return Intl.message('clickfillenddatetime', name: 'clickfillenddatetime');
  }

  String get startDateC {
    return Intl.message('startDateC', name: 'startDateC');
  }

  String get endDateC {
    return Intl.message('endDateC', name: 'endDateC');
  }

  String get editdatetime {
    return Intl.message('editdatetime', name: 'editdatetime');
  }

  String get choosefromlibrary {
    return Intl.message('choosefromlibrary', name: 'choosefromlibrary');
  }

  String get takephoto {
    return Intl.message('takephoto', name: 'takephoto');
  }

  String get uploadprofilepicture {
    return Intl.message('uploadprofilepicture', name: 'uploadprofilepicture');
  }

  String get makechoice {
    return Intl.message('makechoice', name: 'makechoice');
  }

  String get phone {
    return Intl.message('phone', name: 'phone');
  }

  String get logo {
    return Intl.message('logo', name: 'logo');
  }

  String get uploadImage {
    return Intl.message('uploadImage', name: 'uploadImage');
  }

  String get bookedSlots {
    return Intl.message('bookedSlots', name: 'bookedSlots');
  }

  String get chooseyoursport {
    return Intl.message('chooseyoursport', name: 'chooseyoursport');
  }

  String get chooseteamlogo {
    return Intl.message('chooseteamlogo', name: 'chooseteamlogo');
  }

  String get withTahaddi {
    return Intl.message('withTahaddi', name: 'withTahaddi');
  }

  String get withoutTahaddi {
    return Intl.message('withoutTahaddi', name: 'withoutTahaddi');
  }

  String get chooseYourTeam {
    return Intl.message('chooseYourTeam', name: 'chooseYourTeam');
  }

  String get facilityProvided {
    return Intl.message('facilityProvided', name: 'facilityProvided');
  }

  String get ratingsReviews {
    return Intl.message('ratingsReviews', name: 'ratingsReviews');
  }

  String get booked {
    return Intl.message('booked', name: 'booked');
  }

  String get bookYourSlot {
    return Intl.message('bookYourSlot', name: 'bookYourSlot');
  }

  String get addPitch {
    return Intl.message('addPitch', name: 'addPitch');
  }

  String get changeImage {
    return Intl.message('changeImage', name: 'changeImage');
  }

  String get numberplayerscompleteteam {
    return Intl.message('numberplayerscompleteteam',
        name: 'numberplayerscompleteteam');
  }

  String get newC {
    return Intl.message('newC', name: 'newC');
  }

  String get viewAll {
    return Intl.message('viewAll', name: 'viewAll');
  }

  String get previous {
    return Intl.message('previous', name: 'previous');
  }

  String get commentForThisPitch {
    return Intl.message('commentForThisPitch', name: 'commentForThisPitch');
  }

  String get select {
    return Intl.message('select', name: 'select');
  }

  String get undo {
    return Intl.message('undo', name: 'undo');
  }

  String get selectyourfield {
    return Intl.message('selectyourfield', name: 'selectyourfield');
  }

  String get addreviewspitchyouhaveplayedon {
    return Intl.message('addreviewspitchyouhaveplayedon',
        name: 'addreviewspitchyouhaveplayedon');
  }

  String get registeredTeam {
    return Intl.message('registeredTeam', name: 'registeredTeam');
  }

  String get registeredTeamC {
    return Intl.message('registeredTeamC', name: 'registeredTeamC');
  }

  String get teamnotTahaddi {
    return Intl.message('teamnotTahaddi', name: 'teamnotTahaddi');
  }

  String get teaminTahaddi {
    return Intl.message('teaminTahaddi', name: 'teaminTahaddi');
  }

  String get playerTeam {
    return Intl.message('playerTeam', name: 'playerTeam');
  }

  String get playersTeam {
    return Intl.message('playersTeam', name: 'playersTeam');
  }

  String get ago {
    return Intl.message('ago', name: 'ago');
  }

  String get oftheTeam {
    return Intl.message('oftheTeam', name: 'oftheTeam');
  }

  String get bookingpricefortheleague {
    return Intl.message('bookingpricefortheleague',
        name: 'bookingpricefortheleague');
  }

  String get bookingpricefortheTournament {
    return Intl.message('bookingpricefortheTournament',
        name: 'bookingpricefortheTournament');
  }

  String get gamePlayed {
    return Intl.message('gamePlayed', name: 'gamePlayed');
  }

  String get hasrequestedyoutojoin {
    return Intl.message('hasrequestedyoutojoin', name: 'hasrequestedyoutojoin');
  }

  String get noplayershavebeenfoundnearyou {
    return Intl.message('noplayershavebeenfoundnearyou',
        name: 'noplayershavebeenfoundnearyou');
  }

  String get searchlocationorevent {
    return Intl.message('searchlocationorevent', name: 'searchlocationorevent');
  }

  String get slotSelected {
    return Intl.message('slotSelected', name: 'slotSelected');
  }

  String get slotDetails {
    return Intl.message('slotDetails', name: 'slotDetails');
  }

  String get editcard {
    return Intl.message('editcard', name: 'editcard');
  }

  String get cardNumberC {
    return Intl.message('cardNumberC', name: 'cardNumberC');
  }

  String get gotoHomepage {
    return Intl.message('gotoHomepage', name: 'gotoHomepage');
  }

  String get noInternetConnection {
    return Intl.message('noInternetConnection', name: 'noInternetConnection');
  }

  String get tryAgain {
    return Intl.message('tryAgain', name: 'tryAgain');
  }

  String get enteringwithtahadditeam {
    return Intl.message('enteringwithtahadditeam',
        name: 'enteringwithtahadditeam');
  }

  String get selectonefieldtoenterwithotherteam {
    return Intl.message('selectonefieldtoenterwithotherteam',
        name: 'selectonefieldtoenterwithotherteam');
  }

  String get selectonefieldtoenterwithotheryourtahadditeam {
    return Intl.message('selectonefieldtoenterwithotheryourtahadditeam',
        name: 'selectonefieldtoenterwithotheryourtahadditeam');
  }

  String get orSignUpWith {
    return Intl.message('orSignUpWith', name: 'orSignUpWith');
  }

  String get pleaseselectyourfield {
    return Intl.message('pleaseselectyourfield', name: 'pleaseselectyourfield');
  }

  String get slot {
    return Intl.message('slot', name: 'slot');
  }

  String get pleaseenterTeamName {
    return Intl.message('pleaseenterTeamName', name: 'pleaseenterTeamName');
  }

  String get pleaseenterEmail {
    return Intl.message('pleaseenterEmail', name: 'pleaseenterEmail');
  }

  String get pleaseenterPhoneNumber {
    return Intl.message('pleaseenterPhoneNumber',
        name: 'pleaseenterPhoneNumber');
  }

  String get tokenhasbeenExpired {
    return Intl.message('tokenhasbeenExpired', name: 'tokenhasbeenExpired');
  }

  String get invalidEmail {
    return Intl.message('invalidEmail', name: 'invalidEmail');
  }

  String get pleaseenterNewPassword {
    return Intl.message('pleaseenterNewPassword',
        name: 'pleaseenterNewPassword');
  }

  String get passwordMismatch {
    return Intl.message('passwordMismatch', name: 'passwordMismatch');
  }

  String get pleaseenterPassword {
    return Intl.message('pleaseenterPassword', name: 'pleaseenterPassword');
  }

  String get logincancelledbytheuser {
    return Intl.message('logincancelledbytheuser',
        name: 'logincancelledbytheuser');
  }

  String get pleaseenterFirstName {
    return Intl.message('pleaseenterFirstName', name: 'pleaseenterFirstName');
  }

  String get pleaseenterLastName {
    return Intl.message('pleaseenterLastName', name: 'pleaseenterLastName');
  }

  String get playerPosition {
    return Intl.message('playerPosition', name: 'playerPosition');
  }

  String get selectPlayerPosition {
    return Intl.message('selectPlayerPosition', name: 'selectPlayerPosition');
  }

  String get minimumMaximum14Characters {
    return Intl.message('minimumMaximum14Characters',
        name: 'minimumMaximum14Characters');
  }

  String get done {
    return Intl.message('done', name: 'done');
  }

  String get invalidOTPCode {
    return Intl.message('invalidOTPCode', name: 'invalidOTPCode');
  }

  String get invalidCode {
    return Intl.message('invalidCode', name: 'invalidCode');
  }

  String get pin {
    return Intl.message('pin', name: 'pin');
  }

  String get enterthedigitcodewhichsentonregisteredphonenumber {
    return Intl.message('enterthedigitcodewhichsentonregisteredphonenumber',
        name: 'enterthedigitcodewhichsentonregisteredphonenumber');
  }

  String get pleaseentercardholdername {
    return Intl.message('pleaseentercardholdername',
        name: 'pleaseentercardholdername');
  }

  String get pleaseentercvvnumber {
    return Intl.message('pleaseentercvvnumber', name: 'pleaseentercvvnumber');
  }

  String get pleaseentervaliditymonth {
    return Intl.message('pleaseentervaliditymonth',
        name: 'pleaseentervaliditymonth');
  }

  String get pleaseentervaliditydate {
    return Intl.message('pleaseentervaliditydate',
        name: 'pleaseentervaliditydate');
  }

  String get pleaseentercardnumber {
    return Intl.message('pleaseentercardnumber', name: 'pleaseentercardnumber');
  }

  String get choosedateofbirth {
    return Intl.message('choosedateofbirth', name: 'choosedateofbirth');
  }

  String get myReviewsRatings {
    return Intl.message('myReviewsRatings', name: 'myReviewsRatings');
  }

  String get addyourexperienceforthepitchesyouhaveplayedupon {
    return Intl.message('addyourexperienceforthepitchesyouhaveplayedupon',
        name: 'addyourexperienceforthepitchesyouhaveplayedupon');
  }

  String get review {
    return Intl.message('review', name: 'review');
  }

  String get yourexperience {
    return Intl.message('yourexperience', name: 'yourexperience');
  }

  String get ratethepitch {
    return Intl.message('ratethepitch', name: 'ratethepitch');
  }

  String get pleaseenterReviews {
    return Intl.message('pleaseenterReviews', name: 'pleaseenterReviews');
  }

  String get reviews {
    return Intl.message('reviews', name: 'reviews');
  }

  String get pleaseenterCurrentPassword {
    return Intl.message('pleaseenterCurrentPassword',
        name: 'pleaseenterCurrentPassword');
  }

  String get gotoLoginPage {
    return Intl.message('gotoLoginPage', name: 'gotoLoginPage');
  }

  String get toremovethecard {
    return Intl.message('toremovethecard', name: 'toremovethecard');
  }

  String get football {
    return Intl.message('football', name: 'football');
  }

  String get pleaseenterPitchName {
    return Intl.message('pleaseenterPitchName', name: 'pleaseenterPitchName');
  }

  String get pleaseenterDescription {
    return Intl.message('pleaseenterDescription',
        name: 'pleaseenterDescription');
  }

  String get pleaseentername {
    return Intl.message('pleaseentername', name: 'pleaseentername');
  }

  String get pleaseenterprice {
    return Intl.message('pleaseenterprice', name: 'pleaseenterprice');
  }

  String get pleaseenterIBANCode {
    return Intl.message('pleaseenterIBANCode', name: 'pleaseenterIBANCode');
  }

  String get pleaseenterAccountNumber {
    return Intl.message('pleaseenterAccountNumber',
        name: 'pleaseenterAccountNumber');
  }

  String get pleaseenterAccountHolderName {
    return Intl.message('pleaseenterAccountHolderName',
        name: 'pleaseenterAccountHolderName');
  }

  String get pleaseentercomment {
    return Intl.message('pleaseentercomment', name: 'pleaseentercomment');
  }

  String get nameoftheclosedhours {
    return Intl.message('nameoftheclosedhours', name: 'nameoftheclosedhours');
  }

  String get youcannotcreatea {
    return Intl.message('youcannotcreatea', name: 'youcannotcreatea');
  }

  String get asyourpitchhasnotbeenverifiedyet {
    return Intl.message('asyourpitchhasnotbeenverifiedyet',
        name: 'asyourpitchhasnotbeenverifiedyet');
  }

  String get ok {
    return Intl.message('ok', name: 'ok');
  }

  String get pitchNameEnglish {
    return Intl.message('pitchNameEnglish', name: 'pitchNameEnglish');
  }

  String get descriptionEnglish {
    return Intl.message('descriptionEnglish', name: 'descriptionEnglish');
  }

  String get am {
    return Intl.message('am', name: 'am');
  }

  String get pm {
    return Intl.message('pm', name: 'pm');
  }

  String get yesterday {
    return Intl.message('yesterday', name: 'yesterday');
  }

  String get daysago {
    return Intl.message('daysago', name: 'daysago');
  }

  String get today {
    return Intl.message('today', name: 'today');
  }

  String get teamDetail {
    return Intl.message('teamDetail', name: 'teamDetail');
  }

  String get rejectedPitch {
    return Intl.message('rejectedPitch', name: 'rejectedPitch');
  }

  String get addanotherdocument {
    return Intl.message('addanotherdocument', name: 'addanotherdocument');
  }

  String get rejected {
    return Intl.message('rejected', name: 'rejected');
  }

  String get addnewpitchdetails {
    return Intl.message('addnewpitchdetails', name: 'addnewpitchdetails');
  }

  String get noverifiedpitchyet {
    return Intl.message('noverifiedpitchyet', name: 'noverifiedpitchyet');
  }

  String get uploadpitchimages {
    return Intl.message('uploadpitchimages', name: 'uploadpitchimages');
  }

  String get uploadPitchDocument {
    return Intl.message('uploadPitchDocument', name: 'uploadPitchDocument');
  }

  String get rebook {
    return Intl.message('rebook', name: 'rebook');
  }

  String get processing {
    return Intl.message('processing', name: 'processing');
  }

  String get emailhasbeensent {
    return Intl.message('emailhasbeensent', name: 'emailhasbeensent');
  }

  String get pitchnameinArabic {
    return Intl.message('pitchnameinArabic', name: 'pitchnameinArabic');
  }

  String get descriptioninArabic {
    return Intl.message('descriptioninArabic', name: 'descriptioninArabic');
  }

  String get pitchcontact {
    return Intl.message('pitchcontact', name: 'pitchcontact');
  }

  String get whatsapp {
    return Intl.message('whatsapp', name: 'whatsapp');
  }

  String get instagram {
    return Intl.message('instagram', name: 'instagram');
  }

  String get callus {
    return Intl.message('callus', name: 'callus');
  }

  String get continu {
    return Intl.message('continu', name: 'continu');
  }

  String get continueS {
    return Intl.message('continueS', name: 'continueS');
  }

  String get gender {
    return Intl.message('gender', name: 'gender');
  }

  String get socialTitle {
    return Intl.message('socialTitle', name: 'socialTitle');
  }

  String get pleaseselectDateofBirth {
    return Intl.message('pleaseselectDateofBirth',
        name: 'pleaseselectDateofBirth');
  }

  String get doyouwanttoleaveteam {
    return Intl.message('doyouwanttoleaveteam', name: 'doyouwanttoleaveteam');
  }

  String get pleaseselectnewcaptain {
    return Intl.message('pleaseselectnewcaptain',
        name: 'pleaseselectnewcaptain');
  }

  String get pleaseselectgender {
    return Intl.message('pleaseselectgender', name: 'pleaseselectgender');
  }

  String get clickHereIndicate {
    return Intl.message('clickHereIndicate', name: 'clickHereIndicate');
  }

  String get tahaddeAgreement {
    return Intl.message('tahaddeAgreement', name: 'tahaddeAgreement');
  }

  String get informationText {
    return Intl.message('informationText', name: 'informationText');
  }

  String get locationText {
    return Intl.message('locationText', name: 'locationText');
  }

  String get locationDes {
    return Intl.message('locationDes', name: 'locationDes');
  }

  String get responsibilities {
    return Intl.message('responsibilities', name: 'responsibilities');
  }

  String get responsibilitiesDes {
    return Intl.message('responsibilitiesDes', name: 'responsibilitiesDes');
  }

  String get commissionPayment {
    return Intl.message('commissionPayment', name: 'commissionPayment');
  }

  String get commissionPaymentDes {
    return Intl.message('commissionPaymentDes', name: 'commissionPaymentDes');
  }

  String get cancellationPolicy {
    return Intl.message('cancellationPolicy', name: 'cancellationPolicy');
  }

  String get cancellationPolicyDes {
    return Intl.message('cancellationPolicyDes', name: 'cancellationPolicyDes');
  }

  String get termTermination {
    return Intl.message('termTermination', name: 'termTermination');
  }

  String get termTerminationDes {
    return Intl.message('termTerminationDes', name: 'termTerminationDes');
  }

  String get areYouSureYouWant {
    return Intl.message('areYouSureYouWant', name: 'areYouSureYouWant');
  }

  String get cameraPermission {
    return Intl.message('cameraPermission', name: 'cameraPermission');
  }

  String get deny {
    return Intl.message('deny', name: 'deny');
  }

  String get thisPicturesUploadImage {
    return Intl.message('thisPicturesUploadImage',
        name: 'thisPicturesUploadImage');
  }

  String get galleryPermission {
    return Intl.message('galleryPermission', name: 'galleryPermission');
  }

  String get thisGalleryPicturesUploadImage {
    return Intl.message('thisGalleryPicturesUploadImage',
        name: 'thisGalleryPicturesUploadImage');
  }

  String get locationPermission {
    return Intl.message('locationPermission', name: 'locationPermission');
  }

  String get thislocationPicturesUploadImage {
    return Intl.message('thislocationPicturesUploadImage',
        name: 'thislocationPicturesUploadImage');
  }

  String get ourPolicy {
    return Intl.message('ourPolicy', name: 'ourPolicy');
  }

  String get calendarPermission {
    return Intl.message('calendarPermission', name: 'calendarPermission');
  }

  String get thisCalendarPicturesUploadImage {
    return Intl.message('thisCalendarPicturesUploadImage',
        name: 'thisCalendarPicturesUploadImage');
  }

  String get filterBy {
    return Intl.message('filterBy', name: 'filterBy');
  }

  String get venues {
    return Intl.message('venues', name: 'venues');
  }

  String get showDirections {
    return Intl.message('showDirections', name: 'showDirections');
  }

  String get about {
    return Intl.message('about', name: 'about');
  }

  String get play {
    return Intl.message('play', name: 'play');
  }

  String get facilitiesProvided {
    return Intl.message('facilitiesProvided', name: 'facilitiesProvided');
  }

  String get endC {
    return Intl.message('endC', name: 'endC');
  }

  String get startC {
    return Intl.message('startC', name: 'startC');
  }

  String get holiday {
    return Intl.message('holiday', name: 'holiday');
  }

  String get perVenue {
    return Intl.message('perVenue', name: 'perVenue');
  }

  String get perPlayer {
    return Intl.message('perPlayer', name: 'perPlayer');
  }

  String get selectnumberofplayer {
    return Intl.message('selectnumberofplayer', name: 'selectnumberofplayer');
  }

  String get thisDayHoliday {
    return Intl.message('thisDayHoliday', name: 'thisDayHoliday');
  }

  String get day {
    return Intl.message('day', name: 'day');
  }

  String get bookNowS {
    return Intl.message('bookNowS', name: 'bookNowS');
  }

  String get sessions {
    return Intl.message('sessions', name: 'sessions');
  }

  String get venueName {
    return Intl.message('venueName', name: 'venueName');
  }

  String get slotPrice {
    return Intl.message('slotPrice', name: 'slotPrice');
  }

  String get venueNameA {
    return Intl.message('venueNameA', name: 'venueNameA');
  }

  String get code {
    return Intl.message('code', name: 'code');
  }

  String get descriptionS {
    return Intl.message('descriptionS', name: 'descriptionS');
  }

  String get descriptionA {
    return Intl.message('descriptionA', name: 'descriptionA');
  }

  String get documentName {
    return Intl.message('documentName', name: 'documentName');
  }

  String get licenceName {
    return Intl.message('licenceName', name: 'licenceName');
  }

  String get expiryDate {
    return Intl.message('expiryDate', name: 'expiryDate');
  }

  String get expiryDocumentDate {
    return Intl.message('expiryDocumentDate', name: 'expiryDocumentDate');
  }

  String get multipleRates {
    return Intl.message('multipleRates', name: 'multipleRates');
  }

  String get document {
    return Intl.message('document', name: 'document');
  }

  String get slotChart {
    return Intl.message('slotChart', name: 'slotChart');
  }

  String get thankyouforaddingyourvenue {
    return Intl.message('thankyouforaddingyourvenue',
        name: 'thankyouforaddingyourvenue');
  }

  String get typeofSports {
    return Intl.message('typeofSports', name: 'typeofSports');
  }

  String get selecttypeofSport {
    return Intl.message('selecttypeofSport', name: 'selecttypeofSport');
  }

  String get subVenueName {
    return Intl.message('subVenueName', name: 'subVenueName');
  }

  String get pricePerPlayer {
    return Intl.message('pricePerPlayer', name: 'pricePerPlayer');
  }

  String get startTime {
    return Intl.message('startTime', name: 'startTime');
  }

  String get endTime {
    return Intl.message('endTime', name: 'endTime');
  }

  String get createSession {
    return Intl.message('createSession', name: 'createSession');
  }

  String get venueCreated {
    return Intl.message('venueCreated', name: 'venueCreated');
  }

  String get amount {
    return Intl.message('amount', name: 'amount');
  }

  String get addSession {
    return Intl.message('addSession', name: 'addSession');
  }

  String get markAsHoliday {
    return Intl.message('markAsHoliday', name: 'markAsHoliday');
  }

  String get CreateYourSession {
    return Intl.message('CreateYourSession', name: 'CreateYourSession');
  }

  String get nameA {
    return Intl.message('nameA', name: 'nameA');
  }

  String get createSlotDuration {
    return Intl.message('createSlotDuration', name: 'createSlotDuration');
  }

  String get extraGraceTime {
    return Intl.message('extraGraceTime', name: 'extraGraceTime');
  }

  String get monday {
    return Intl.message('monday', name: 'monday');
  }

  String get tuesday {
    return Intl.message('tuesday', name: 'tuesday');
  }

  String get wednesday {
    return Intl.message('wednesday', name: 'wednesday');
  }

  String get thursday {
    return Intl.message('thursday', name: 'thursday');
  }

  String get friday {
    return Intl.message('friday', name: 'friday');
  }

  String get saturday {
    return Intl.message('saturday', name: 'saturday');
  }

  String get sunday {
    return Intl.message('sunday', name: 'sunday');
  }

  String get selectLocation {
    return Intl.message('selectLocation', name: 'selectLocation');
  }

  String get noVenuesAvailable {
    return Intl.message('noVenuesAvailable', name: 'noVenuesAvailable');
  }

  String get cancellationsMadeWithin {
    return Intl.message('cancellationsMadeWithin',
        name: 'cancellationsMadeWithin');
  }

  String get sessionName {
    return Intl.message('sessionName', name: 'sessionName');
  }

  String get clear {
    return Intl.message('clear', name: 'clear');
  }

  String get noSlotsAvailable {
    return Intl.message('noSlotsAvailable', name: 'noSlotsAvailable');
  }

  String get deleteAccount {
    return Intl.message('deleteAccount', name: 'deleteAccount');
  }

  String get sorryYouEditReview {
    return Intl.message('sorryYouEditReview', name: 'sorryYouEditReview');
  }
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

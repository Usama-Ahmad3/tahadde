class RestApis {
  // static String BASEURL = "http://54.173.21.116:8000";
  static String BASEURL = "https://powerhouse.tahadde.ae";
  // static String BASE_URL ="https://tahadi.theclientdemos.com";

  //login, signup & logout api
  // static String SIGNUP = "/api/v1/user/signup/?language=";
  static String SIGNUP = "/api/v1/user/signup/";
  static String LOGIN = "/api/v1/user/login/";
  static String LOGINFACEBOOK = "/api/v1/user/facebook-login/";
  static String LOGINAPPLE = "/api/v1/user/apple-login/";
  static String LOGINGOOGLE = "/api/v1/user/google-login/";
  static String LOGOUT = "/api/v1/user/logout/";
  // static String PHONENUMBER = "/api/v1/user/verifycontactnumber/";
  static String PHONENUMBER = "/api/v1/user/verifycontactnumber/";
  static String FORGOT_PASSWORD = "/api/v1/user/forgetpassword/";
  static String CHANGEPASSWORD = "/api/v1/user/changepassword/";
  static String RESETPASSWORD = "/api/v1/user/resetpassword/";
  static String TOKENSTATUS = "/api/v1/user/tokenstatus/";
  static String DELETEACCOUNT = "/api/v1/user/account/delete/";

  // profile api
  static String GET_PROFILE = "/api/v1/user/me/";
  static String EDIT_USER_PROFILE = "/api/v1/user/updateuserprofile/";

  //dashboard
  static String PITCHTYPEDASHBOARD = "/api/v1/dashboard/pitchtype/";
  static String DASHBOARD = "/api/v1/dashboard/module/";
  static String DASHBOARDFILTER = "/api/v1/dashboard/filter/module/";
  static String FACILITY = "/api/v1/dashboard/gameplay/";
  static String SPORTS_LIST = "/api/v1/helpers/sportslistmobile/?language=";
  static String SPORTS_ECPERIENCE_LIST =
      "/api/v1/helpers/availablemodernsmobile/?language=";
  static String verifiedAcademies = '/api/v1/user/get_verified_academies/';
  static String AVAILABLE_PITCH_TYPE =
      "/api/v1/dashboard/sport_secific_pitch/?sport_slug=";
  static String WEEK_LIST = "/api/v1/helpers/available_weekdays/";
  // static String CREATE_SESSION = "/api/v1/bookpitch/pitchowner/pitch/";
  static String CREATE_SESSION = "/api/v1/user/create_sessions/";
  static String SLOT_LIST = "/api/v1/bookpitch/pitchowner/pitch/";

  //events api
  static String LEAGUE = "/api/v1/league/";
  static String TOURNAMENT = "/api/v1/tournament/";
  static String BOOKPITCH =
      "/api/v1/bookpitch/pitchowner/pitch/player_available_pitches_list_details/?language=";
  static String BOOKPITCHSLOT =
      "/api/v1/bookpitch/pitchowner/pitch/player_book_pitchslots/?booking_as_per=";
  static String SLOTCHECK = "/api/v1/bookpitch/player/pitch/";
  static String YOURTAHADDI = "/api/v1/user/tahaddis/";
  static String TRANSECTION = "/api/v1/user/create_user_transaction/";
  static String CANCELBOOKING = "/api/v1/user/cancelbookings/";
  static String BOOKINGHISTORY = "/api/v1/user/bookings/event/";
  static String BOOKINGHISTORYPITCH = "/api/v1/user/bookings/pitch/";
  static String VERIFYLEAGUETOURNAMENT = "/api/v1/";

  //pitch owner side
  static String VERIFY_EMAIL = "/api/v1/user/verifyemail/";
  static String VERIFY_PITCH = "/api/v1/bookpitch/verify-pitch/";
  static String VERIFIED_PITCH =
      "/api/v1/bookpitch/pitchowner/pitch/?pitch=verified";
  static String CREATE_LEAGUE = "/api/v1/league/pitchowner/?language=";
  static String CREATE_TOURNAMENT = "/api/v1/tournament/pitchowner/?language=";
  static String HOMELEAGUE = "/api/v1/league/pitchowner/?language=";
  static String LEAGUEDETAIL = "/api/v1/league/";
  static String TOURNAMENTDETAIL = "/api/v1/tournament/";
  static String HOMELEAGUESORT =
      "/api/v1/league/pitchowner/?sort_by=start_date&language=";
  static String HOMETOURNAMENT = "/api/v1/tournament/pitchowner/?language=";
  static String HOMETOURNAMENTSORT =
      "/api/v1/tournament/pitchowner/?sort_by=start_date&language=";
  static String HELPERPROFILE = "/api/v1/helpers/fileupload/";
  static String MULTIIMAGE = "/api/v1/helpers/multiplefileuploads/";
  static String image = "/api/v1/acadmies/multiupload/";
  static String VERIFIEDPITCH =
      "/api/v1/bookpitch/pitchowner/pitch/?pitch=verified";
  static String INREVIEW = "/api/v1/bookpitch/pitchowner/pitch/?pitch=inreview";
  static String CURRENTDATE = "/api/v1/bookpitch/pitchowner/bookings-number/";
  static String BOOKING = "/api/v1/bookpitch/pitchowner/bookings/?slotDate=";
  static String MANAGESLOT = "/api/v1/bookpitch/pitchowner/pitch/";

  //team
  static String TEAMLISTING = "/api/v1/team/";
  static String TEAMINFO = "/api/v1/team/info/";
  static String CREATTEAM = "/api/v1/team/captain/";
  static String ASSIGNCAPTAIN = "/api/v1/team/assign/captain/";
  static String PLAYERTEAM = "/api/v1/team/player/";
  static String SEARCHPLAYER = "/api/v1/team/search-player/";
  static String PLAYERINVITATIONSEND = "/api/v1/team/player/invitation/";
  static String CAPTAININVITATION = "/api/v1/team/captain/invitation/";
  static String PLAYERPOSITION = "/api/v1/helpers/player-position/";
  static String SPORTSTYPES = "/api/v1/helpers/sportslistmobile/";
  static String SPORTSMODERNS = "/api/v1/helpers/availablemodernsmobile/";

  //rating
  static String RATING = "/api/v1/user/pitch/rating/";
  static String RATINGSEND = "/api/v1/user/pitch/";

  //notification
  static String NOTIFICATION = "/api/v1/user/notification/?language=";

  //favorite
  static String MYINTEREST = "/api/v1/user/favourite/pitch/";
  static String ROLE = "/api/v1/user/role/";

  //transaction
  static String TRANSECTIONTOKEN = "/api/v1/helpers/myfatoorahbearertoken/";
  static String TRANSECTIONSTATUS = "/api/v1/helpers/myfatoorahpaymentstatus/";

  //latlongStatus
  static String LATLONG = "/api/v1/helpers/addressfromlatlong/";

//privacyPolicy
  static String PRIVACYPOLICY = "/api/v1/helpers/privact-policy/?language=";
  static String CREATE_ACADEMY = "/api/v1/user/create_academy/";
  static String slotConfirm = '/api/v1/user/academy/';
  static String UPDATE_SLOT =
      "/api/v1/bookpitch/pitchowner/pitch/updateslotprice/";
  static String AVAILABLE_DOC = "/api/v1/acadmies/documents/";
  static String MY_VENUES =
      "/api/v1/bookpitch/pitchowner/pitch/specific_pitchowner_list_pitches/";
  static String allAcademies =
      "https://ahmad223.pythonanywhere.com/api/v1/user/academy/";
  static String DELETE_PITCH =
      "/api/v1/bookpitch/pitchowner/pitch/delete_specific_pitchowner_pitche/";
  static String SPECIFIC_PITCH =
      "/api/v1/bookpitch/pitchowner/pitch/specific_pitchowner_details_pitches/";
  static String specificAcademy = '/api/v1/user/academy/';
  static String EDIT_VENUE =
      "/api/v1/bookpitch/pitchowner/pitch/specific_pitchowner_details_pitches/";
  static String edit_academy = '/api/v1/user/edit_academy/';
  static String VENUE_DETAIL =
      "/api/v1/bookpitch/pitchowner/pitch/player_available_pitches_list_details/";
  static String SLOT_DETAIL = "/api/v1/bookpitch/pitchowner/pitch/";
  static String PROMOTION =
      "/api/v1/user/get_all_promotional_events/?language=";
  static String TERRITORY = "/api/v1/dashboard/territory/list/?language=";
  static String UPDATE_SESSIONS =
      "/api/v1/bookpitch/pitchowner/pitch/update_specific_subpitch_sessions/";
}

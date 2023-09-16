import 'dart:convert';
import 'dart:io';

// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/apis.dart';
import '../common_widgets/hamcSecurity.dart';
import '../modelClass/bookPitchModelClass.dart';
import '../modelClass/bookPitchSlotModelClass.dart';
import '../modelClass/bookingModelClass.dart';
import '../modelClass/eventModelClass.dart';
import '../modelClass/leagueModelClass.dart';
import '../modelClass/manageSlotModelClass.dart';
import '../modelClass/my_venue_list_model_class.dart';
import '../modelClass/pitchModelClass.dart';
import '../modelClass/pramotion_model_class.dart';
import '../modelClass/searchPlayerModelClass.dart';
import '../modelClass/specific_pitch_model_class.dart';
import '../modelClass/teamModelClass.dart';
import '../modelClass/territory_model_class.dart';
import '../modelClass/turnamentModelClass.dart';
import '../modelClass/venue_detail_model_class.dart';
import '../modelClass/venue_slot_model_class.dart';
import '../modelClass/yourTahaddiBookPitch.dart';
import '../modelClass/yourTahaddiModelClass.dart';

typedef OnSuccess<T> = void Function(T value);
typedef OnFailure<T> = void Function(T newValue);
typedef TokenExpire<T> = void Function();

class NetworkCalls {
  final int tokenExpireStatus = 401;
  final String internetStatus = "This network has no access to internet";

  Map<String, String> header(
      SharedPreferences pref, String data, HttpMethod method) {
    return {
      "Content-Type": "application/json",
      "Signing-Key": AppSigning.signature(data, method, pref)
    };
  }

  Map<String, String> headerWithToken(
      SharedPreferences pref, String data, HttpMethod method) {
    Map<String, String> _headers = header(pref, data, method);
    if (pref.get('token') != null) {
      _headers.addAll({"Authorization": "Token ${pref.get('token')}"});
    }
    return _headers;
  }

  checkAvailabilityOfEmail(
      {required String email,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode({"email": email});
    try {
      response = await http.post(
          Uri.parse("https://powerhouse.tahadde.ae/api/v1/user/verifyemail/"),
          headers: header(
            prefs,
            body,
            HttpMethod.POST,
          ),
          body: body);
      print(response.body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("This Email already exist");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  checkEmailExist(
      {required String email,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode({"email": email});
    try {
      response = await http.post(
          Uri.parse("https://powerhouse.tahadde.ae${RestApis.VERIFY_EMAIL}"),
          headers: header(
            prefs,
            body,
            HttpMethod.POST,
          ),
          body: body);
      // print(response.body);
      if (response.statusCode == 409) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["error"]);
      } else if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["success"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("This Email not exist");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("This Email not exist");
    }
  }

  checkAvailabilityOfPhoneNumber(
      {required String phone,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode({"contact_number": phone});
    try {
      response = await http.post(
          Uri.parse("https://powerhouse.tahadde.ae${RestApis.PHONENUMBER}"),
          headers: header(prefs, body, HttpMethod.POST),
          body: body);
      print(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("This contact number already exists");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("This contact number already exists");
    }
  }

  veryPitch(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.post(
        Uri.parse(
            "${(prefs.get("baseUrl") ?? RestApis.BASE_URL)}${RestApis.VERIFY_PITCH}?language=${prefs.get("lang")}"),
        headers: headerWithToken(prefs, "{}", HttpMethod.POST),
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("verified pitches do not exist");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("verified pitches do not exist");
    }
  }

  createLeague(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    print(detail);
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(detail);
    try {
      response = await http.post(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.CREATE_LEAGUE}${prefs.get("lang")}"),
          headers: headerWithToken(prefs, body, HttpMethod.POST),
          body: body);

      if (response.statusCode == 201) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("fail to create league");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("fail to create league");
    }
  }

  createTournament(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(detail);
    try {
      response = await http.post(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.CREATE_TOURNAMENT}${prefs.get("lang")}"),
          headers: headerWithToken(prefs, body, HttpMethod.POST),
          body: body);
      if (response.statusCode == 201) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("fail to create tournament");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("fail to create tournament");
    }
  }

  signUp({
    required Map signupDetail,
    required OnSuccess onSuccess,
    required OnFailure onFailure,
  }) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(signupDetail);
    try {
      response = await http.post(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.SIGNUP}${prefs.get("lang")}"),
          headers: header(prefs, body, HttpMethod.POST),
          body: body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
        saveToken(resp["key"]);
        saveRole(resp["role"]);
        authorizationSave(true);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure("ErrorNo${resp["error"]}");
        print('${resp["error"]}');
      } else {
        onFailure("fail to sign up");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("fail to signup");
    }
  }

  savewalk(String walk) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("walk", walk);
  }

  saveRole(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("role", token);
  }

  authorizationSave(bool auth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("auth", auth);
  }

  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  saveKeys(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  saveLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", lang);
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  getKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(key);
    return token;
  }

  saveBaseUrl({required OnSuccess onSuccess}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs
        .setString("baseUrl", RestApis.BASE_URL)
        .then((value) => onSuccess(RestApis.BASE_URL));
  }

  clearToken({String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key!);
  }

  getProfile({
    required OnSuccess onSuccess,
    required OnFailure onFailure,
    required TokenExpire tokenExpire,
  }) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.GET_PROFILE}?language=${prefs.get('lang')}";
    try {
      response = await http.get(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("fail to load Profile");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("fail to load Profile");
    }
  }

  logout({
    required OnSuccess onSuccess,
    required OnFailure onFailure,
    required TokenExpire tokenExpire,
  }) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await http.post(
        Uri.parse("https://powerhouse.tahadde.ae${RestApis.LOGOUT}"),
        headers: headerWithToken(prefs, "{}", HttpMethod.POST),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp['detail']);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("fail to logout");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("fail to logout");
    }
  }

  helperProfile(
      {required Map profileDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap(
      {
        "filePath": MultipartFile.fromBytes(
            profileDetail["profile_image"].readAsBytesSync(),
            filename:
                profileDetail["profile_image"].path.split('/').removeLast()),
        "fileOf": profileDetail["type"],
        "fileType": "I",
      },
    );

    try {
      Dio dio = Dio();
      dio.options.headers.addAll(
          {"Signing-Key": AppSigning.signature("{}", HttpMethod.POST, prefs)});
      var response = await dio.post(
        Uri.encodeFull(
            "https://powerhouse.tahadde.ae${RestApis.HELPERPROFILE}"),
        data: formData,
      );

      if (response.statusCode == 200) {
        var fileId = response.data["fileId"];
        onSuccess(fileId);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("fail to load image");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("fail to load image");
    }
  }

  helperMultiImage(
      {required Map pitchImage,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap(
      {
        "fileOf": pitchImage["type"],
        "fileType": "I",
      },
    );
    for (int i = 0; i < pitchImage["profile_image"].length; i++) {
      formData.files.addAll([
        MapEntry(
          "filePath",
          await MultipartFile.fromBytes(
              pitchImage["profile_image"][i].readAsBytesSync(),
              filename:
                  pitchImage["profile_image"][i].path.split('/').removeLast()),
        )
      ]);
    }
    try {
      Dio dio = Dio();
      dio.options.headers.addAll(
          {"Signing-Key": AppSigning.signature("{}", HttpMethod.POST, prefs)});
      var response = await dio.post(
        Uri.encodeFull("https://powerhouse.tahadde.ae${RestApis.MULTIIMAGE}"),
        data: formData,
      );

      if (response.statusCode == 200) {
        var fileId = response.data["fileId"];
        onSuccess(fileId);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("fail to load image");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("fail to load image");
    }
  }

  editProfileNoPic(
      {required Map profileDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response;
    var body = json.encode(profileDetail);

    try {
      response = await http.put(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.EDIT_USER_PROFILE}"),
          headers: headerWithToken(prefs, body, HttpMethod.PUT),
          body: body);

      if (response.statusCode == 200) {
        onSuccess("Your data edited");
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("failed to change profile");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("fail to change profile");
    }
  }

  login(
      {required Map loginDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(loginDetail);
    try {
      var baseUrl = 'https://powerhouse.tahadde.ae';
      var url = baseUrl + RestApis.LOGIN;
      response = await http.post(Uri.parse(url),
          headers: header(prefs, body, HttpMethod.POST), body: body);
      print(response.body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["role"]);
        saveToken(resp["key"]);
        saveRole(resp["role"]);
        authorizationSave(true);
      } else {
        onFailure("Incorrect Email and Password");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Please Check server$e");
    }
  }

  loginFacebook(
      {required Map loginDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(loginDetail);
    try {
      response = await http.post(
          Uri.parse("https://powerhouse.tahadde.ae${RestApis.LOGINFACEBOOK}"),
          headers: header(prefs, body, HttpMethod.POST),
          body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 409) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure("fail to facebook login");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Please Check server");
    }
  }

  loginGoogle(
      {required Map loginDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(loginDetail);
    try {
      response = await http.post(
          Uri.parse("https://powerhouse.tahadde.ae/api/v1/user/google-login/"),
          headers: header(prefs, body, HttpMethod.POST),
          body: body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        print('Seccess$response');
        onSuccess(resp);
      } else if (response.statusCode == 409) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure("fail to google login");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      print('Exception$e');
      onFailure("Please Check server");
    }
  }

  loginApple(
      {required Map loginDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(loginDetail);
    try {
      response = await http.post(
          Uri.parse("https://powerhouse.tahadde.ae${RestApis.LOGINAPPLE}"),
          headers: header(prefs, body, HttpMethod.POST),
          body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == 409) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure("fail to apple login");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Please Check server");
    }
  }

  leagueFilter(
      {required Map detail,
      required String language,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.DASHBOARDFILTER}?moduletype_slug=${detail["category"]}${detail["type"]}${detail["facility"]}&language=$language";
    try {
      print(url);
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      var resp = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        List<League> leagues = [];
        for (int i = 0; i < resp.length; i++) {
          // leagues.add(League.fromJson(resp[i]));
        }
        onSuccess(leagues);
      } else if (response.statusCode == 404) {
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  tournamentFilter(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.DASHBOARDFILTER}?moduletype_slug=${detail["category"]}${detail["type"] ?? ""}${detail["facility"] ?? ""}&language=${prefs.get("lang")}";
    try {
      response = await http.get(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );
      var resp = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        List<Turnament> tournament = [];
        for (int i = 0; i < resp.length; i++) {
          tournament.add(Turnament.fromJson(resp[i]));
        }
        onSuccess(tournament);
      } else if (response.statusCode == 404) {
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load tournament'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure('Failed to load tournament');
    }
  }

  verifiedPitch(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
        Uri.parse("https://powerhouse.tahadde.ae${RestApis.VERIFIED_PITCH}"),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );
      var resp = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        List<BookPitchDetail> bookPitch = [];
        for (int i = 0; i < resp.length; i++) {
          bookPitch.add(BookPitchDetail.fromJson(resp[i]));
        }
        onSuccess(bookPitch);
      } else if (response.statusCode == 404) {
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load pitch'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure('Failed to load pitch');
    }
  }

  bookpitchFilter(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.DASHBOARDFILTER}?moduletype_slug=${detail["category"]}${detail["type"] ?? ""}${detail["facility"] ?? ""}&language=${prefs.get("lang")}";

    try {
      response = await http.get(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );
      var resp = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        List<BookPitchDetail> bookPitch = [];
        for (int i = 0; i < resp.length; i++) {
          bookPitch.add(BookPitchDetail.fromJson(resp[i]));
        }
        onSuccess(bookPitch);
      } else if (response.statusCode == 404) {
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  tahaddiLeague(
      {required int id,
      required String event,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.YOURTAHADDI + id.toString()}/?tahaddis_for=$event&language=${prefs.get("lang")}";
    try {
      response = await http.get(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        League leagues = League.fromJson(resp);
        onSuccess(leagues);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Failed to load league");
    }
  }

  tahaddiTournament(
      {required int id,
      required String event,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.YOURTAHADDI + id.toString()}/?tahaddis_for=$event&language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        Turnament tournament = Turnament.fromJson(resp);

        onSuccess(tournament);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load tahadde tournament'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure('Failed to load tahadde tournament');
    }
  }

  tahaddiBookPitch(
      {required int id,
      required String event,
      required int ids,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.YOURTAHADDI + id.toString()}/?tahaddis_for=$event&pitchtype_id=$ids&language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<YourTahaddiBookPitchDetail> bookPitchDetail = [];
        for (int i = 0; i < resp.length; i++) {
          bookPitchDetail.add(YourTahaddiBookPitchDetail.fromJson(resp[i]));
        }
        onSuccess(bookPitchDetail);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        print(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load pitch'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure('Failed to load pitch');
    }
  }

  yourTahaddi(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.YOURTAHADDI}?language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<YourTahaddi> tahaddi = [];
        for (int i = 0; i < resp.length; i++) {
          tahaddi.add(YourTahaddi.fromJson(resp[i]));
        }
        onSuccess(tahaddi);
      } else if (response.statusCode == 404) {
        List<YourTahaddi> tahaddi = [];
        onSuccess(tahaddi);
      }
      // else if (response.statusCode == 400) {
      //   var resp = json.decode(utf8.decode(response.bodyBytes));
      //   print(resp);
      //
      // }
      else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load your tahaddi'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure('Failed to load your tahaddi');
    }
  }

  league(
      {required String urldetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.LEAGUE}?pitchtype_slug=$urldetail&language=${prefs.get("lang")}";

    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<League> leagues = [];
        for (int i = 0; i < resp.length; i++) {
          leagues.add(League.fromJson(resp[i]));
        }
        onSuccess(leagues);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure('Failed to load league');
    }
  }

  leagueDetail(
      {required int id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.LEAGUE}${id.toString()}/?language=${prefs.get("lang")}";

    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        League leagues = League.fromJson(resp);
        onSuccess(leagues);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure('Failed to load league');
    }
  }

  leagueOwner(
      {required bool filter,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(filter == true
              ? "https://powerhouse.tahadde.ae${RestApis.HOMELEAGUE}${prefs.get("lang")}"
              : "https://powerhouse.tahadde.ae${RestApis.HOMELEAGUESORT}${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<League> leagues = [];
        for (int i = 0; i < resp.length; i++) {
          leagues.add(League.fromJson(resp[i]));
        }
        onSuccess(leagues);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league owner'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Failed to load league owner");
    }
  }

  leagueOwnerDetail(
      {required int id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.LEAGUEDETAIL}$id/pitchowner/?language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        League leagues = League.fromJson(resp);
        onSuccess(leagues);
      } else {
        onFailure(throw Exception('Failed to load league detail'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Failed to load league detail");
    }
  }

  editLeagueOwnerDetail(
      {required var id,
      required Map bodyDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.LEAGUEDETAIL}${id.toString()}/pitchowner/?language=${prefs.get("lang")}";
    var body = json.encode(bodyDetail);
    try {
      response = await http.put(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.PUT), body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        League leagues = League.fromJson(resp);
        onSuccess(leagues);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));

        onFailure(resp["detail"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  tournamentOwnerDetail(
      {required int id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.TOURNAMENTDETAIL}$id/pitchowner/?language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        Turnament tournament = Turnament.fromJson(resp);

        onSuccess(tournament);
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  editTournamentOwnerDetail(
      {required var id,
      required Map bodyDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.TOURNAMENTDETAIL}${id.toString()}/pitchowner/?language=${prefs.get("lang")}";
    var body = json.encode(bodyDetail);
    try {
      response = await http.put(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.PUT), body: body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        Turnament tournament = Turnament.fromJson(resp);

        onSuccess(tournament);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));

        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  tournamentOwner(
      {required bool filter,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(filter == true
              ? "https://powerhouse.tahadde.ae${RestApis.HOMETOURNAMENT}${prefs.get("lang")}"
              : "https://powerhouse.tahadde.ae${RestApis.HOMETOURNAMENTSORT}${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<Turnament> tournament = [];
        for (int i = 0; i < resp.length; i++) {
          tournament.add(Turnament.fromJson(resp[i]));
        }
        onSuccess(tournament);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  tournament(
      {required String urldetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.TOURNAMENT}?pitchtype_slug=$urldetail&language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<Turnament> tournament = [];
        for (int i = 0; i < resp.length; i++) {
          tournament.add(Turnament.fromJson(resp[i]));
        }
        onSuccess(tournament);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  tournamentDetail(
      {required int id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.TOURNAMENT}${id.toString()}/?language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        Turnament tournament = Turnament.fromJson(resp);
        onSuccess(tournament);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  bookpitch(
      {required String? urldetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae/api/v1/bookpitch/pitchowner/pitch/player_available_pitches_list_details/?language=${prefs.get('lang')}";
    if (urldetail!.isNotEmpty) {
      url = "$url&sport_slug=$urldetail";
    }
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae/api/v1/bookpitch/pitchowner/pitch/player_available_pitches_list_details/?language=en"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load Book Pitch'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong$e");
      print(e);
    }
  }

  bookpitchdetail(
      {required Map urldetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.BOOKPITCH}${urldetail["id"].toString()}/?language=${urldetail["language"]}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        BookPitchDetail bookPitch = BookPitchDetail.fromJson(resp);
        onSuccess(bookPitch);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  verifiedPitchInfo(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.MY_VENUES}&language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<BookPitchDetail> bookPitch = [];
        for (int i = 0; i < resp.length; i++) {
          bookPitch.add(BookPitchDetail.fromJson(resp[i]));
        }
        onSuccess(bookPitch);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  verifiedPitchInfoDetail(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.MANAGESLOT} +${detail["id"]}/?pitch=${detail["pitch"]}${detail["language"]}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        BookPitchDetail bookPitch = BookPitchDetail.fromJson(resp);
        onSuccess(bookPitch);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  createSubPitch(
      {required Map bodydata,
      required String id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.MANAGESLOT}$id/subpitchtype/";
    // print(url);
    var body = json.encode(bodydata);
    try {
      response = await http.post(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.POST), body: body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        BookPitchDetail bookPitch = BookPitchDetail.fromJson(resp);
        onSuccess(bookPitch);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  deleteSubPitch(
      {required String id,
      required String pitchTypeId,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.MANAGESLOT}$id/subpitchtype/?pitchtype_id=$pitchTypeId";
    try {
      response = await http.delete(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.DELETE),
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));

        onSuccess(resp);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  inreviewPitchInfo(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.INREVIEW}&language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<BookPitchDetail> bookPitch = [];
        for (int i = 0; i < resp.length; i++) {
          bookPitch.add(BookPitchDetail.fromJson(resp[i]));
        }
        onSuccess(bookPitch);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  bookpitchSlot(
      {required Map urlDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.BOOKPITCHSLOT}${urlDetail["id"]}/slot/?year=${urlDetail["year"]}&month=${urlDetail["month"]}&pitchtype_id=${urlDetail["ids"]}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        BookPitchSlot slot = BookPitchSlot.fromJson(resp);
        onSuccess(slot);
      } else if (response.statusCode == 400) {
        onFailure("Month is not avalable");
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  pitchSlotCheck(
      {required Map urlDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.SLOTCHECK}${urlDetail["id"]}/see-specific-slot/?year=${urlDetail["year"]}&month=${urlDetail["month"]}&day=${urlDetail["day"]}&pitchtype_id=${urlDetail["idsPitch"]}&slot_ids=${urlDetail["ids"]}&language=${prefs.get("lang")}";
    print(url);
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["is_slot_available"]);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  bookpitchSlotConferm(
      {required Map urlDetail,
      required String slug,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "https://powerhouse.tahadde.ae${RestApis.BOOKPITCHSLOT}$slug";
    var body = json.encode(urlDetail);
    try {
      response = await http.post(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.POST), body: body);
      print("BookBitchConfirmed${response.body}");
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        print(resp);
        onSuccess(true);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  favorite(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae/api/v1/user/favourite/pitch/?language=${prefs.get("lang")}";
    var body = json.encode(detail);
    try {
      response = await http.put(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.PUT), body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        BookPitchDetail bookPitch = BookPitchDetail.fromJson(resp);
        onSuccess(bookPitch);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong $e");
    }
  }

  forgotPassword(
      {required String email,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> emailForgot = {"email": email};
    var body = json.encode(emailForgot);
    try {
      response = await http.post(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.FORGOT_PASSWORD}?language=${prefs.get("lang")}"),
          headers: header(
            prefs,
            body,
            HttpMethod.POST,
          ),
          body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp['success']);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("Something went wrong");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  changePassword(
      {required Map changeDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(changeDetail);
    try {
      response = await http.put(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.CHANGEPASSWORD}?language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, body, HttpMethod.PUT),
          body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp['success']);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("Current Password is not correct");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  resetPassword(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(detail);
    try {
      response = await http.put(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.RESETPASSWORD}?language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, body, HttpMethod.PUT),
          body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp['success']);
      } else {
        onFailure("Current Password is not correct");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  tokenStatus(
      {required Map token,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(token);
    try {
      response = await http.post(
          Uri.parse("https://powerhouse.tahadde.ae${RestApis.TOKENSTATUS}"),
          headers: headerWithToken(prefs, body, HttpMethod.POST),
          body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp['status']);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("Server is not responding");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  transection(
      {required String id,
      required String bookingPer,
      required Map tarnsectiondetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.TRANSECTION}$id/?transaction_for=bookpitch&booking_as_per=$bookingPer&language=${prefs.get("lang")}";
    print("Url Bro $url");
    var body = json.encode(tarnsectiondetail);
    try {
      final response = await http.post(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.POST), body: body);
      print("transaction${response.body}");
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp['success']);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp['error']);
      } else {
        onFailure("You already booked");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Server is not responding");
    }
  }

  cancelBooking(
      {required Map tarnsectiondetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "https://powerhouse.tahadde.ae${RestApis.CANCELBOOKING}";
    var body = json.encode(tarnsectiondetail);
    try {
      response = await http.post(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.POST), body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp['Status']);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp['error']);
      } else {
        onFailure("You already booked");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Server is not responding");
    }
  }

  bookingHistory(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.BOOKINGHISTORY}?language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<Event> event = [];
        for (int i = 0; i < resp.length; i++) {
          event.add(Event.fromJson(resp[i]));
        }
        onSuccess(event);
      } else if (response.statusCode == 404) {
        List<Event> event = [];
        onSuccess(event);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  bookingHistoryPitch(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.BOOKINGHISTORYPITCH}?language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<PitchHistory> pitch = [];
        for (int i = 0; i < resp.length; i++) {
          pitch.add(PitchHistory.fromJson(resp[i]));
        }
        onSuccess(pitch);
      } else if (response.statusCode == 404) {
        List<PitchHistory> pitch = [];
        onSuccess(pitch);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  verifyLeagueTournament(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire,
      required String id}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.VERIFYLEAGUETOURNAMENT}$id}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["success"]);
      } else if (response.statusCode == 409) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  checkInternetConnectivity({
    required OnSuccess onSuccess,
  }) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      onSuccess(true);
    } else if (result == ConnectivityResult.wifi) {
      onSuccess(true);
    } else {
      onSuccess(false);
    }
  }

  //dashboard facility
  dasBoard(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.DASHBOARD}?language=${prefs.get("lang")}";

    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));

        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  dashBoardPitchType(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.PITCHTYPEDASHBOARD}?language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  playerPosition(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.PLAYERPOSITION}?language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  spotsModerns(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.SPORTSMODERNS}?language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  sportsTypes(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.SPORTSTYPES}?language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  facility(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.FACILITY}?language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

////
  currentDate(
      {required String date,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "https://powerhouse.tahadde.ae${RestApis.CURRENTDATE}$date";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  booking(
      {required String date,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "https://powerhouse.tahadde.ae${RestApis.BOOKING}$date";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<BookingModelClass> pitch = [];
        for (int i = 0; i < resp.length; i++) {
          pitch.add(BookingModelClass.fromJson(resp[i]));
        }
        onSuccess(pitch);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  manageSlot(
      {required Map date,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.MANAGESLOT}${date["id"]}/manage-slot/?year=${date["year"]}&month=${date["month"]}&day=${date["day"]}&pitchtype_id=${date["pitchId"]}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        ManageSlotModelClass pitch = ManageSlotModelClass.fromJson(resp);
        onSuccess(pitch);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  manageSlotSend(
      {required Map date,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.MANAGESLOT}${date["id"]}/manage-slot/?slot_status=${date["status"]}&year=${date["year"]}&month=${date["month"]}&day=${date["day"]}&pitchtype_id=${date["pitchId"]}&slot_ids=${date["slotIds"]}";
    try {
      response = await http.put(Uri.parse(url),
          headers: headerWithToken(prefs, "{}", HttpMethod.PUT));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  closingHourSend(
      {required Map urlDate,
      required Map bodyDate,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.MANAGESLOT}${urlDate["id"]}/closed-hour/?slot_status=${urlDate["status"]}&pitchtype_id=${urlDate["pitchtype_id"]}";
    var body = json.encode(bodyDate);

    try {
      response = await http.put(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.PUT), body: body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  closingHourGet(
      {required Map urlDate,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.MANAGESLOT}${urlDate["id"]}/closed-hour/?pitchtype_id=${urlDate["pitchtype_id"]}";

    try {
      response = await http.get(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  addNewGround(
      {required Map body,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bodyData = json.encode(body);
    try {
      response = await http.post(
        Uri.parse("https://powerhouse.tahadde.ae${RestApis.MANAGESLOT}"),
        headers: headerWithToken(prefs, bodyData, HttpMethod.POST),
        body: bodyData,
      );
      if (response.statusCode == 201) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));

        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  editPitch(
      {required Map body,
      required Map urlDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.MANAGESLOT}${urlDetail['id']}/?pitch=${urlDetail['pitch']}&language=${urlDetail['language']}";
    var bodyData = json.encode(body);
    try {
      response = await http.put(
        Uri.parse(url),
        headers: headerWithToken(prefs, bodyData, HttpMethod.PUT),
        body: bodyData,
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load slot'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

////

  //team
  teamList(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.TEAMLISTING}?language=${prefs.get("lang")}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<TeamModelClass> team = [];
        for (int i = 0; i < resp.length; i++) {
          team.add(TeamModelClass.fromJson(resp[i]));
        }
        onSuccess(team);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  creatTeam(
      {required Map detail,
      required String teamType,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.CREATTEAM}$teamType&language=${prefs.get("lang")}";
    var body = json.encode(detail);
    try {
      response = await http.post(
        Uri.parse(url),
        headers: headerWithToken(prefs, body, HttpMethod.POST),
        body: body,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        TeamModelClass teamInfoData = TeamModelClass.fromJson(resp);
        onSuccess(teamInfoData);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to fail to create team'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception("Failed to fail to create team");
    }
  }

  searchPlayer(
      {required String search,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode;
    if (search == "") {
      languageCode = "?language=";
    } else {
      languageCode = "&language=";
    }
    String url =
        "https://powerhouse.tahadde.ae${RestApis.SEARCHPLAYER}$search$languageCode${prefs.get("lang")}";
    try {
      response = await http.get(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<SearchPlayerModelClass> searchData = [];
        for (int i = 0; i < resp.length; i++) {
          searchData.add(SearchPlayerModelClass.fromJson(resp[i]));
        }
        onSuccess(searchData);
      } else {
        onFailure(throw Exception('Failed to search player'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Failed to search player");
    }
  }

  teamInfo(
      {required OnSuccess onSuccess,
      required String teamType,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        ("https://powerhouse.tahadde.ae${RestApis.TEAMINFO}$teamType&language=${prefs.get("lang")}");

    try {
      response = await http.get(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        TeamModelClass teamInfoData = TeamModelClass.fromJson(resp);
        onSuccess(teamInfoData);
      } else if (response.statusCode == 400) {
        Null teamInfoData = null;
        onSuccess(teamInfoData);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load team info'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load team info');
    }
  }

  deleteTeam(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.delete(
        Uri.parse(
            "https://powerhouse.tahadde.ae${RestApis.CREATTEAM}?language=${prefs.get("lang")}"),
        headers: headerWithToken(prefs, "", HttpMethod.DELETE),
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure(throw Exception('Failed to delete team'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to delete team');
    }
  }

  deleteAccount(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.delete(
        Uri.parse("https://powerhouse.tahadde.ae${RestApis.DELETEACCOUNT}"),
        headers: headerWithToken(prefs, "", HttpMethod.DELETE),
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure(throw Exception('Failed to delete team'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to delete team');
    }
  }

  captonAssign(
      {required int id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode({"member_id": id});
    try {
      response = await http.post(
          Uri.parse("https://powerhouse.tahadde.ae${RestApis.ASSIGNCAPTAIN}"),
          headers: headerWithToken(prefs, body, HttpMethod.POST),
          body: body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to assign caption'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to assign caption');
    }
  }

  deletePlayer(
      {required String id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.PLAYERTEAM}$id/?language=${prefs.get("lang")}";
    try {
      response = await http.delete(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.DELETE),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));

        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to delete player'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to delete player');
    }
  }

  playerInvitationSend(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(detail);

    try {
      response = await http.post(
        Uri.parse(
            "https://powerhouse.tahadde.ae${RestApis.PLAYERINVITATIONSEND}?language=${prefs.get("lang")}"),
        headers: headerWithToken(prefs, body, HttpMethod.POST),
        body: body,
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
      } else if (response.statusCode == 409) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to send invitation'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to send invitation');
    }
  }

  playerInvitationReceive(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await http.get(
        Uri.parse(
            "https://powerhouse.tahadde.ae${RestApis.PLAYERINVITATIONSEND}?language=${prefs.get("lang")}"),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure(throw Exception('Failed to receive invitation'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to receive invitation');
    }
  }

  playerInvitationAccept(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.PLAYERINVITATIONSEND}${detail["id"]}/?invitation=${detail["type"]}&language=${prefs.get("lang")}";

    try {
      response = await http.put(
        Uri.parse(url),
        headers: headerWithToken(prefs, "{}", HttpMethod.PUT),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to accept invitation'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to accept invitation');
    }
  }

  player(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.PLAYERTEAM}?language=${prefs.get("lang")}";

    try {
      response = await http.get(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<TeamModelClass> team = [];
        for (int i = 0; i < resp.length; i++) {
          team.add(TeamModelClass.fromJson(resp[i]));
        }
        onSuccess(team);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load player'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load player');
    }
  }

  captainMember(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await http.get(
        Uri.parse(
            "https://powerhouse.tahadde.ae${RestApis.CREATTEAM}?language=${prefs.get("lang")}"),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        TeamModelClass team = TeamModelClass.fromJson(resp);
        onSuccess(team);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load '));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  captainPendind(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await http.get(
        Uri.parse(
            "https://powerhouse.tahadde.ae${RestApis.CAPTAININVITATION}?language=${prefs.get("lang")}"),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure(throw Exception('Failed to load '));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  captainInvitationAccept(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.CAPTAININVITATION}${detail["id"]}/?invitation=${detail["type"]}&language=${prefs.get("lang")}";

    try {
      response = await http.put(
        Uri.parse(url),
        headers: headerWithToken(prefs, "{}", HttpMethod.PUT),
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["detail"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to accept invitation'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  captainInvitationSend(
      {required Map id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(id);
    try {
      response = await http.post(
        Uri.parse(
            "https://powerhouse.tahadde.ae${RestApis.CAPTAININVITATION}?language=${prefs.get("lang")}"),
        headers: headerWithToken(prefs, body, HttpMethod.POST),
        body: body,
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to send invitation'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  myInterest(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await http.get(
        Uri.parse("https://powerhouse.tahadde.ae${RestApis.MYINTEREST}"),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["detail"]);
      } else {
        onFailure(throw Exception('Failed to load rating'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  //rating
  ratingGet(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      response = await http.get(
        Uri.parse("https://powerhouse.tahadde.ae${RestApis.RATING}"),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load rating'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  ratingSend(
      {required Map detail,
      required String id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        ("https://powerhouse.tahadde.ae${RestApis.RATINGSEND}$id/rating/");
    var body = json.encode(detail);
    try {
      response = await http.put(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.PUT), body: body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["detail"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to send rating'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to send rating');
    }
  }

  //notification
  notificationGet(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.NOTIFICATION}${prefs.get("lang")}";

    try {
      response = await http.get(
        Uri.parse(url),
        headers: headerWithToken(prefs, "", HttpMethod.GET),
      );
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == 500) {
        onFailure("server error");
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load notification'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load notification');
    }
  }

  role({
    required OnSuccess onSuccess,
    required OnFailure onFailure,
  }) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(("https://powerhouse.tahadde.ae${RestApis.ROLE}")),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load role');
    }
  }

  //MYFAATOORAH
  transectionToken({
    required OnSuccess onSuccess,
    required OnFailure onFailure,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.TRANSECTIONTOKEN}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      // print('Token${response.body}');
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 500) {
        onFailure("Server Error");
        //tokenExpire();
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      print('TokenError$e');
      throw Exception('Failed to load Token');
    }
  }

  transectionStatus({
    required OnSuccess onSuccess,
    required OnFailure onFailure,
    required Map paymentId,
  }) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(paymentId);
    try {
      response = await http.post(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.TRANSECTIONSTATUS}"),
          headers: headerWithToken(prefs, body, HttpMethod.POST),
          body: body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 401) {
        onFailure("Server Error");
        //tokenExpire();
      } else if (response.statusCode == 500) {
        onFailure("Server Error");
        //tokenExpire();
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load Token');
    }
  }

  getAddress(
      {required Map LatLong,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LatLong["language"] = prefs.get("lang");
    var body = json.encode(LatLong);
    try {
      response = await http.post(
        Uri.parse(("https://powerhouse.tahadde.ae${RestApis.LATLONG}")),
        headers: headerWithToken(prefs, body, HttpMethod.POST),
        body: body,
      );
      print("get address${response.body}");
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  //privacy policy
  privacyPolicy(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String url =
          ("https://powerhouse.tahadde.ae${RestApis.PRIVACYPOLICY}${prefs.get("lang")}");
      // print(url);
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.PRIVACYPOLICY}${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      // print('${response.body}');
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load role');
    }
  }

  sportsList(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae/api/v1/helpers/sportslistmobile/?language=${prefs.get('lang')}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load role');
    }
  }

  sportsExperienceList(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.SPORTS_ECPERIENCE_LIST}${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load role');
    }
  }

  weekList(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.WEEK_LIST}${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load role');
    }
  }

  slotList(
      {required OnSuccess onSuccess,
      required String id,
      required String subPitchId,
      required String weekDay,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.SLOT_LIST}$id/manage-slot/?pitchtype_id=$subPitchId&weekday=$weekDay&language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      print(response.body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load role');
    }
  }

  createSession(
      {required OnSuccess onSuccess,
      required detail,
      required id,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(detail);
    try {
      response = await http.post(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.CREATE_SESSION}$id/manage-slot/?language=${prefs.get("lang")}"),
          body: body,
          headers: headerWithToken(prefs, body, HttpMethod.POST));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 400) {
        onFailure("null");
        //tokenExpire();
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load role');
    }
  }

  availablePitchType(
      {required String sportTypeSlug,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.AVAILABLE_PITCH_TYPE}$sportTypeSlug"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load role');
    }
  }

  createVenue(
      {required Map detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = json.encode(detail);
    print("Map$detail");
    try {
      response = await http.post(
          Uri.parse("https://powerhouse.tahadde.ae${RestApis.CREATE_VENUE}"),
          headers: headerWithToken(prefs, body, HttpMethod.POST),
          body: body);
      print("create Vanue${response.body}");
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure("fail to create league");
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("fail to create league");
      print("ExceptionVaniue$e");
    }
  }

  availableDoc(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse("https://powerhouse.tahadde.ae${RestApis.AVAILABLE_DOC}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        onFailure("null");
        //tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load role'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      throw Exception('Failed to load role');
    }
  }

  updateSlot(
      {required Map<dynamic, dynamic> detail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.UPDATE_SLOT}?language=${prefs.get("lang")}";
    var body = json.encode(detail);
    try {
      response = await http.put(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.PUT), body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  myVenues(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.MY_VENUES}?language=${prefs.get("lang")}"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<MyVenueModelClass> bookPitch = [];
        for (int i = 0; i < resp.length; i++) {
          bookPitch.add(MyVenueModelClass.fromJson(resp[i]));
        }
        onSuccess(bookPitch);
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  specificVenue(
      {required String id,
      String subPitch = "",
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await http.get(
          Uri.parse(
              "https://powerhouse.tahadde.ae${RestApis.SPECIFIC_PITCH}$id/?language=${prefs.get("lang")}$subPitch"),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(SpecificModelClass.fromJson(resp));
      } else if (response.statusCode == 404) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  deletePitch(
      {required String id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.DELETE_PITCH}$id/?language=${prefs.get("lang")}";

    try {
      response = await http.put(
        Uri.parse(url),
        headers: headerWithToken(prefs, "{}", HttpMethod.PUT),
      );

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(resp["success"]);
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp["error"]);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  editVenue(
      {required String id,
      required String venueType,
      required Map venueDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.EDIT_VENUE}$id/?pitch=$venueType&language=${prefs.get("lang")}";
    var body = json.encode(venueDetail);
    try {
      response = await http.put(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.PUT), body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(SpecificModelClass.fromJson(resp));
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  editSession(
      {required String id,
      required String venueType,
      required Map venueDetail,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.UPDATE_SESSIONS}$id/?pitch=$venueType&language=${prefs.get("lang")}";
    var body = json.encode(venueDetail);
    try {
      response = await http.put(Uri.parse(url),
          headers: headerWithToken(prefs, body, HttpMethod.PUT), body: body);

      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(SpecificModelClass.fromJson(resp));
      } else if (response.statusCode == 400) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onFailure(resp);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  venueDetail(
      {required String id,
      required String subPitchId,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae/api/v1/bookpitch/pitchowner/pitch/player_available_pitches_list_details/?pitch_id=$id&subpitch_id=$subPitchId&language=${prefs.get("lang")}";
    // print(url);
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));

      if (response.statusCode == 200) {
        // print("Response${response.body}");
        var resp = json.decode(utf8.decode(response.bodyBytes));
        onSuccess(SpecificVenueModelClass.fromJson(resp));
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  slotDetail(
      {required String id,
      required String dateTime,
      required String subPitchId,
      required String date,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.SLOT_DETAIL}$id/players_see_specific_pitch_slots/?pitchtype_id=$subPitchId&booked_for_date=$date&language=${prefs.get("lang")}$dateTime";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      // print("hhh${response.body}");
      if (response.statusCode == 200) {
        // print("hhh${response.body}");
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<SlotModelClass> slotModelClass = [];
        for (int i = 0; i < resp.length; i++) {
          slotModelClass.add(SlotModelClass.fromJson(resp[i]));
        }
        onSuccess(slotModelClass);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      print("Exceptionalist${e.toString()}");
    }
  }

  getPromotion(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.PROMOTION}${prefs.get("lang")}&city_id=${prefs.get("cityId")}";
    try {
      // print(url);
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<PromotionModelClass> slotModelClass = [];
        for (int i = 0; i < resp.length; i++) {
          slotModelClass.add(PromotionModelClass.fromJson(resp[i]));
        }
        onSuccess(slotModelClass);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  getSpecificPromotion(
      {required String id,
      required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae${RestApis.PROMOTION}${prefs.get("lang")}&promotional_event_id=$id";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<PromotionModelClass> slotModelClass = [];
        for (int i = 0; i < resp.length; i++) {
          slotModelClass.add(PromotionModelClass.fromJson(resp[i]));
        }
        onSuccess(slotModelClass);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }

  getTerritory(
      {required OnSuccess onSuccess,
      required OnFailure onFailure,
      required TokenExpire tokenExpire}) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "https://powerhouse.tahadde.ae/api/v1/dashboard/territory/list/?language=${prefs.get('lang')}";
    try {
      response = await http.get(Uri.parse(url),
          headers: headerWithToken(prefs, "", HttpMethod.GET));
      // print(response.body);
      if (response.statusCode == 200) {
        var resp = json.decode(utf8.decode(response.bodyBytes));
        List<TerritoryModelClass> slotModelClass = [];
        for (int i = 0; i < resp.length; i++) {
          slotModelClass.add(TerritoryModelClass.fromJson(resp[i]));
        }
        onSuccess(slotModelClass);
      } else if (response.statusCode == tokenExpireStatus) {
        tokenExpire();
      } else {
        onFailure(throw Exception('Failed to load league'));
      }
    } on SocketException catch (_) {
      onFailure(internetStatus);
    } catch (e) {
      onFailure("Something went wrong");
    }
  }
}

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HttpMethod { POST, GET, PUT, DELETE }

class AppSigning {
  static String signature(
      String data, HttpMethod method, SharedPreferences prefs) {
    //String baseUrl="http://19901e95f869.ngrok.io";
    String baseUrl = "https://powerhouse.tahadde.ae";
    var methodName;
    var effectiveData;
    switch (method) {
      case HttpMethod.POST:
        methodName = "POST";
        effectiveData = data;
        break;
      case HttpMethod.GET:
        methodName = "GET";
        effectiveData = "";
        break;
      case HttpMethod.DELETE:
        methodName = "DELETE";
        effectiveData = "";
        break;
      case HttpMethod.PUT:
        methodName = "PUT";
        effectiveData = data;
        break;
    }
    var secretKey;
    var currentUrl = prefs.get("baseUrl");
    if (currentUrl == null || currentUrl == baseUrl) {
      secretKey =
      "dZ0cEP7OWiBmTC2I44U8GPgE75Y3Xxdl93OTU2bd0tU6yIKYHUthEtavqzvkRXvXjPdmmR69o3on3UxCZz0SJMRGBOv6QrVGZtnA";
    } else {
      secretKey =
      '7aCDPUqjET7Mfnkbjm2zGpxq44rBkvGUebVNFqaM8jeWBAsRmTCXmW3GGPFhmvqCZ59mULPNeXe2w9D5aQq7vDqjNb9Uh733czZm';
    }
    var key = utf8.encode(secretKey);
    var bytes = utf8.encode("$secretKey-$methodName-$effectiveData");
    var hmacSha256 = new Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    print((base64Encode(digest.bytes)).toString());
    return base64Encode(digest.bytes);
  }
}

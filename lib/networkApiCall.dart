// import 'dart:convert';
// import 'dart:developer';
// // import 'package:fifa/helper/interceptor_helper.dart';
// // import 'package:fifa/helper/shared_preferences.dart';
// // import 'package:fifa/utils/appconfig.dart';
// // import 'package:fifa/utils/exception/app_exception.dart';
// import 'package:http/http.dart' as http;
// // import 'package:http_interceptor/http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class NetworkAPICall {
//   static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();
//   factory NetworkAPICall() {
//     return _networkAPICall;
//   }
//
//   NetworkAPICall._internal();
//   static String baseUrl = AppConfig.baseUrl;
//   static http.Client get dio => InterceptedClient.build(interceptors: [
//     LoggerInterceptor(),
//   ]);
//   Future<dynamic> post(String url, {Map<String, String>? header, dynamic body}) async {
//     try {
//       final String fullURL = baseUrl + url;
//       final response = await dio.post(Uri.parse(fullURL), body: body, headers: header);
//       log("Post Api Url ===> $fullURL");
//       log("Post Api  Header ===> ${response.headers}");
//       log("Post Api StatusCode ===> ${response.statusCode}");
//       log("Post Api response ===> $response");
//       return checkResponse(response);
//     } catch (e) {
//       log("Post Api Error--->$e");
//       dio.close();
//       rethrow;
//     }
//   }
//   // Future<dynamic> get(String url, {Map<String, String>? header}) async {
//   //   // SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   // var token1 = prefs.getString("token");
//   //   // log("token-->$token1");
//   //   // final headers = {"Authorization": "Bearer $token1"};
//   //   try {
//   //     final String fullURL = baseUrl + url;
//   //     final response = await dio.get(Uri.parse(fullURL), headers: header);
//   //     log("Get Api Url ===> $fullURL");
//   //     log("Get Api  Header ===> ${header}");
//   //     log("Get Api StatusCode ===> ${response.statusCode}");
//   //     log("Get Api body ===> ${response.body}");
//   //     return checkResponse(response);
//   //   } catch (e) {
//   //     log("Get Api Error--->$e");
//   //     dio.close();
//   //     rethrow;
//   //   }
//   // }
//   // Future delete({required String url}) async {
//   //   try {
//   //     String? token1 = await SharedPrefs.getUser();
//   //     final header = {"Authorization": "Bearer $token1"};
//   //     final response = await dio.delete(Uri.parse(url), headers: header);
//   //     log("Delete Api Url ===> $url");
//   //     log("Delete Api  Header ===> ${response.headers}");
//   //     log("Delete Api StatusCode ===> ${response.statusCode}");
//   //     return response;
//   //   } catch (e) {
//   //     log("Delete Api Error ===> $e");
//   //     dio.close();
//   //     rethrow;
//   //   }
//   // }
//   //
//   // Future<dynamic> put(String url, {Map<String, String>? header, dynamic body}) async {
//   //   try {
//   //     final String fullURL = baseUrl + url;
//   //     final response = await dio.put(Uri.parse(fullURL), headers: header);
//   //     log("Put Api Url ===> $fullURL");
//   //     log("Put Api  Header ===> $header");
//   //     log("Put Api StatusCode ===> ${response.statusCode}");
//   //     return response;
//   //   } catch (e) {
//   //     log("Put Api Error ===> $e");
//   //     dio.close();
//   //     rethrow;
//   //   }
//   // }
//   // dynamic checkResponse(http.Response? response) {
//   //   try {
//   //     if (response != null) {
//   //       switch (response.statusCode) {
//   //         case 200:
//   //           try {
//   //             if (response.body.isEmpty) {
//   //               throw AppException(message: 'Response body is empty', errorCode: 0);
//   //             } else {
//   //               return jsonDecode(response.body);
//   //             }
//   //           } catch (e) {
//   //             rethrow;
//   //           }
//   //         case 201:
//   //           return response;
//   //         case 400:
//   //           throw AppException(message: jsonDecode(response.body)['apierror']['description'], errorCode: 0);
//   //         default:
//   //           try {
//   //             if (response.body.isEmpty) {
//   //               throw AppException(message: 'Response body is empty', errorCode: response.statusCode);
//   //             }
//   //             jsonDecode(response.body);
//   //           } catch (e) {
//   //             rethrow;
//   //           }
//   //       }
//   //     } else {
//   //       return null;
//   //     }
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }
// }

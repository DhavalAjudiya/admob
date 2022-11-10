import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'dart:math';
import 'package:testadmob/stream/modal.dart';
import 'package:http/http.dart' as http;

class MatchController {
  static final MatchController _matchController = MatchController.init();

  factory MatchController() {
    return _matchController;
  }

  MatchController.init();

  // NetworkAPICall _networkAPICall = NetworkAPICall();

  Future<List<Example>?> getMatches() async {
    print("Api Service");
    try {
      final response = await http.post(Uri.parse("http://Sgcricketnew.cricketfeed.co.in/api/values/LiveSeries"), body: {}, headers: {});
      developer.log('testsdhsad code: ${response.statusCode} body ${response.body}');

      List jsonsString = convert.jsonDecode(response.body);
      developer.log('testsdhsad jsonsString: $jsonsString');

      List<Example> data = jsonsString.map((e) => Example.fromJson(e)).toList();
      developer.log('testsdhsad data: ${data.length}');
      return data;
    } catch (e, stackTrace) {
      print("Error---------$e");
    }
  }
}

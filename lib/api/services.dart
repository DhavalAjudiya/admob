import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testadmob/api/modal.dart';

class FetchApiService {
  static Stream<HomePageModel> messageFlow() {
    return Stream.fromFuture(getFetchData());
  }

  static Future<HomePageModel> getFetchData() async {
    print("-------00000--------}");

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzUwY2I3ZjY2YjM3ZGQ4YmM5NGE1NzAyZmVjODE3NTQ1N2IwM2QwNTI5ODJiY2Y3NGI0MDcxYjNkMWM0MDZiN2ViMDIxMjZjNDA0YmRmOTMiLCJpYXQiOjE2NTU5NzcwMDcuMDkzNjM0LCJuYmYiOjE2NTU5NzcwMDcuMDkzNjM4LCJleHAiOjE2ODc1MTMwMDcuMDg5MDAxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Wud5Dh49ABXylI70dhPDqNeRr5Q3wKwI9KTcx_MQ1j5v30EtcHw0TZhdnO2U0iXvP5lK-iJnn-0s7160VKv_9clFr-p9Qx4EQGq3FO_omltIS2rFICJ-ZEA3bYxDzXFteAbqmMR4FFrMHUsS_ww44vtYIIuhlu9TbqSOcP6nCctneE7DbHWurLCCI2BOdppTbGUKYd8t758QhN3kwyxw5oPsQAFu_mRTEhfTrQZ7hiaQiSXQE1JTfODJ6XuwRA9pXuhRpBx-lDDNjUEoY-BHYJ94CmnG2-czXi4DnkLieIq6Z6dyyL-QW5a02hKaJCHKFCpFKdFxU7r3QV_e50R_U7wYbP97BRFBbhXv4HRJXX9BQ1b9o64b2sYYgYqPLxUwtrmYusYk1Uf_7PwEb2_G-G87oEmylyK16V4nGFNswxr5ma8Ao2vFFhAYd5hFvVac_YpHDvrA0AhBISOB5PikWhPxFGXtLUdqoyKN9WG9FCICRNUa0yps2dO5MUaJAQG8ojR7E726cjAUJNAgdsnczHavtclvvrW0L0s6dQzMtgOs47_VCGJE2ssDR6lgAm-DweoTdIWc1lLNjzNZUB_WBVBX-umEOPWgOz31f0o9dLWlMME3Bg4c1F6X70iWBTbONHHaWUJkUPGsP_X7BdqKAbeIfTMXYJ7U75EMFSpcYpo",
    };
    print("-------111111--------}");

    final result = await http.get(
      Uri.parse("http://grapwine.technologiesninja.com/api/fetch?page=0"),
      headers: headers,
    );
    print("-------222222--------}");

    // print("22222222----->>${result.body}");
    // var jsonData = json.decode(result.body);
    // List<HomePageModel> messages = [];
    // print("-------333333--------}");
    //
    // for (var m in jsonData) {
    //   HomePageModel message = HomePageModel.fromJson(m);
    //   messages.add(message);
    //   print("-------4444444--------}");
    // }
    return HomePageModel.fromJson(json.decode(result.body));
  }
}

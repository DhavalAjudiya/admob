// To parse this JSON data, do
//
//     final example = exampleFromJson(jsonString);

import 'dart:convert';

// List<Example> exampleFromJson(String str) => List<Example>.from(json.decode(str).map((x) => Example.fromJson(x)));
//
// String exampleToJson(List<Example> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Example {
  Example({
    this.seriesname,
    this.seriesid,
    this.startdate,
    this.enddate,
  });

  String? seriesname;
  int? seriesid;
  String? startdate;
  String? enddate;

  factory Example.fromJson(Map<String, dynamic> json) => Example(
        seriesname: json["seriesname"],
        seriesid: json["seriesid"],
        startdate: json["startdate"],
        enddate: json["enddate"],
      );

  Map<String, dynamic> toJson() => {
        "seriesname": seriesname,
        "seriesid": seriesid,
        "startdate": startdate,
        "enddate": enddate,
      };
}

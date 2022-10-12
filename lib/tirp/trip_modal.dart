import 'dart:convert';

TripModal tripModalFromJson(String str) => TripModal.fromJson(json.decode(str));

String tripModalToJson(TripModal data) => json.encode(data.toJson());

class TripModal {
  TripModal({
    this.place,
    this.payer,
    this.amount,
  });

  String? place;
  String? payer;
  int? amount;

  factory TripModal.fromJson(Map<String, dynamic> json) => TripModal(
        place: json["place"],
        payer: json["payer"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "place": place,
        "payer": payer,
        "amount": amount,
      };
}

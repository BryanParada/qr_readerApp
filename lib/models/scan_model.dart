// To parse this JSON data, do
//
//     final trailerReponse = trailerReponseFromJson(jsonString);

import 'dart:convert';

TrailerReponse trailerReponseFromJson(String str) => TrailerReponse.fromJson(json.decode(str));

String trailerReponseToJson(TrailerReponse data) => json.encode(data.toJson());

class TrailerReponse {
    TrailerReponse({
        required this.id,
        required this.type,
        required this.value,
    }) {

      if (this.type.contains('http')){
        this.type = 'http';
      }else{
        this.type = 'geo';
      }
    }

    int id;
    String type;
    String value;

    factory TrailerReponse.fromJson(Map<String, dynamic> json) => TrailerReponse(
        id: json["id"],
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
    };
}

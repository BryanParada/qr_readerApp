// To parse this JSON data, do
//
//     final trailerReponse = trailerReponseFromJson(jsonString);

import 'dart:convert';

ScanModel trailerReponseFromJson(String str) => ScanModel.fromJson(json.decode(str));

String trailerReponseToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    ScanModel({
        this.id,
        this.type,
        required this.value,
    }) {

      if (this.value.contains('http')){
        this.type = 'http';
      }else{
        this.type = 'geo';
      }
    }

    int? id;
    String? type;
    String value;

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
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

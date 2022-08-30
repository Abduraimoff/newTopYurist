// To parse this JSON data, do
//
//     final regionsResponse = regionsResponseFromJson(jsonString);

import 'dart:convert';

  List<RegionsResponse> regionsResponseFromJson(List str) => List<RegionsResponse>.from(str.map((x) => RegionsResponse.fromJson(x)).toList());

String regionsResponseToJson(List<RegionsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegionsResponse {
  RegionsResponse({
    this.id,
    this.title,
    this.sort,
    this.application_count,
  });

  final dynamic id;
  final Title? title;
  final int? sort;
  final int? application_count;
  factory RegionsResponse.fromJson(Map<String, dynamic> json) => RegionsResponse(
    id: json["id"],
    title: Title.fromJson(json["title"]),
    sort: json["sort"],
    application_count: json["application_count"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title?.toJson(),
    "sort": sort,
    "application_count": application_count,
  };
}

class Title {
  Title({
    this.usEn,
    this.ruRu,
    this.uzLat,
    this.uzUz,
  });

  final String? usEn;
  final String? ruRu;
  final String? uzLat;
  final String? uzUz;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    usEn:   json["us_en"],
    ruRu:   json["ru_ru"],
    uzLat:  json["uz_lat"],
    uzUz:   json["uz_uz"],
  );

  Map<String, dynamic> toJson() => {
    "us_en": usEn,
    "ru_ru": ruRu,
    "uz_lat": uzLat,
    "uz_uz": uzUz,
  };
}

// To parse this JSON data, do
//
//     final imageResponse = imageResponseFromJson(jsonString);

import 'dart:convert';

ImageResponse imageResponseFromJson(String str) => ImageResponse.fromJson(json.decode(str));

String imageResponseToJson(ImageResponse data) => json.encode(data.toJson());

class ImageResponse {
  ImageResponse({
    this.name,
    this.path,
    this.fullPath,
    this.size,
    this.type,
    this.children,
    this.statusCode,
    this.error
  });

  String? name;
  String? path;
  String? fullPath;
  int? size;
  String? type;
  int? children;
  int? statusCode;
  Object? error;

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
    name: json["name"],
    path: json["path"],
    fullPath: json["fullPath"],
    size: json["size"],
    type: json["type"],
    children: json["children"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "path": path,
    "fullPath": fullPath,
    "size": size,
    "type": type,
    "children": children,
  };
}

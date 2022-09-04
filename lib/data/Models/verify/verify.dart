import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify.g.dart';

enum InstutionType { study, job }

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Verify extends Equatable {
  String? title;
  String? description;
  String? passportFrontPhoto;
  String? passportBackPhoto;
  String? diplomaPhoto;
  String? licensePhoto;
  String? extractPhoto;
  String? civilLicensePhoto;
  List<Instution>? studies;
  List<Instution>? jobs;
  Verify({
    this.title,
    this.description,
    this.passportFrontPhoto,
    this.passportBackPhoto,
    this.diplomaPhoto,
    this.licensePhoto,
    this.extractPhoto,
    this.civilLicensePhoto,
    this.studies,
    this.jobs,
  });

  factory Verify.fromJson(Map<String, dynamic> json) => _$VerifyFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyToJson(this);

  Verify copyWith({
    String? title,
    String? description,
    String? passportFrontPhoto,
    String? passportBackPhoto,
    String? diplomaPhoto,
    String? licensePhoto,
    String? extractPhoto,
    String? civilLicensePhoto,
    List<Instution>? studies,
    List<Instution>? jobs,
  }) {
    return Verify(
      title: title ?? this.title,
      description: description ?? this.description,
      passportFrontPhoto: passportFrontPhoto ?? this.passportFrontPhoto,
      passportBackPhoto: passportBackPhoto ?? this.passportBackPhoto,
      diplomaPhoto: diplomaPhoto ?? this.diplomaPhoto,
      licensePhoto: licensePhoto ?? this.licensePhoto,
      extractPhoto: extractPhoto ?? this.extractPhoto,
      civilLicensePhoto: civilLicensePhoto ?? this.civilLicensePhoto,
      studies: studies ?? this.studies,
      jobs: jobs ?? this.jobs,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        passportFrontPhoto,
        passportBackPhoto,
        diplomaPhoto,
        licensePhoto,
        extractPhoto,
        civilLicensePhoto,
        studies,
        jobs,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Instution extends Equatable {
  String? id;
  String title;
  int? sort;
  String? startAt;
  String? endAt;
  Instution({
    this.id,
    required this.title,
    this.sort,
    this.startAt,
    this.endAt,
  });

  factory Instution.fromJson(Map<String, dynamic> json) =>
      _$InstutionFromJson(json);
  Map<String, dynamic> toJson() => _$InstutionToJson(this);

  @override
  List<Object?> get props => [id, title, sort, startAt, endAt];

  Instution copyWith({
    String? id,
    String? title,
    int? sort,
    String? startAt,
    String? endAt,
  }) {
    return Instution(
      id: id ?? this.id,
      title: title ?? this.title,
      sort: sort ?? this.sort,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Verify _$VerifyFromJson(Map<String, dynamic> json) => Verify(
      title: json['title'] as String?,
      description: json['description'] as String?,
      passportFrontPhoto: json['passport_front_photo'] as String?,
      passportBackPhoto: json['passport_back_photo'] as String?,
      diplomaPhoto: json['diploma_photo'] as String?,
      licensePhoto: json['license_photo'] as String?,
      extractPhoto: json['extract_photo'] as String?,
      civilLicensePhoto: json['civil_license_photo'] as String?,
      studies: (json['studies'] as List<dynamic>?)
          ?.map((e) => Instution.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((e) => Instution.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VerifyToJson(Verify instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'passport_front_photo': instance.passportFrontPhoto,
      'passport_back_photo': instance.passportBackPhoto,
      'diploma_photo': instance.diplomaPhoto,
      'license_photo': instance.licensePhoto,
      'extract_photo': instance.extractPhoto,
      'civil_license_photo': instance.civilLicensePhoto,
      'studies': instance.studies?.map((e) => e.toJson()).toList(),
      'jobs': instance.jobs?.map((e) => e.toJson()).toList(),
    };

Instution _$InstutionFromJson(Map<String, dynamic> json) => Instution(
      id: json['id'] as String?,
      title: json['title'] as String,
      sort: json['sort'] as int?,
      startAt: json['start_at'] as String?,
      endAt: json['end_at'] as String?,
    );

Map<String, dynamic> _$InstutionToJson(Instution instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sort': instance.sort,
      'start_at': instance.startAt,
      'end_at': instance.endAt,
    };

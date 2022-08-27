class Verify {
  String? title;
  String? description;
  String? passportFrontPhoto;
  String? passportBackPhoto;
  String? diplomaPhoto;
  String? licensePhoto;
  String? extractPhoto;
  String? civilLicensePhoto;
  List<Studie>? studies;
  List<Job>? jobs;
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
}

class Studie {
  final int? id;
  final String title;
  final int? sort;
  final String? startAt;
  final String? endAt;
  Studie({
    this.id,
    required this.title,
    this.sort,
    this.startAt,
    this.endAt,
  });
}

class Job {
  final int? id;
  final String title;
  final int? sort;
  final String? startAt;
  final String? endAt;
  Job({
    this.id,
    required this.title,
    this.sort,
    this.startAt,
    this.endAt,
  });
}

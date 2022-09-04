import 'package:top_yurist/data/Models/verify/verify.dart';

enum UploadImageTypes { diplom, passport, selfi, license, civilLicense }

String? getImageFromObject(
    {required UploadImageTypes type, required Verify verify}) {
  switch (type) {
    case UploadImageTypes.diplom:
      return verify.diplomaPhoto;
    case UploadImageTypes.passport:
      return verify.passportFrontPhoto;
    case UploadImageTypes.selfi:
      return verify.passportBackPhoto;
    case UploadImageTypes.license:
      return verify.licensePhoto;
    case UploadImageTypes.civilLicense:
      return verify.civilLicensePhoto;
    default:
      return null;
  }
}

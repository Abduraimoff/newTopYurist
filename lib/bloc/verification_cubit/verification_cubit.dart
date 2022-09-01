import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/verify/verify.dart';
import 'package:top_yurist/data/Repositories/profile_repository.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial()) {
    setup();
  }

  final _profileRepository = ProfileRepository();

  Future<void> setup() async {
    try {
      final verify = await _profileRepository.getLawyerStatus();
      emit(VerificationLoadedState(verify));
    } catch (e) {
      var verify = const Verify();
      emit(VerificationLoadedState(verify));
    }
  }

  Future<bool> verify() async {
    try {
      final verify = await _profileRepository
          .verify((state as VerificationLoadedState).verify);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void setTitle(String value) {
    final newVerify =
        (state as VerificationLoadedState).verify.copyWith(title: value);
    emit(VerificationLoadedState(newVerify));
  }

  void setDescription(String value) {
    final newVerify =
        (state as VerificationLoadedState).verify.copyWith(description: value);
    emit(VerificationLoadedState(newVerify));
  }

  void addEducation(Instution studie) {
    final verify = (state as VerificationLoadedState).verify;
    if (verify.studies == null) {
      final newVerify = verify.copyWith(studies: [studie]);
      emit(VerificationLoadedState(newVerify));
    } else {
      final newVerify =
          verify.copyWith(studies: List.of(verify.studies!)..add(studie));
      emit(VerificationLoadedState(newVerify));
    }
  }

  void deleteEducation(int index) {
    final verify = (state as VerificationLoadedState).verify;
    final newVerify =
        verify.copyWith(studies: List.of(verify.studies!)..removeAt(index));
    emit(VerificationLoadedState(newVerify));
  }

  void addJobExperences(Instution job) {
    final verify = (state as VerificationLoadedState).verify;
    if (verify.jobs == null) {
      final newVerify = verify.copyWith(jobs: [job]);
      emit(VerificationLoadedState(newVerify));
    } else {
      final newVerify = verify.copyWith(jobs: List.of(verify.jobs!)..add(job));
      emit(VerificationLoadedState(newVerify));
    }
  }

  void deleteJobExperences(int index) {
    final verify = (state as VerificationLoadedState).verify;
    final newVerify =
        verify.copyWith(jobs: List.of(verify.jobs!)..removeAt(index));
    emit(VerificationLoadedState(newVerify));
  }

  void addPassportFrontPhoto(String? image) {
    final verify = (state as VerificationLoadedState).verify;
    final newVerify = verify.copyWith(passportFrontPhoto: image);
    emit(VerificationLoadedState(newVerify));
  }

  void addPassportBackPhoto(String? image) {
    final verify = (state as VerificationLoadedState).verify;
    final newVerify = verify.copyWith(passportBackPhoto: image);
    emit(VerificationLoadedState(newVerify));
  }

  void addDiplomPhoto(String? image) {
    final verify = (state as VerificationLoadedState).verify;
    final newVerify = verify.copyWith(diplomaPhoto: image);
    emit(VerificationLoadedState(newVerify));
  }

  void addLicensePhotoPhoto(String? image) {
    final verify = (state as VerificationLoadedState).verify;
    final newVerify = verify.copyWith(licensePhoto: image);
    emit(VerificationLoadedState(newVerify));
  }

  void addExtractPhotoPhoto(String? image) {
    final verify = (state as VerificationLoadedState).verify;
    final newVerify = verify.copyWith(extractPhoto: image);
    emit(VerificationLoadedState(newVerify));
  }

  void addCivilLicensePhotoPhoto(String? image) {
    final verify = (state as VerificationLoadedState).verify;
    final newVerify = verify.copyWith(civilLicensePhoto: image);
    emit(VerificationLoadedState(newVerify));
  }
}

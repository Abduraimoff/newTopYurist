import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/verify/verify.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  var verify = Verify();

  void setTitle(String value) {
    verify.title = value;
  }

  void addEducation(Studie studie) {
    if (verify.studies == null) {
      verify.studies = [studie];
    } else {
      verify.studies?.add(studie);
    }
  }
}

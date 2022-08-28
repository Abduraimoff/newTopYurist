import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_yurist/data/Models/faq/faq.dart';
import 'package:top_yurist/data/Repositories/profile_repository.dart';

part 'faq_state.dart';

class FAQCubit extends Cubit<FaqState> {
  FAQCubit() : super(FaqInitial()) {
    getFAQ();
  }

  Future<void> getFAQ() async {
    final profileRepository = ProfileRepository();

    try {
      final faqs = await profileRepository.getFAQ();

      emit(FaqLoadedState(faqs));
    } catch (e) {}
  }
}
